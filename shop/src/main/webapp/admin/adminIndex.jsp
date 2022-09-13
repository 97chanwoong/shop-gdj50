<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") == null){
	response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
	return;
    } else if(session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
    response.sendRedirect(request.getContextPath() + "customerIndex.jsp?errorMsg=No permission");
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
<link rel="stylesheet" href="../tmp2/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

	<!-- header -->
	<jsp:include page="../inc/header.jsp" />

		<div class="login-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-8">
						<div class="login-summary">
							<h1 style="font-family: 'Jua', sans-serif; text-align: center;"><%=session.getAttribute("id")%>님 
								</h1>
							<br>
							<hr>
							<p style="font-family: 'Jua', sans-serif; text-align: center;">
								<a  style="font-size:20px;" 
								    href="<%=request.getContextPath()%>/admin/adminEmployeelist.jsp">사원 관리</a>
							</p>
							<hr>
							<p style="font-family: 'Jua', sans-serif; text-align: center;">
								<a  style="font-size:20px;" 
								    href="<%=request.getContextPath()%>/admin/adminGoodslist.jsp">상품 관리</a>
							</p>
							<hr>
							<p style="font-family: 'Jua', sans-serif; text-align: center;">
								<a  style="font-size:20px;" 
								    href="<%=request.getContextPath()%>/admin/adminOrderslist.jsp">주문 관리</a>
							</p>
							<hr>
							<p style="font-family: 'Jua', sans-serif; text-align: center;">
								<a  style="font-size:20px;" 
								    href="<%=request.getContextPath()%>/admin/adminMonthOrders.jsp">월별 통계</a>
							</p>
							<hr>
							<p style="font-family: 'Jua', sans-serif; text-align: center;">
								<a  style="font-size:20px;" 
								    href="<%=request.getContextPath()%>/admin/adminCustomerlist.jsp">고객 관리</a>
							</p>
							<hr>
							<p style="font-family: 'Jua', sans-serif; text-align: center;">
								<a  style="font-size:20px;" 
								    href="<%=request.getContextPath()%>/admin/adminNoticelist.jsp">공지 관리</a>
							</p>
							<hr>
							<p style="font-family: 'Jua', sans-serif; text-align: center;">
								<a  style="font-size:20px;" 
								    href="<%=request.getContextPath()%>/removeIdForm.jsp">탈퇴 하기</a>
							</p>
							<hr>	    
						</div>
					</div>
					<div class="col-md-2"></div>
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

</html>