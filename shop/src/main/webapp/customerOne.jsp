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
	<!-- Search Wrapper Area Start -->
	<div class="search-wrapper section-padding-100">
		<div class="search-close">
			<i class="fa fa-close" aria-hidden="true"></i>
		</div>
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="search-content">
						<form action="#" method="get">
							<input type="search" name="search" id="search"
								placeholder="Type your keyword...">
							<button type="submit">
								<img src="tmp2/img/core-img/search.png" alt="">
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Search Wrapper Area End -->

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

		<!-- Mobile Nav (max width 767px)-->
		<div class="mobile-nav">
			<!-- Navbar Brand -->
			<div class="amado-navbar-brand">
				<a href="index.html"><img src="tmp2/img/core-img/logo.png"
					alt=""></a>
			</div>
			<!-- Navbar Toggler -->
			<div class="amado-navbar-toggler">
				<span></span><span></span><span></span>
			</div>
		</div>

		<!-- Header Area Start -->
		<header class="header-area clearfix">
			<!-- Close Icon -->
			<div class="nav-close">
				<i class="fa fa-close" aria-hidden="true"></i>
			</div>
			<!-- Logo -->
			<div class="logo">
				<a href="<%=request.getContextPath()%>/Main.jsp"><img
					src="tmp2/img/core-img/CKEALOGO.png"></a>
			</div>
			<!-- Amado Nav -->
			<nav class="amado-nav">
				<ul>
					<li><a href="<%=request.getContextPath()%>/Main.jsp">Home</a></li>
					<li class="active"><a
						href="<%=request.getContextPath()%>/customerGoodslist.jsp">Shop</a></li>
					<li><a href="<%=request.getContextPath()%>/customerNoticelist.jsp">Notice</a></li>
					<li><a href="#">Contact</a></li>
				</ul>
			</nav>
			<br> <br>
			<!-- Cart Menu -->
			<div class="cart-fav-search mb-30">
				<a href="#" class="search-nav">Search</a>
				<%
				if (session.getAttribute("id") == null) {
				%>
				<a href="<%=request.getContextPath()%>/LoginForm.jsp"
					class="cart-nav">Cart<span>(0)</span></a> <a
					href="<%=request.getContextPath()%>/LoginForm.jsp" class="fav-nav">MyPage</a>
				<%
				} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
				%>
				<a href="<%=request.getContextPath()%>/Main.jsp" class="cart-nav">Cart<span>(0)</span></a>
				<a href="<%=request.getContextPath()%>/customerIndex.jsp"
					class="fav-nav">MyPage</a>
				<%
				}
				%>
				<%
				if (session.getAttribute("id") != null && session.getAttribute("user").equals("employee")) {
				%>
				<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp"
					class="fav-nav">AdminPage</a>
				<%
				}
				%>
			</div>
			<%
			if (session.getAttribute("id") != null) {
			%>
			<h5 style="font-family: 'Jua', sans-serif;"><%=session.getAttribute("id")%>(<%=session.getAttribute("name")%>)님
			</h5>
			<%
			}
			%>
			<!-- 로그인 아이디 -->

			<!-- Button Group -->
			<div class="amado-btn-group mt-30 mb-100">
				<%
				if (session.getAttribute("id") == null) {
				%>
				<a href="<%=request.getContextPath()%>/LoginForm.jsp"
					class="btn amado-btn mb-15">Log In</a>
				<%
				} else if (session.getAttribute("id") != null) {
				%>
				<a href="<%=request.getContextPath()%>/LogOut.jsp"
					class="btn amado-btn mb-15">Log Out</a>
				<%
				}
				%>
			</div>

			<!-- Social Button -->
			<div class="social-info d-flex justify-content-between">
				<a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a> <a
					href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a> <a
					href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a> <a
					href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
			</div>
		</header>
		<!-- Header Area End -->

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
	<!-- ##### Footer Area Start ##### -->
	<footer class="footer_area clearfix">
		<div class="container">
			<div class="row align-items-center">
				<!-- Single Widget Area -->
				<div class="col-12 col-lg-4">
					<div class="single_widget_area">
						<!-- Logo -->
						<div class="footer-logo mr-50">
							<a href="index.html"><img src="img/core-img/logo2.png" alt=""></a>
						</div>
						<!-- Copywrite Text -->
						<p class="copywrite">
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							Copyright &copy;
							<script>
								document.write(new Date().getFullYear());
							</script>
							All rights reserved | This template is made with <i
								class="fa fa-heart-o" aria-hidden="true"></i> by <a
								href="https://colorlib.com" target="_blank">Colorlib</a> &
							Re-distributed by <a href="https://themewagon.com/"
								target="_blank">Themewagon</a>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</div>
				</div>
				<!-- Single Widget Area -->
				<div class="col-12 col-lg-8">
					<div class="single_widget_area">
						<!-- Footer Menu -->
						<div class="footer_menu">
							<nav class="navbar navbar-expand-lg justify-content-end">
								<button class="navbar-toggler" type="button"
									data-toggle="collapse" data-target="#footerNavContent"
									aria-controls="footerNavContent" aria-expanded="false"
									aria-label="Toggle navigation">
									<i class="fa fa-bars"></i>
								</button>
								<div class="collapse navbar-collapse" id="footerNavContent">
									<ul class="navbar-nav ml-auto">
										<li class="nav-item active"><a class="nav-link"
											href="index.html">Home</a></li>
										<li class="nav-item"><a class="nav-link" href="shop.html">Shop</a>
										</li>
										<li class="nav-item"><a class="nav-link"
											href="product-details.html">Product</a></li>
										<li class="nav-item"><a class="nav-link" href="cart.html">Cart</a>
										</li>
										<li class="nav-item"><a class="nav-link"
											href="checkout.html">Checkout</a></li>
									</ul>
								</div>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- ##### Footer Area End ##### -->

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