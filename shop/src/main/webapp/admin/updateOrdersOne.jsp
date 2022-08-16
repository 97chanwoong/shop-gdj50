<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="repository.*"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>	
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm2.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "index.jsp?errorMsg=No permission");
	} 
	// 오더정보 받아오기
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String goodsName = request.getParameter("goodsName");
	int ordersQuantity = Integer.parseInt(request.getParameter("ordersQuantity"));
	int ordersPrice = Integer.parseInt(request.getParameter("ordersPrice"));
	String customerName = request.getParameter("customerName");
	String customerTelephone = request.getParameter("customerTelephone");
	String customerId = request.getParameter("customerId");
	String createDate = request.getParameter("createDate");
	// 디버깅
	System.out.println(ordersNo + "<-- ordersNo");
	System.out.println(goodsName + "<-- goodsName");
	System.out.println(ordersQuantity + "<-- ordersQuantity");
	System.out.println(ordersPrice+ "<-- ordersPrice");
	System.out.println(customerName + "<-- customerName");
	System.out.println(customerTelephone + "<-- customerTelephone");
	System.out.println(customerId + "<-- customerId");
	System.out.println(createDate + "<-- createDate");
	
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
<link rel="stylesheet" href="../tmp2/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
								<img src="../tmp2/img/core-img/search.png" alt="">
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
				<a href="LoginForm2.jsp"><img
					src="../tmp2/img/core-img/CKEALOGO.png" alt=""></a>
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
					src="../tmp2/img/core-img/CKEALOGO.png" alt=""></a>
			</div>
			<!-- Amado Nav -->
			<nav class="amado-nav">
				<ul>
					<li><a href="<%=request.getContextPath()%>/Main.jsp">Home</a></li>
					<li><a href="shop.html">Shop</a></li>
					<li><a href="#">Community</a></li>
					<li><a href="#">Contact</a></li>
				</ul>
			</nav>

		</header>
		<!-- Header Area End -->

		<div class="Order-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12 col-sm-6">
						<div class="Order-summary">
							<h5 style="font-family: 'Jua', sans-serif;">주문 수정(상품정보)</h5>
							<br> 
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="goodsName" class="form-group">상품 이름
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="goodsName" id="goodsName" readonly="readonly" value="<%=goodsName%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="ordersPrice" class="form-group">상품 가격
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="goodsPrice" id="goodsPrice" readonly="readonly" value="<%=ordersPrice%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="ordersQuantity" class="form-group">상품 수량
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="ordersQuantity" id="ordersQuantity" readonly="readonly" value="<%=ordersQuantity%>"
										class="form-control"> 
								<br>
						</div>
					</div>
					<div class="col-12 col-sm-6">
						<div class="Order-summary">
							<h5 style="font-family: 'Jua', sans-serif;">주문 수정(고객정보)</h5>
							<br> 
							<form id="updateOrdersForm"
								action="<%=request.getContextPath()%>/admin/updateOrdersOneAction.jsp"
								method="post">
								<input type="hidden" id="ordersNo" name="ordersNo" value="<%=ordersNo%>">
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="customerName" class="form-group">고객 이름
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="customerName" id="customerName" readonly="readonly" value="<%=customerName%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="customerId" class="form-group">고객 아이디
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="customerId" id="customerId" readonly="readonly" value="<%=customerId%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="customerTelephone" class="form-group" >고객 연락처
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="customerTelephone" id="customerTelephone" readonly="readonly" value="<%=customerTelephone%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="ordersAddress" class="form-group">배송 주소
								</label> 
								
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										type="text"
										name="ordersAddress" id="ordersAddress"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:35px;"
										for="ordersState">배송 현황
								</label>
								<br>
								<select id="ordersState" name="ordersState" >
										<option value="default">------- 주문상황--------</option>
										<option value="결제대기">결제 대기</option>
										<option value="주문완료">주문 완료</option>
										<option value="배송준비중">배송 준비중</option>
										<option value="배송중">배송 중</option>
										<option value="배송완료">배송 완료</option>
								</select>
							<br>
							<br>
							<div class="form-group">
								<button type="reset"
								        class="btn amado-btn w-100"
								        style="font-family: 'Jua', sans-serif; font-size:30px;" >초기화</button>	
							</div>
							<br>
							<div class="form-group">	
								<button id="updateBtn" type="button"
										class="btn login-btn w-100"
										style="font-family: 'Jua', sans-serif; font-size:30px;">주문 수정</button> 
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
	<!-- ##### Footer Area Start ##### -->
	<footer class="footer_area clearfix mt-100">
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
								href="https://colorlib.com" target="_blank">Colorlib</a>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							& Re-distributed by <a href="https://themewagon.com/"
								target="_blank">Themewagon</a>
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
											href="<%=request.getContextPath()%>/Main.jsp">Home</a></li>
										<li class="nav-item"><a class="nav-link" href="shop.html">Shop</a>
										</li>
										<li class="nav-item"><a class="nav-link" href="#">Community</a>
										</li>
										<li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
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
		if($('#ordersAddress').val().length == "") {
			alert('배송지를 입력하세요');
		} else if($('#ordersState').val() == 'default') {
			alert('배송현황을 선택하세요');
		} else {
			updateOrdersForm.submit();
		}
	});
</script>
</html>