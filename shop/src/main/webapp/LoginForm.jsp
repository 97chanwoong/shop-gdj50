<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
</style>
<!-- Title  -->
<title>CKEA</title>

<!-- Favicon  -->
<link rel="icon" href="tmp2/img/core-img/CKEAfavicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet" href="tmp2/css/core-style2.css">
<link rel="stylesheet" href="tmp2/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

		<!-- header -->
		<jsp:include page="/inc/header.jsp" />

		<div class="login-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12 col-lg-6">
						<div class="login-summary">
							<h5 style="font-family: 'Jua', sans-serif;">고객 로그인</h5>
							<br>
							<form id="customerForm" method="post"
								action="<%=request.getContextPath()%>/customerLoginAction.jsp">
								<%
								if (request.getParameter("errorMsg") != null) {
								%>
								<span style="color: red"><%=request.getParameter("errorMsg")%></span>
								<%
								}
								%>
								<div class="form-group">
									<input style="font-family: 'Jua', sans-serif;" type="text" class="form-control" name="customerId"
										id="customerId" placeholder="아이디">
								</div>
								<div class="form-group">
									<input style="font-family: 'Jua', sans-serif;" type="password" class="form-control" name="customerPass"
										id="customerPass" placeholder="비밀번호">
								</div>
								<div class="amoda-btn mt-70">
									<button type="button" class="btn login-btn w-100"
										id="customerBtn"
										style="font-family: 'Jua', sans-serif;">Login</button>
									<br>
									<br>
									<a  href="addCustomerForm.jsp" class="btn amado-btn w-100" style="font-family: 'Jua', sans-serif;">Sing Up</a>
								</div>
							</form>
						</div>
					</div>
					<div class="col-12 col-lg-6">
						<div class="login-summary">
							<h5 style="font-family: 'Jua', sans-serif;">관리자 로그인</h5>
							<br>
							<form id="employeeForm" method="post"
								action="<%=request.getContextPath()%>/employeeLoginAction.jsp">
									<%
										if (request.getParameter("errorMsg") != null) {
									%>
											<span style="color: red"><%=request.getParameter("errorMsg")%></span>
									<%
										}
									%>
								<div class="form-group">
									<input style="font-family: 'Jua', sans-serif;" type="text" class="form-control" name="employeeId"
										id="employeeId" placeholder="아이디">
								</div>
								<div class="form-group">
									<input style="font-family: 'Jua', sans-serif;" type="password" class="form-control" name="employeePass"
										id="employeePass" placeholder="비밀번호">
								</div>
							</form>
							<div class="amoda-btn mt-70">
								<button style="font-family: 'Jua', sans-serif;" type="button" class="btn login-btn w-100"
									id="employeeBtn">Login</button>
									<br>
									<br>
								<a style="font-family: 'Jua', sans-serif;" href="addEmployeeForm.jsp" class="btn amado-btn w-100">Sing Up</a>
							</div>
						</div>
					</div>
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
	$('#customerBtn').click(function(){
		if($('#customerId').val() == '') {
			alert('고객 아이디를 입력하세요');
		} else if($('#customerPass').val() == '') {
			alert('고객 패스워드를 입력하세요');
		} else {
			customerForm.submit();
		}
	});
	
	$('#employeeBtn').click(function(){
		if($('#employeeId').val() == '') {
			alert('관리자 아이디를 입력하세요');
		} else if($('#employeePass').val() == '') {
			alert('관리자 패스워드를 입력하세요');
		} else {
			employeeForm.submit();
		}
	});
</script>
</html>