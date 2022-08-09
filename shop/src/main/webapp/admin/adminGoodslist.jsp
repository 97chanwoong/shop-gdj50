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
		response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=No permission");
	}
	
	// 페이징
	int currentPage = 1; // 현재 페이지
	int ROW_PER_PAGE = 10; // 10개씩
	
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아오는 페이지 있을 시 현재페이지 변수에 담기
	}
	
	// 메서드를 위한 객체 생성
	GoodsService goodsService = new GoodsService();
	
	// 마지막 페이지 메서드
    int	lastPage = goodsService.getGoodsLastPage(ROW_PER_PAGE);
	
	// 리스트
	List<Goods> list = new ArrayList<Goods>();
	list = goodsService.getGoodsListByPage(ROW_PER_PAGE, currentPage);
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
			<div class="banner">
				<div class="container">
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-10 table-responsive">
							<h2 style="text-align: center">상품관리</h2>
							<%
							if (request.getParameter("errorMsg") != null) {
							%>
							<span style="color: red"><%=request.getParameter("errorMsg")%></span>
							<%
								}
							%>
							<div class="text-right">
								<a class="btn btn-light" href="<%=request.getContextPath()%>/admin/addGoodsForm.jsp">상품추가</a>
							</div>
							<br>
							<table class="table text-center">
								<thead class="thead-light">
									<tr>
										<th>상품번호</th>
										<th>상품이름</th>
										<th>상품가격</th>
										<th>등록날짜</th>
										<th>수정날짜</th>
										<th>품절여부</th>
									</tr>
								</thead>
								<tbody>
									<%
									for (Goods g : list) {
									%>
									<tr>
										<td><%=g.getGoodsNo()%></td>
										<td><a  href="<%=request.getContextPath()%>/admin/GoodsImgOne.jsp?goodsNo=<%=g.getGoodsNo()%>"><%=g.getGoodsName()%></a></td>
										<td><%=g.getGoodsPrice()%></td>
										<td><%=g.getUpdateDate()%></td>
										<td><%=g.getCreateDate()%></td>
										<td>
											<form action="<%=request.getContextPath()%>/admin/updateSoldOut.jsp" method="post">
				            					<input type="hidden" name="employeeId" value="<%=g.getGoodsNo()%>">
				            					<select name="soldOut">
				            						<%
				            							if(g.getSoldOut().equals("Y")) {
				            						%>
						            						<option value="Y">Y</option>
						            						<option value="N">N</option>
				            						<%
				            							} else {
				            						%>
						            						<option value="N">N</option>
					            							<option value="Y">Y</option>
				            						<%
				            							}
				            						%>
				            					</select>
				            					<button type="submit" class="btn btn-outline-dark">품절변경</button> 
				            				</form>
				            			</td>
									</tr>
									<%
										}
									%>
								</tbody>
							</table>
							<div class="text-center">
								<ul class="pagination pagination-sm justify-content-end">
									<%
									if (currentPage > 1) {
									%>
									<li class="page-item disabled"><a class="page-link"
										href="<%=request.getContextPath()%>/adminGoodslist.jsp?currentPage=<%=currentPage - 1%>>">이전
									</a></li>
									<%
										}
									%>
									<%
									if (currentPage < lastPage) {
									%>
									<li class="page-item"><a class="page-link"
										href="<%=request.getContextPath()%>/adminGoodslist.jsp?currentPage=<%=currentPage + 1%>>">다음
									</a></li>
									<%
										}
									%>
								</ul>
							</div>
							<div class="col-md-1"></div>
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