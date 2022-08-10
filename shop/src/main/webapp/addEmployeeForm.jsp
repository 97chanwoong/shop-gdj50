<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Woong Shop</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Colo Shop Template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="tmp/styles/bootstrap4/bootstrap.min.css">
<link href="tmp/plugins/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="tmp/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css"
	href="tmp/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css"
	href="tmp/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="tmp/styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="tmp/styles/responsive.css">
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
					<h1 style="text-align: center;">WoongShop</h1>
					<br>
					<div class="row">
						<div class="col-md-3"></div>
						<div class="col-md-6">
							<h3 style="text-align: center;">STAFF 회원가입</h3>
							<!-- id ck form -->
							<form action="<%=request.getContextPath()%>/idCheckAction.jsp" method="post">
								<input type="hidden" name="Identity" value="Employee">
								<table class="table">
								<tr>
									<th>아이디&nbsp;&nbsp;&nbsp;&nbsp;</th> <!-- 아이디 중복검사 -->
									<td>
										<div class="input-group mb-3">
											<input type="text"
												placeholder="아이디를 입력하세요" name="idck" id="idck" class="form-control">
										</div>	
									</td>
								</tr>
								</table>
								<div class="form-group">
								<button type="button" class="btn btn-secondary btn-block" id="idckBtn">중복검사</button>
								</div>
							</form>	
							<!-- 관리자 가입 form -->
							<form id="addEmployeeForm" action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="post">					
							<table class="table">
								<tr>
									<th>아이디</th>
									<th>
										<div class="input-guoup mb-3">
											<input type="text" class="form-control"
										  name="employeeId" id="employeeId" readonly="readonly">
										</div>
									</th>
								</tr>
								<tr>
									<th>비밀번호</th>
									<th>
									<div class="input-guoup mb-3">
									<input type="password" class="form-control"
										placeholder="비밀번호를 입력하세요" name="employeePass" id="employeePass">
									</div>
									</th>
								</tr>
								<tr>
									<th>이름</th>
									<th>
									<div class="input-guoup mb-3">
									<input type="text" class="form-control"
										placeholder="이름을 입력하세요" name="employeeName" id="employeeName">
									</div>
									</th>	
								</tr>
							</table>	
							<div class="form-group">
							<button  type="reset" class="btn btn-secondary  btn-block">초기화</button>
							<button  id="addBtn" type="button" class="btn btn-primary  btn-block">회원가입</button>
							</div>
							</form>
						</div>
						<div class="col-md-3"></div>
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
					<div class="col-lg-6"></div>
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
<script>
	// 직원 아이디 중복검사
	$('#idckBtn').click(function() {
		if ($('#idck').val().length < 4) {
			alert('아이디는 4자이상입력하세요');
		} else {
			// 비동기 호출   
			$.ajax({
				url : '/shop/idckController',
				type : 'post',
				data : {
					idck : $('#idck').val()
				},
				success : function(json) {
					if (json == 'y') {
						$('#employeeId').val($('#idck').val());
					} else {
						alert('이미 사용중인 아이디입니다');
						$('#employeeId').val('');
					}
				},
				,
				error : function(err) {
					alert('요청실패');
					console.log(err);
				}
			});
		}
	});
	// 직원 빈칸검사
	$('#addBtn').click(function(){		
		if($('#employeeId').val() == ''){
			alert('사원 아이디를 입력하세요');
		} else if($('#employeeIdPass').val() == ''){
			alert('사원 패스워드를 입력하세요');
		} else if($('#employeeIdName').val() == ''){
			alert('이름을 입력하세요');
		} else {
			$('#addEmployeeForm').submit();
		}
	});
</script>
</html>
