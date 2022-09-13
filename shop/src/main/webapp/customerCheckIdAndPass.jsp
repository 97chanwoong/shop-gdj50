<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="service.*"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("employee")) {
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp?errorMsg=No permission");
	}

	String customerId = (String)session.getAttribute("Id");
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

<style>
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap')
	;
</style>
<!-- Title  -->
<title>CKEA</title>

<!-- Favicon  -->
<link rel="icon" href="tmp2/img/core-img/CKEAfavicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet" href="tmp2/css/core-style2.css">
<link rel="stylesheet" href="tmp2/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

	<!-- header -->
	<jsp:include page="/inc/header.jsp" />

		<div class="shop_sidebar_area" style="background-color: #ffffff;"></div>


		<div class="amado_product_area section-padding-100">
			<div class="container-fluid">
				<br>
				<div class="container-fulid">
					<div class="row">
					<div class="col-1"></div>
						<div class="col-8">
							<h1 class="mb-50" style="text-align: center;">
								<span>본인 확인</span>
							</h1>
							<br>
							<!-- 본인확인 -->
							<form id="customerCheckForm" method="post"
								action="<%=request.getContextPath()%>/customerCheckIdAndPassAction.jsp">
								<%
								if (request.getParameter("errorMsg") != null) {
								%>
								<span style="color: red"><%=request.getParameter("errorMsg")%></span>
								<%
								}
								%>
								<div class="form-group">
									<input type="hidden" class="form-control" name="customerId" value="<%=session.getAttribute("id")%>">
								</div>
								<div class="form-group">
									PASSWORD <input type="password" class="form-control"
										name="customerPass" id="customerPass"
										placeholder="비밀번호를 입력하세요">
								</div>
								<div class="amoda-btn mt-70 mb-100">
									<button type="button" class="btn login-btn w-100"
										id="customerBtn" style="font-family: 'Jua', sans-serif;">본인확인</button>
								</div>
							</form>
							<br>
							<div class="row">
								<div class="col-2">
									<a href="<%=request.getContextPath()%>/customerIndex.jsp"
										class="btn amado-btn w-30">목록</a>
								</div>
							</div>
						</div>
						<div class="col-3"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!-- footer -->
	<jsp:include page="/inc/footer.jsp" />	

	<!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
	<script src="tmp2/js/jquery/jquery-2.2.4.min.js"></script>
	<!-- Popper js -->
	<script src="tmp2/js/popper.min.js"></script>
	<!-- Bootstrap js -->
	<script src="tmp2/js/bootstrap.min.js"></script>
	<!-- Plugins js -->
	<script src="tmp2/js/plugins.js"></script>
	<!-- Active js -->
	<script src="tmp2/js/active.js"></script>
</body>
<script>
	$('#customerBtn').click(function() {
		if ($('#customerPass').val() == '') {
			alert('비밀번호를 입력하세요');
		} else {
			customerCheckForm.submit();
		}
	});
</script>
</html>