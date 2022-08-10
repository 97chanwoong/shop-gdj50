<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="repository.*"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "index.jsp?errorMsg=No permission");
	}
	
	// 주문번호
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(ordersNo + "<-- ordersNo");
	
	
	// 주문상품 상세 보기 메서드
	OrdersService ordersService = new OrdersService();
	Map<String, Object> map = ordersService.getOrdersOne(ordersNo);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Woong Shop</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Colo Shop Template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="../tmp/styles/bootstrap4/bootstrap.min.css">
<link href="../tmp/plugins/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="../tmp/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css"
	href="../tmp/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css"
	href="../tmp/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="../tmp/styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="../tmp/styles/responsive.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
	<div class="super_container">

		<!-- Header -->

		<header class="header trans_300">

			<!-- Top Navigation -->

			<div class="top_nav">
				<div class="container">
					<div class="row">
						<div class="col-md-6">
							<div class="top_nav_left"></div>
						</div>
						<div class="col-md-6 text-right">
							<div class="top_nav_right">
								<ul class="top_nav_menu">

									<!-- Currency / Language / My Account -->

									<li class="currency"><a href="#"> KOR <i
											class="fa fa-angle-down"></i>
									</a>
										<ul class="currency_selection">
											<li><a href="#">cad</a></li>
											<li><a href="#">aud</a></li>
											<li><a href="#">eur</a></li>
											<li><a href="#">gbp</a></li>
										</ul></li>
									<li class="language"><a href="#"> Korean <i
											class="fa fa-angle-down"></i>
									</a>
										<ul class="language_selection">
											<li><a href="#">French</a></li>
											<li><a href="#">Italian</a></li>
											<li><a href="#">German</a></li>
											<li><a href="#">Spanish</a></li>
										</ul></li>
									<li class="account"><a href="#"> My Account <i
											class="fa fa-angle-down"></i>
									</a>
										<ul class="account_selection">
											<li><a href="#"><i class="fa fa-sign-in"
													aria-hidden="true"></i>Sign In</a></li>
											<li><a href="#"><i class="fa fa-user-plus"
													aria-hidden="true"></i>Register</a></li>
										</ul></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Main Navigation -->

			<div class="main_nav_container">
				<div class="container">
					<div class="row">
						<div class="col-lg-12 text-right">
							<div class="logo_container">
								<a href="#">Woong<span>shop</span></a>
							</div>
							<nav class="navbar">
								<ul class="navbar_menu">
									<li><a href="#">home</a></li>
									<li><a href="#">shop</a></li>
									<li><a href="#">promotion</a></li>
									<li><a href="#">pages</a></li>
									<li><a href="#">blog</a></li>
									<li><a href="contact.html">contact</a></li>
								</ul>
								<ul class="navbar_user">
									<li><a href="#"><i class="fa fa-search"
											aria-hidden="true"></i></a></li>
									<li><a href="#"><i class="fa fa-user"
											aria-hidden="true"></i></a></li>
									<li class="checkout"><a href="#"> <i
											class="fa fa-shopping-cart" aria-hidden="true"></i> <span
											id="checkout_items" class="checkout_items">0</span>
									</a></li>
								</ul>
								<div class="hamburger_container">
									<i class="fa fa-bars" aria-hidden="true"></i>
								</div>
							</nav>
						</div>
					</div>
				</div>
			</div>

		</header>
		<!-- Slider -->

		<!-- Banner -->
		<div class="login">
			<h2 style="text-align: center">주문 상세보기</h2>
			<div class="banner">
				<div class="container">
					<div class="row">
						<div class="col-md-5 table-responsive">
							<table class="table text-center">
 							 <tr>
							 	<th>상품번호</th>
							 	<td><%=map.get("goodsNo") %></td>
							 </tr>
							 <tr>
							 	<th>상품이름</th>
							 	<td><%=map.get("goodsName") %></td>
							 </tr>
							 <tr>
							 	<th>상품가격</th>
							 	<td><%=map.get("goodsPrice") %></td>
							 </tr>
							 <tr>
							 	<th>배송현황</th>
							 	<td><%=map.get("ordersState") %></td>
							 </tr>
							 <tr>
							 	<th>수정날짜</th>
							 	<td><%=map.get("updateDate") %></td>
							 </tr>
							</table>
						</div>
						<div class="col-md-1"></div>
						<div class="col-md-5 table-responsive">
							<table class="table text-center">
							 <tr>
							 	<th>고객아이디</th>
							 	<td><%=map.get("customerId") %></td>
							 </tr>
 							 <tr>
							 	<th>고객성함</th>
							 	<td><%=map.get("customerName") %></td>
							 </tr>
							 <tr>
							 	<th>고객연락처</th>
							 	<td><%=map.get("customerTelephone") %></td>
							 </tr>
							 <tr>
							 	<th>배송주소</th>
							 	<td><%=map.get("ordersAddress") %></td>
							 </tr>
							 <tr>
							 	<th>구매날짜</th>
							 	<td><%=map.get("createDate") %></td>
							 </tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Footer -->

		<footer class="footer">
			<div class="container">
				<div class="row">
					<div class="col-lg-6">
						<div
							class="footer_nav_container d-flex flex-sm-row flex-column align-items-center justify-content-lg-start justify-content-center text-center">
							<ul class="footer_nav">
								<li><a href="#">Blog</a></li>
								<li><a href="#">FAQs</a></li>
								<li><a href="contact.html">Contact us</a></li>
							</ul>
						</div>
					</div>
					<div class="col-lg-6">
						<div
							class="footer_social d-flex flex-row align-items-center justify-content-lg-end justify-content-center">
							<ul>
								<li><a href="#"><i class="fa fa-facebook"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-twitter"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-instagram"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-skype"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-pinterest"
										aria-hidden="true"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="footer_nav_container">
							<div class="cr">
								©2018 All Rights Reserverd. Made with <i class="fa fa-heart-o"
									aria-hidden="true"></i> by <a href="#">Colorlib</a> &amp;
								distributed by <a href="https://themewagon.com">ThemeWagon</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</footer>
	</div>
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="styles/bootstrap4/popper.js"></script>
	<script src="styles/bootstrap4/bootstrap.min.js"></script>
	<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
	<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
	<script src="plugins/easing/easing.js"></script>
	<script src="js/custom.js"></script>
</body>
</html>
