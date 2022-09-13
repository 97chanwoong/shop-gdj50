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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

	<!-- header -->
	<jsp:include page="../inc/header.jsp" />

		<div class="Order-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="Order-summary">
							<h5 style="font-family: 'Jua', sans-serif;">주문 상세보기</h5>
							<br>
							<div style="text-align: right;">
								<a
									href="<%=request.getContextPath()%>/admin/adminUpdateOrdersOne.jsp?ordersNo=<%=ordersNo%>"
									class="btn amado-btn w-30">수정</a>
							</div>
							<br>
							<table class="table table-borderless text-center">
								<thead class="thead-light"
									style="font-family: 'Jua', sans-serif;">
									<tr>
										<th>상품이름</th>
										<th>상품가격</th>
										<th>상품수량</th>
										<th>고객이름</th>
										<th>고객아이디</th>
										<th>고객연락처</th>
										<th>배송주소</th>
										<th>배송현황</th>
										<th>수정날짜</th>
										<th>주문날짜</th>
									</tr>
								</thead>
								<tbody style="font-family: 'Jua', sans-serif;">
									<tr>
										<td style="font-size:18px;"><%=map.get("goodsName")%></td>
										<td style="font-size:18px;"><%=map.get("ordersPrice")%></td>
										<td style="font-size:18px;"><%=map.get("ordersQuantity")%></td>
										<td style="font-size:18px;"><%=map.get("customerName")%></td>
										<td style="font-size:18px;"><%=map.get("customerId")%></td>
										<td style="font-size:18px;"><%=map.get("customerTelephone")%></td>
										<td style="font-size:18px;"><%=map.get("ordersAddress")%>-<%=map.get("ordersDeAddress")%></td>
										<td style="font-size:18px;"><%=map.get("ordersState")%></td>
										<td style="font-size:18px;"><%=map.get("updateDate")%></td>
										<td style="font-size:18px;"><%=map.get("createDate")%></td>
									</tr>
								</tbody>
							</table>
							<hr>
							<div class="row">
								<div class="col-1">
									<a
										href="<%=request.getContextPath()%>/admin/adminOrderslist.jsp"
										class="btn amado-btn w-30">목록</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ##### Main Content Wrapper End ##### -->
	<br>
	<br>
	<!-- footer -->
	<jsp:include page="../inc/footer.jsp" />

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
</html>