<%@page import="service.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//오늘 방문자수, 총 방문자수
	CounterService counterService = new CounterService();
	int totalCounter = counterService.getTotalCount();
	int todayCounter = counterService.getTodayCount();
	int currentCount = (Integer)(application.getAttribute("currentCounter"));
	
	// 세션에 담긴 아이디값
	String customerId = (String) session.getAttribute("id");
	// 장바구니서비스 객체 생성
	CartService cartService = new CartService();
	int cnt = cartService.getCartCount(customerId);
%>
 <!-- Header Area Start -->
        <header class="header-area clearfix">
            <!-- Close Icon -->
            <div class="nav-close">
                <i class="fa fa-close" aria-hidden="true"></i>
            </div>
            <!-- Logo -->
            <div class="logo">
                <a href="<%=request.getContextPath()%>/Main.jsp"><img src="<%=request.getContextPath()%>/tmp2/img/core-img/CKEALOGO.png"></a>
            </div>
            <!-- Amado Nav -->
            <nav class="amado-nav">
                <ul>
                    <li><a href="<%=request.getContextPath()%>/Main.jsp">Home</a></li>
					<li><a href="<%=request.getContextPath()%>/customerGoodslist.jsp">Shop</a></li>
					<li><a href="<%=request.getContextPath()%>/customerNoticelist.jsp">Notice</a></li>
                </ul>
            </nav>
			<br>
			<br>
            <!-- Cart Menu -->
            <div class="cart-fav-search mb-30">
             <%
             	if(session.getAttribute("id") == null){
             %>  
                <a href="<%=request.getContextPath()%>/customerCart.jsp" class="cart-nav">Cart<span>(0)</span></a>
                <a href="<%=request.getContextPath()%>/LoginForm.jsp" class="fav-nav">MyPage</a>
            <%
             	} else if(session.getAttribute("id") != null && session.getAttribute("user").equals("customer") ){
            %>
            	<a href="<%=request.getContextPath()%>/customerCart.jsp" class="cart-nav">Cart<span>(<%=cnt%>)</span></a>
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
        </header>
        <!-- Header Area End -->