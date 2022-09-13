<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="service.*"%>
<%
	// 공지번호 정보 받아오기
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// 공지사항 상세보기 메서드실행
	NoticeService noticeService = new NoticeService();
	Map<String,Object> map = noticeService.getNoticeOne(noticeNo);	
	
	//오늘 방문자수, 총 방문자수
	CounterService counterService = new CounterService();
	int totalCounter = counterService.getTotalCount();
	int todayCounter = counterService.getTodayCount();
	int currentCount = (Integer) (application.getAttribute("currentCounter"));
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
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
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

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

	<!-- header -->
	<jsp:include page="/inc/header.jsp" />

		<div class="shop_sidebar_area" style="background-color:#ffffff;"></div>
		

		<div class="amado_product_area section-padding-100">
			<div class="container-fluid">
				<br>

				<div class="container-fulid">
					<h1 style="text-align: center;"><span>공지사항</span></h1>
					<br>
					<!-- 공지사항 테이블 -->
					<table class="table text-left">
							<tr>
								<td>No.<%=map.get("noticeNo")%></td>
								<td><%=map.get("noticeTitle")%></td>
								<td style="text-align:right"><%=map.get("createDate")%></td>
							</tr>
							<tr>
								<td colspan="3">
									<%=map.get("noticeContent")%>
								</td>
							<tr>
					</table>
					<hr>
					<div class="row">
					<div class="col-2">
						 <a href="<%=request.getContextPath()%>/customerNoticelist.jsp" class="btn amado-btn w-30">목록</a>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
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