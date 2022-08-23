<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="service.*"%>
<%
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
// GoodsService 생성
GoodsService goodsService = new GoodsService();
// 상품 상세보기 메서드
Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);

// ReviewService 생성
ReviewService reviewService = new ReviewService();
// 리뷰 메서드
List<Map<String, Object>> list = reviewService.getReviewList(goodsNo);
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

<!-- Title  -->
<title>Amado - Furniture Ecommerce Template | Product Details</title>

<!-- Favicon  -->
<link rel="icon"
	href="<%=request.getContextPath()%>/tmp2/img/core-img/favicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/tmp2/css/core-style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/tmp2/style.css">

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
								<img
									src="<%=request.getContextPath()%>/tmp2/img/core-img/search.png"
									alt="">
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
				<a href="index.html"><img
					src="<%=request.getContextPath()%>/tmp2/img/core-img/logo.png"
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
				<a href="index.html"><img
					src="<%=request.getContextPath()%>/tmp2/img/core-img/logo.png"
					alt=""></a>
			</div>
			<!-- Amado Nav -->
			<nav class="amado-nav">
				<ul>
					<li><a href="<%=request.getContextPath()%>/tmp2/index.html">Home</a></li>
					<li><a href="<%=request.getContextPath()%>/tmp2/shop.html">Shop</a></li>
					<li class="<%=request.getContextPath()%>/tmp2/active"><a
						href="product-details.html">Product</a></li>
					<li><a href="<%=request.getContextPath()%>/tmp2/cart.html">Cart</a></li>
					<li><a href="<%=request.getContextPath()%>/tmp2/checkout.html">Checkout</a></li>
				</ul>
			</nav>
			<!-- Button Group -->
			<div class="amado-btn-group mt-30 mb-100">
				<a href="#" class="btn amado-btn mb-15">%Discount%</a> <a href="#"
					class="btn amado-btn active">New this week</a>
			</div>
			<!-- Cart Menu -->
			<div class="cart-fav-search mb-100">
				<a href="<%=request.getContextPath()%>/tmp2/cart.html"
					class="cart-nav"> <img
					src="<%=request.getContextPath()%>/tmp2/img/core-img/cart.png"
					alt=""> Cart <span>(0)</span>
				</a> <a href="<%=request.getContextPath()%>/tmp2/#" class="fav-nav">
					<img
					src="<%=request.getContextPath()%>/tmp2/img/core-img/favorites.png"
					alt=""> Favourite
				</a> <a href="<%=request.getContextPath()%>/tmp2/#" class="search-nav">
					<img
					src="<%=request.getContextPath()%>/tmp2/img/core-img/search.png"
					alt=""> Search
				</a>
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

		<!-- Product Details Area Start -->
		<div class="single-product-area section-padding-100 clearfix">
			<div class="container-fluid">

				<div class="row">
					<div class="col-12">
						<nav aria-label="breadcrumb">
							<ol class="breadcrumb mt-50">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item"><a href="#">Shop</a></li>
							</ol>
						</nav>
					</div>
				</div>

				<div class="row">
					<div class="col-12 col-lg-6">
						<div class="single_product_thumb">
							<div class="carousel-item active">
								<a class="gallery_img"
									href="<%=request.getContextPath()%>/upload/<%=map.get("fileName")%>">
									<img class="d-block w-100"
									src='<%=request.getContextPath()%>/upload/<%=map.get("fileName")%>'>
								</a>
							</div>
						</div>
					</div>
					<div class="col-12 col-lg-6">
						<div class="single_product_desc">
							<!-- Product Meta Data -->
							<div class="product-meta-data">
								<h1 class="mb-30" style="text-align: center;"><%=map.get("goodsName")%></h1>
								<hr>
								<!-- Ratings & Review -->
								<!--                                 <div class="ratings-review mb-15 d-flex align-items-center justify-content-between">
                                    <div class="ratings">
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                    </div>
                                    <div class="review">
                                        <a href="#">Write A Review</a>
                                    </div>
                                </div> -->
								<!-- Avaiable -->
								<div class="container">
									<p class="avaibility"
										style="font-size: 20px; text-align: right;">
										<i class="fa fa-circle"
											style="font-size: 20px; text-align: right;"></i>&nbsp;품절여부 :
										<%=map.get("soldOut")%>
									</p>
									<br>
									<h3 class="product-price mb-50"
										style="font-size: 50px; text-align: right;"><%=map.get("goodsPrice")%>원
									</h3>
								</div>
							</div>
							<hr>
							<!--상품 설명 -->
							<!-- <div class="short_overview my-5">
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
									Aliquid quae eveniet culpa officia quidem mollitia impedit iste
									asperiores nisi reprehenderit consequatur, autem, nostrum
									pariatur enim?</p>
							</div> -->

							<!-- Add to Cart Form -->
							<form class="cart clearfix" action="#" method="post">
								<div class="container qty-btn d-flex">
									<p>Qty</p>
									<div class="quantity">
										<input type="number" id="cartQuantity" step="1" value="1"
											min="1" max="5" name="cartQuantity">
									</div>
								</div>
							</form>
							<br>
							<div class="container">
								<button type="button" name="addCartBtn"
									class="btn amado-btn w-100" value="5">Add to cart</button>
							</div>
						</div>
					</div>
					<h1>Reviews</h1>
					<hr>
					<%
					for (Map<String, Object> m : list) {
					%>
					<table class="table">
						<tr>
							<td><%=m.get("customerId")%>의 리뷰</td>
							<td class="text-right"><%=m.get("createDate")%>에 작성</td>
						</tr>
						<tr>
							<td>
								<div>
									<p><%=m.get("reviewContents")%></p>
								</div>
							</td>
							<td>
								<div  class="text-right">
									<p><%=m.get("updateDate")%>에 수정</p>
								</div>
							</td>
						</tr>
						<%
							}
						%>
					</table>
				</div>
			</div>
		</div>
		<!-- Product Details Area End -->
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
						</p>
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
											href="<%=request.getContextPath()%>/tmp2/index.html">Home</a>
										</li>
										<li class="nav-item"><a class="nav-link"
											href="<%=request.getContextPath()%>/tmp2/shop.html">Shop</a>
										</li>
										<li class="nav-item"><a class="nav-link"
											href="<%=request.getContextPath()%>/tmp2/product-details.html">Product</a>
										</li>
										<li class="nav-item"><a class="nav-link"
											href="<%=request.getContextPath()%>/tmp2/cart.html">Cart</a>
										</li>
										<li class="nav-item"><a class="nav-link"
											href="<%=request.getContextPath()%>/tmp2/checkout.html">Checkout</a>
										</li>
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
	<script
		src="<%=request.getContextPath()%>/tmp2/js/jquery/jquery-2.2.4.min.js"></script>
	<!-- Popper js -->
	<script src="<%=request.getContextPath()%>/tmp2/js/popper.min.js"></script>
	<!-- Bootstrap js -->
	<script src="<%=request.getContextPath()%>/tmp2/js/bootstrap.min.js"></script>
	<!-- Plugins js -->
	<script src="<%=request.getContextPath()%>/tmp2/js/plugins.js"></script>
	<!-- Active js -->
	<script src="<%=request.getContextPath()%>/tmp2/js/active.js"></script>

</body>

</html>