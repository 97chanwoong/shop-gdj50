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
		response.sendRedirect(request.getContextPath() + "customerIndex.jsp?errorMsg=No permission");
	}
	// 오더정보 받아오기
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	// 디버깅
	System.out.println(goodsNo + "<-- goodsNo");
	
	Map<String, Object> goods = new GoodsService().getGoodsAndImgOne(goodsNo);
	System.out.println(goods.get("fileName")+"<---fileName");
	
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

	<!-- header -->
	<jsp:include page="../inc/header.jsp" />

		<div class="Order-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="Order-summary">
							<h5 style="font-family: 'Jua', sans-serif;">상품 수정</h5>
							<br> 
								<form action="<%=request.getContextPath()%>/admin/adminUpdateGoodsOneAction.jsp" method="post" id="updateGoodsForm" enctype="multipart/form-data">
								<input type="hidden" name="preImg"  value="<%=goods.get("fileName")%>">
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="goodsNo" class="form-group">상품 번호
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="goodsNo" id="goodsNo" readonly="readonly" value="<%=goods.get("goodsNo")%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="goodsName" class="form-group">상품 이름
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="goodsName" id="goodsName" type="text"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="goodsPrice" class="form-group">상품 가격
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="goodsPrice" id="goodsPrice" type="text"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="soldOut" class="form-group">품절 여부
								</label> 
								<br>
								<select id="soldOut" name="soldOut" >
										<option value="default">-------품절 여부--------</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
								</select>
								<br>
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="imgFile" class="form-group">파일
								</label>
								<br> 
								<input  name="imgFile" id="imgFile" type="file"
										class="form-control"> 
								<br>
								<br>
								<div class="form-group">
									<a href="<%=request.getContextPath()%>/admin/adminGoodsOne.jsp?goodsNo=<%=goodsNo%>" type="button"
										class="btn amado-btn w-100" 
										style="font-family: 'Jua', sans-serif; font-size: 30px;">이전</a>	
									<br>
									<br>
									<button type="reset"
								        class="btn amado-btn w-100"
								        style="font-family: 'Jua', sans-serif; font-size:30px;" >초기화</button>	
								</div>
								<br>
								<div class="form-group">	
									<button id="updateBtn" type="button"
										class="btn login-btn w-100"
										style="font-family: 'Jua', sans-serif; font-size:30px;">상품 수정</button> 
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ##### Main Content Wrapper End ##### -->
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
	$('#updateBtn').click(function(){
		if($('#goodsName').val().length == "") {
			alert('상품 이름을 입력하세요');
		} else if($('#goodsPrice').val() == "") {
			alert('상품 가격을 입력하세요');
		} else if($('#soldOut').val() == 'default') {
			alert('품절 여부를 선택하세요'); 
		} else if($('#imgFile').val() == "") {
			alert('파일을 선택하세요'); 
		} else {
			updateGoodsForm.submit();
		}	
	});
</script>
</html>