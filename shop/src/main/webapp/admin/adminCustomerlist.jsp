<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="repository.*"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/customerIndex.jsp?errorMsg=No permission");
	}
	
	// 페이징
	int currentPage = 1; // 현재 페이지
	int ROW_PER_PAGE = 10; // 10개씩
	
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아오는 페이지 있을 시 현재페이지 변수에 담기
	}
	
	// 메서드를 위한 객체 생성
	CustomerService customerService = new CustomerService();
	
	// 마지막 페이지 메서드
    int	lastPage = customerService.getCustomerLastPage(ROW_PER_PAGE);
	
	// 숫자페이징
	// ROW_PER_PAGE 가 10이면 1, 11, 21, 31...
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	//ROW_PER_PAGE 가 10 일경우 10, 20, 30, 40...
	int endPage = startPage + ROW_PER_PAGE - 1;
	// endPage < lastPage
	endPage = Math.min(endPage, lastPage); 
	
	// 리스트
	List<Customer> list = customerService.getCustomerList(ROW_PER_PAGE, currentPage);
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
<link rel="icon" href="../tmp2/img/core-img/CKEAfavicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet" href="../tmp2/css/core-style2.css">
<link rel="stylesheet" href="../tmp2/css/core-style6.css">
<link rel="stylesheet" href="../tmp2/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">


	<!-- header -->
	<jsp:include page="../inc/header.jsp" />

		<div class="Customer-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<%
					if (request.getParameter("errorMsg") != null) {
					%>
					<span style="color: red"><%=request.getParameter("errorMsg")%></span>
					<%
					}
					%>
					<div class="col-12">
						<div class="Customer-summary">
							<h5 style="font-family: 'Jua', sans-serif;">고객 리스트</h5>
							<br>
							<table class="table table-hover text-center">
								<thead class="thead-light"
									style="font-family: 'Jua', sans-serif;">
									<tr>
										<th>고객 아이디</th>
										<th>고객 이름</th>
										<th>주소</th>
										<th>전화번호</th>
										<th>가입날짜</th>
									</tr>
								</thead>
								<tbody style="font-family: 'Jua', sans-serif;">
									<%
									for (Customer c : list) {
									%>
									<tr>
										<td><a style="font-size:20px; color:#1521b5;"  href="<%=request.getContextPath()%>/admin/customerOrderslist.jsp?customerId=<%=c.getCustomerId()%>"><%=c.getCustomerId()%></a></td>
										<td><a style="font-size:20px; color:#1521b5;"  href="<%=request.getContextPath()%>/admin/adminCustomerOne.jsp?customerId=<%=c.getCustomerId()%>"><%=c.getCustomerName()%></a></td>
										<td><%=c.getCustomerAddress()%>-<%=c.getCustomerDeAddress()%></td>
										<td><%=c.getCustomerTelephone()%></td>
										<td><%=c.getCreateDate()%></td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
							<hr>
							<div class="row">
								<div class="col-2">
									<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp" class="btn amado-btn w-50">목록</a>
								</div>
								<div class="col-8"></div>
								<div class="col-2">
								<ul class="pagination justify-content-end">
									<%
									if (currentPage > 1) {
									%>
									<li class="page-item"><a
										class="page-link"
										href="<%=request.getContextPath()%>/admin/adminCustomerlist.jsp?currentPage=<%=currentPage - 1%>">이전</a>
									</li>
									<%
									}

									// 숫자페이징
									for (int i = startPage; i <= endPage; i++) {
									if (i == currentPage) {
									%>
									<li class="page-item active"><a
										class="page-link"
										href="<%=request.getContextPath()%>/admin/adminCustomerlist.jsp?currentPage=<%=i%>"><%=i%></a>
									</li>
									<%
									} else {
									%>
									<li class="page-item"><a
										class="page-link"
										href="<%=request.getContextPath()%>/admin/adminCustomerlist.jsp?currentPage=<%=i%>"><%=i%></a>
									</li>
									<%
									}
									}

									if (currentPage < lastPage) {
									%>
									<li class="page-item"><a
										class="page-link"
										href="<%=request.getContextPath()%>/admin/adminCustomerlist.jsp?currentPage=<%=currentPage + 1%>">다음</a>
									</li>
									<%
									}
									%>
								</ul>
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