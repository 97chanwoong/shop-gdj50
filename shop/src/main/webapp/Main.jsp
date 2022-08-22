<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*"%>
<%
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
<!-- font -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
</style>
<!-- Title  -->
<title>CKEA</title>

<!-- Favicon  -->
<link rel="icon" href="tmp2/img/core-img/CKEAfavicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet" href="tmp2/css/core-style.css">
<link rel="stylesheet" href="tmp2/style.css">
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
                            <input type="search" name="search" id="search" placeholder="Type your keyword...">
                            <button type="submit"><img src="tmp2/img/core-img/search.png" alt=""></button>
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
                <a href="index.html"><img src="tmp2/img/core-img/logo.png" alt=""></a>
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
                <a href="<%=request.getContextPath()%>/Main.jsp"><img src="tmp2/img/core-img/CKEALOGO.png"></a>
            </div>
            <!-- Amado Nav -->
            <nav class="amado-nav">
                <ul>
                    <li class="active"><a href="<%=request.getContextPath()%>/Main.jsp">Home</a></li>
					<li><a href="<%=request.getContextPath()%>/customerGoodslist.jsp">Shop</a></li>
					<li><a href="#">Community</a></li>
					<li><a href="#">Contact</a></li>
                </ul>
            </nav>
			<br>
			<br>
            <!-- Cart Menu -->
            <div class="cart-fav-search mb-30">
                <a href="#" class="search-nav">Search</a>
             <%
             	if(session.getAttribute("id") == null){
             %>  
                <a href="<%=request.getContextPath()%>/LoginForm.jsp" class="cart-nav">Cart<span>(0)</span></a>
                <a href="<%=request.getContextPath()%>/LoginForm.jsp" class="fav-nav">MyPage</a>
            <%
             	} else if(session.getAttribute("id") != null && session.getAttribute("user").equals("customer") ){
            %>
            	<a href="<%=request.getContextPath()%>/Main.jsp" class="cart-nav">Cart<span>(0)</span></a>
                <a href="<%=request.getContextPath()%>/customerIndex.jsp" class="fav-nav">MyPage</a>
            <%
             	} 
            %>
            <%
         		if(session.getAttribute("id") != null && session.getAttribute("user").equals("employee")){
            %>	
            	<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp" class="fav-nav">AdminPage</a>
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
             	if(session.getAttribute("id") != null){
            %>
			<h5 style="font-family: 'Jua', sans-serif;"><%=session.getAttribute("id")%>(<%=session.getAttribute("name")%>)님</h5>
			<%
             	}
			%>
			<!-- 로그인 아이디 -->
            <!-- Button Group -->
            <div class="amado-btn-group mt-30 mb-100">
             <%
             	if(session.getAttribute("id") == null){
             %>  
                <a href="<%=request.getContextPath()%>/LoginForm.jsp" class="btn amado-btn mb-15">Log In</a>
            <%
             	} else if(session.getAttribute("id") != null){
            %>
            	<a href="<%=request.getContextPath()%>/LogOut.jsp" class="btn amado-btn mb-15">Log Out</a>
            <%
             	}
            %>
            </div>

            <!-- Social Button -->
            <div class="social-info d-flex justify-content-between">
                <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            </div>
        </header>
        <!-- Header Area End -->

        <!-- Product Catagories Area Start -->
        <div class="products-catagories-area clearfix">
            <div class="amado-pro-catagory clearfix">

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="tmp2/img/bg-img/1.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $180</p>
                            <h4>Modern Chair</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="tmp2/img/bg-img/2.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $180</p>
                            <h4>Minimalistic Plant Pot</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="tmp2/img/bg-img/3.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $180</p>
                            <h4>Modern Chair</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="tmp2/img/bg-img/4.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $180</p>
                            <h4>Night Stand</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="tmp2/img/bg-img/5.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $18</p>
                            <h4>Plant Pot</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="tmp2/img/bg-img/6.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $320</p>
                            <h4>Small Table</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="tmp2/img/bg-img/7.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $318</p>
                            <h4>Metallic Chair</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="tmp2/img/bg-img/8.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $318</p>
                            <h4>Modern Rocking Chair</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="shop.html">
                        <img src="tmp2/img/bg-img/9.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>From $318</p>
                            <h4>Home Deco</h4>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <!-- Product Catagories Area End -->
    </div>
    <!-- ##### Main Content Wrapper End ##### -->

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
                        <p class="copywrite"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a> & Re-distributed by <a href="https://themewagon.com/" target="_blank">Themewagon</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                    </div>
                </div>
                <!-- Single Widget Area -->
                <div class="col-12 col-lg-8">
                    <div class="single_widget_area">
                        <!-- Footer Menu -->
                        <div class="footer_menu">
                            <nav class="navbar navbar-expand-lg justify-content-end">
                                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#footerNavContent" aria-controls="footerNavContent" aria-expanded="false" aria-label="Toggle navigation"><i class="fa fa-bars"></i></button>
                                <div class="collapse navbar-collapse" id="footerNavContent">
									<ul class="navbar-nav ml-auto">
										<li class="nav-item active"><a class="nav-link"
											href="<%=request.getContextPath()%>/Main.jsp">Home</a></li>
										<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customerGoodslist.jsp">Shop</a>
										</li>
										<li class="nav-item"><a class="nav-link" href="#">Community</a>
										</li>
										<li class="nav-item"><a class="nav-link"
											href="#">Contact</a></li>
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