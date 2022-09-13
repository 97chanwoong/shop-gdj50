<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="repository.*"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/customerIndex.jsp?errorMsg=No permission");
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<!-- font -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap')
	;
</style>
<!-- Title  -->
<title>CKEA</title>

<!-- Favicon  -->
<link rel="icon" href="../tmp2/img/core-img/CKEAfavicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet" href="../tmp2/css/core-style2.css">
<link rel="stylesheet" href="../tmp2/css/core-style5.css">
<link rel="stylesheet" href="../tmp2/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">
	
	<!-- header -->
	<jsp:include page="../inc/header.jsp" />
		<div class="Order-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<%
					if (request.getParameter("errorMsg") != null) {
					%>
					<span style="color: red"><%=request.getParameter("errorMsg")%></span>
					<%
					}
					%>
					<div class="col-2"></div>
					<div class="col-8">
						<div class="Order-summary">
							<h5 style="font-family: 'Jua', sans-serif;">상품 등록</h5>
							<br>
							<form action="<%=request.getContextPath()%>/admin/adminAddGoodsAction.jsp" method="post" enctype="multipart/form-data" id="addGoodsform">
								<label style="font-family: 'Jua', sans-serif;" for="goodsName">상품이름</label>
								<input style="font-family: 'Jua', sans-serif;" 
									   type="text" class="form-control" name="goodsName"
										id="goodsName" >
								<label style="font-family: 'Jua', sans-serif;" for="goodsPrice">상품가격</label>
								<input style="font-family: 'Jua', sans-serif;" 
									   type="text" class="form-control" name="goodsPrice"
										id="goodsPrice" >		
								<label style="font-family: 'Jua', sans-serif;" for="imgFile">상품이미지</label>
								<input style="font-family: 'Jua', sans-serif;" 
									   type="file" class="form-control" name="imgFile"
										id="imgFile" >
								<label style="font-family: 'Jua', sans-serif;" for="soldOut">품절여부</label>
								<br>	
									<select name="soldOut" class="form-control" id="soldOut">
										<option value="defualt">-- 선택 --</option>
			            				<option value="Y">Y</option>
				            			<option value="N">N</option>
				            		</select>
				            	<br>
				            	<br>		
								<div class="form-group">
								<button id="addGoodsBtn" type="button"
										class="btn amado-btn w-100"
										style="font-family: 'Jua', sans-serif;">상품등록</button>
								<br>	
								<br>	
								<a href="<%=request.getContextPath()%>/admin/adminGoodslist.jsp" type="button"
										class="btn amado-btn w-100"
										style="font-family: 'Jua', sans-serif;">이전</a>
								</div>
							</form>	
						</div>
					</div>
					<div class="col-2"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- ##### Main Content Wrapper End ##### -->
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<!-- footer -->
	<jsp:include page="../inc/footer.jsp" />

	<!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
	<script src="../tmp2/js/jquery/jquery-2.2.4.min.js"></script>
	<!-- Popper js -->
	<script src="../tmp2/js/popper.min.js"></script>
	<!-- Bootstrap js -->
	<script src="../tmp2/js/bootstrap.min.js"></script>
	<!-- Plugins js -->
	<script src="../tmp2/js/plugins.js"></script>
	<!-- Active js -->
	<script src="../tmp2/js/active.js"></script>
</body>
<script>
		$('#addGoodsBtn').click(function(){
			if($('#goodsName').val().length == ""){
				alert('상품이름을 기입해주세요');
			} else if($('#goodsPrice').val().length == ""){
				alert('상품가격을 기입해주세요');
			} else if($('#imgFile').val().length == ""){
				alert('상품파일을 등록해주세요');
			} else if($('#soldOut').val() == 'defualt'){
				alert('품절여부를 선택해주세요');
			} else {
				$('#addGoodsform').submit();
			}
		});
</script>
</html>