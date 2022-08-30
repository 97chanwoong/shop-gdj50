<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="service.*"%>
<%
// controller : java class <- Servlet
	int ROW_PER_PAGE = 20;
	if (request.getParameter("ROW_PER_PAGE") != null) {
		ROW_PER_PAGE = Integer.parseInt(request.getParameter("ROW_PER_PAGE"));
	}
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	GoodsService goodsService = new GoodsService();
	
	// 리스트 보여지는 형식
	int check = 0;
	if (request.getParameter("check") != null) {
		check = Integer.parseInt(request.getParameter("check"));
		System.out.println(check + "리스트 확인 테스트용");
	} 
	
	// 마지막 페이지 메서드
	int lastPage = goodsService.getGoodsLastPage(ROW_PER_PAGE);
	// 숫자페이징
	// ROW_PER_PAGE 가 10이면 1, 11, 21, 31...
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	//ROW_PER_PAGE 가 10 일경우 10, 20, 30, 40...
	int endPage = startPage + ROW_PER_PAGE - 1;
	// endPage < lastPage
	endPage = Math.min(endPage, lastPage); 
	
	// list
	List<Map<String, Object>> list = goodsService.getCustomerGoodsListByPage(ROW_PER_PAGE, currentPage, check);
	
	//오늘 방문자수, 총 방문자수
	CounterService counterService = new CounterService();
	int totalCounter = counterService.getTotalCount();
	int todayCounter = counterService.getTodayCount();
	int currentCount = (Integer)(application.getAttribute("currentCounter"));
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
					<li><a href="#">Community</a></li>
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
			<div class="mt-30 mb-50">
				오늘 방문자 수 : <%=todayCounter%><br>
				총 방문자 수 :  <%=totalCounter%><br>
				현재 접속자 수 : <%=currentCount%><br>
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

		<div class="shop_sidebar_area">

			<!-- ##### Single Widget ##### -->
			<div class="widget catagory mb-50">
				<!-- Widget Title -->
				<h6 class="widget-title mb-30">Catagories</h6>

				<!--  Catagories  -->
				<div class="catagories-menu">
					<ul>
						<li>
                     <%if(check==0){ %>
                        <a style="font-family: 'Jua', sans-serif; color: #00498D"
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=0">인기순
                        </a>
                     <%} %>
                     <%if(check!=0){ %>
                        <a style="font-family: 'Jua', sans-serif; "
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=0">인기순
                        </a>
                     <%} %>
                     </li>
                  <li>   
                     <%if(check==1){ %>
                        <a style="font-family: 'Jua', sans-serif; color: #00498D"
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=1">최신순
                        </a>
                     <%} %>
                     <%if(check!=1){ %>
                        <a style="font-family: 'Jua', sans-serif; "
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=1">최신순
                        </a>
                     <%} %></li>
                  <li>         
                     <%if(check==2){ %>
                        <a style="font-family: 'Jua', sans-serif; color: #00498D"
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=2">판매량순
                        </a>
                     <%} %>
                     <%if(check!=2){ %>
                        <a style="font-family: 'Jua', sans-serif; "
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=2">판매량순
                        </a>
                     <%} %></li>
                  <li>         
                     <%if(check==3){ %>
                        <a style="font-family: 'Jua', sans-serif; color: #00498D"
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=3">높은 가격순
                        </a>
                     <%} %>
                     <%if(check!=3){ %>
                        <a style="font-family: 'Jua', sans-serif; "
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=3">높은 가격순
                        </a>
                     <%} %></li>
                  <li>         
                     <%if(check==4){ %>
                        <a style="font-family: 'Jua', sans-serif; color: #00498D"
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=4">낮은 가격순
                        </a>
                     <%} %>
                     <%if(check!=4){ %>
                        <a style="font-family: 'Jua', sans-serif;"
                        href="<%=request.getContextPath()%>/customerGoodslist.jsp?check=4">낮은 가격순
                        </a>
                     <%} %></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="amado_product_area section-padding-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-2">
						<div
							class="product-topbar d-xl-flex align-items-end justify-content-between">
							<!-- Sorting -->
							<div class="product-sorting d-flex">
								<div class="view-product d-flex align-items-center">
									<p>View</p>
									<select name="select" id="viewProduct"
										onchange="window.open(value,'_self');">
										<%
											if (ROW_PER_PAGE == 20) {
										%>
											<option
												value="<%=request.getContextPath()%>/customerGoodslist.jsp?ROW_PER_PAGE=20"
												selected>20
											</option>
										<%
											} else {
										%>
											<option
											value="<%=request.getContextPath()%>/customerGoodslist.jsp?ROW_PER_PAGE=20">20
											</option>
										<%
											}
										%>
										<%
											if (ROW_PER_PAGE == 40) {
										%>
											<option
												value="<%=request.getContextPath()%>/customerGoodslist.jsp?ROW_PER_PAGE=40"
												selected>40
											</option>
										<%
											} else {
										%>
											<option
												value="<%=request.getContextPath()%>/customerGoodslist.jsp?ROW_PER_PAGE=40">40
											</option>
										<%
											}
										%>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="col-8"></div>
					<div class="col-2">
						<ul class="pagination justify-content-end">
						   <%
                           		if (currentPage > 1) {
                           %>
	                           <li class="page-item"><a
	                              class="page-link"
	                              href="<%=request.getContextPath()%>/customerGoodslist.jsp?currentPage=<%=currentPage - 1%>&ROW_PER_PAGE=<%=ROW_PER_PAGE%>">이전</a>
	                           </li>
                           <%
                           		}

	                           // 숫자페이징
	                           for (int i = startPage; i <= endPage; i++) {
	                           if (i == currentPage) {
                           %>
	                           <li class="page-item active"><a
	                              class="page-link"
	                              href="<%=request.getContextPath()%>/customerGoodslist.jsp?currentPage=<%=i%>&ROW_PER_PAGE=<%=ROW_PER_PAGE%>"><%=i%></a>
	                           </li>
                           <%
                          	 } else {
                           %>
                           <li class="page-item"><a
                              class="page-link"
                              href="<%=request.getContextPath()%>/customerGoodslist.jsp?currentPage=<%=i%>&ROW_PER_PAGE=<%=ROW_PER_PAGE%>"><%=i%></a>
                           </li>
                           <%
                          	 	}
                          	 }

                           if (currentPage < lastPage) {
                           %>
                           <li class="page-item"><a
                              class="page-link"
                              href="<%=request.getContextPath()%>/customerGoodslist.jsp?currentPage=<%=currentPage + 1%>&ROW_PER_PAGE=<%=ROW_PER_PAGE%>">다음</a>
                           </li>
                           <%
                          	 }
                           %>
						</ul>
					</div>
				</div>
				<br>
				<div class="row">

					<!-- Single Product Area -->
					<%
					for (Map<String, Object> m : list) {
					%>
					<div class="col-12 col-sm-6 col-md-12 col-xl-3">
						<div class="single-product-wrapper">
							<!-- Product Image -->
							<div class="product-img">
								<a
									href="<%=request.getContextPath()%>/customerGoodsOne.jsp?goodsNo=<%=m.get("goodsNo")%>"><img
									src='<%=request.getContextPath()%>/upload/<%=m.get("fileName")%>'>
								</a>
								<!-- <!-- Hover Thumb -->
								<!--  <img class="hover-img" src="img/product-img/product2.jpg" alt=""> -->
							</div>

							<!-- Product Description -->
							<div
								class="product-description d-flex align-items-center justify-content-between">
								<!-- Product Meta Data -->
								<div class="product-meta-data">
									<div class="line"></div>
									<p class="product-price"><%=m.get("goodsPrice")%></p>
									<h4><%=m.get("goodsName")%></h4>
									
								</div>
								<!-- Ratings & Cart -->
								<div class="ratings-cart text-right">
									<!-- <div class="ratings">
										<i class="fa fa-star" aria-hidden="true"></i> <i
											class="fa fa-star" aria-hidden="true"></i> <i
											class="fa fa-star" aria-hidden="true"></i> <i
											class="fa fa-star" aria-hidden="true"></i> <i
											class="fa fa-star" aria-hidden="true"></i>
									</div> -->
									<div class="cart">
										<a href="customerCartAction.jsp?goodsNo=<%=m.get("goodsNo")%>&goodsPrice=<%=m.get("goodsPrice")%>&cartQuantity=1" data-toggle="tooltip"
											data-placement="left" title="Add to Cart"><img
											src="tmp2/img/core-img/cart.png" alt=""></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>
	<!-- ##### Main Content Wrapper End ##### -->

	<!-- ##### Newsletter Area Start ##### -->
	<section class="newsletter-area section-padding-100-0">
		<div class="container">
			<div class="row align-items-center">
				<!-- Newsletter Text -->
				<div class="col-12 col-lg-6 col-xl-7">
					<div class="newsletter-text mb-100">
						<h2>
							Subscribe for a <span>25% Discount</span>
						</h2>
						<p>Nulla ac convallis lorem, eget euismod nisl. Donec in
							libero sit amet mi vulputate consectetur. Donec auctor interdum
							purus, ac finibus massa bibendum nec.</p>
					</div>
				</div>
				<!-- Newsletter Form -->
				<div class="col-12 col-lg-6 col-xl-5">
					<div class="newsletter-form mb-100">
						<form action="#" method="post">
							<input type="email" name="email" class="nl-email"
								placeholder="Your E-mail"> <input type="submit"
								value="Subscribe">
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ##### Newsletter Area End ##### -->

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