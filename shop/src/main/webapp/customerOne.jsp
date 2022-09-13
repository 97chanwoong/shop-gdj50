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
	
	// customerId 값 받아오기
	String customerId = request.getParameter("customerId");
	
	// customerService
	CustomerService customerService = new CustomerService();
	
	Map<String,Object> map = customerService.getCustomerOne(customerId);
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
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
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

		<div class="shop_sidebar_area" style="background-color:#ffffff;"></div>
		

		<div class="amado_product_area section-padding-100">
			<div class="container-fluid">
				<br>

				<div class="container-fulid">
					<h1 style="text-align: center;"><span><%=customerId%>님 회원정보</span></h1>
					<br>
					<!-- 나의 정보 확인 테이블 -->
					<table class="table text-center">
						<tbody class="center">	
							<tr>
								<td colspan="2">아이디</td>
								<td colspan="2"><%=map.get("customerId") %></td>
							</tr>
							<tr>
								<td colspan="2">이름</td>
								<td colspan="2"><%=map.get("customerName") %></td>
							</tr>
							<tr>
								<td colspan="2">주소</td>
								<td colspan="2"><%=map.get("customerAddress")%> / <%=map.get("customerDeAddress") %></td>
							</tr>
							<tr>
								<td colspan="2">연락처</td>
								<td colspan="2"><%=map.get("customerTelephone") %></td>
							</tr>
							<tr>
								<td colspan="2">수정날짜</td>
								<td colspan="2"><%=map.get("updateDate") %></td>
							</tr>
							<tr>
								<td colspan="2">가입날짜</td>
								<td colspan="2"><%=map.get("createDate") %></td>
							</tr>
						</tbody>	
					</table>
					<div class="row">
					<div class="col-2">
						<a href="<%=request.getContextPath()%>/customerIndex.jsp" class="btn amado-btn w-30">목록</a>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>
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
</html>