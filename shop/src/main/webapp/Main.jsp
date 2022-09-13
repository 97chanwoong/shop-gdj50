<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*"%>
<%
	//오늘 방문자수, 총 방문자수
	CounterService counterService = new CounterService();
	int totalCounter = counterService.getTotalCount();
	int todayCounter = counterService.getTodayCount();
	int currentCount = (Integer)(application.getAttribute("currentCounter"));
	String customerId = (String) session.getAttribute("id");
	CartService cartService = new CartService();
	int cnt = cartService.getCartCount(customerId);
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

    <!-- ##### Main Content Wrapper Start ##### -->
    <div class="main-content-wrapper d-flex clearfix">

       	<!-- header -->
 		<jsp:include page="/inc/header.jsp" />

        <!-- Product Catagories Area Start -->
        <div class="products-catagories-area clearfix">
            <div class="amado-pro-catagory clearfix">

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="<%=request.getContextPath()%>/customerGoodslist.jsp">
                        <img src="tmp2/img/bg-img/1.jpg" alt="">
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="<%=request.getContextPath()%>/customerGoodslist.jsp">
                        <img src="tmp2/img/bg-img/2.jpg" alt="">
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="<%=request.getContextPath()%>/customerGoodslist.jsp">
                        <img src="tmp2/img/bg-img/3.jpg" alt="">
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="<%=request.getContextPath()%>/customerGoodslist.jsp">
                        <img src="tmp2/img/bg-img/4.jpg" alt="">
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="<%=request.getContextPath()%>/customerGoodslist.jsp">
                        <img src="tmp2/img/bg-img/5.jpg" alt="">
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="<%=request.getContextPath()%>/customerGoodslist.jsp">
                        <img src="tmp2/img/bg-img/6.jpg" alt="">
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="<%=request.getContextPath()%>/customerGoodslist.jsp">
                        <img src="tmp2/img/bg-img/7.jpg" alt="">
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="<%=request.getContextPath()%>/customerGoodslist.jsp">
                        <img src="tmp2/img/bg-img/8.jpg" alt="">
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="<%=request.getContextPath()%>/customerGoodslist.jsp">
                        <img src="tmp2/img/bg-img/9.jpg" alt="">
                    </a>
                </div>
            </div>
        </div>
        <!-- Product Catagories Area End -->
    </div>
    <!-- ##### Main Content Wrapper End ##### -->

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