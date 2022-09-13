<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="service.*"%>
<%
	int ROW_PER_PAGE = 10;
	if (request.getParameter("ROW_PER_PAGE") != null) {
		ROW_PER_PAGE = Integer.parseInt(request.getParameter("ROW_PER_PAGE"));
	}
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	NoticeService noticeService = new NoticeService();
	
	// 리스트 보여지는 형식
	int check = 0;
	if (request.getParameter("check") != null) {
		check = Integer.parseInt(request.getParameter("check"));
		System.out.println(check + "리스트 확인 테스트용");
	}
	
	// 마지막 페이지 메서드
	int lastPage = noticeService.getNoticeLastPage(ROW_PER_PAGE);
	// 숫자페이징
	// ROW_PER_PAGE 가 10이면 1, 11, 21, 31...
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	//ROW_PER_PAGE 가 10 일경우 10, 20, 30, 40...
	int endPage = startPage + ROW_PER_PAGE - 1;
	// endPage < lastPage
	endPage = Math.min(endPage, lastPage);
	
	// list
	List<Notice> list = noticeService.getNoticeList(ROW_PER_PAGE, currentPage);
	
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
					<table class="table text-center">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성날짜</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (Notice n : list) {
							%>
							<tr>
								<td><%=n.getNoticeNo()%></td>
								<td><a style="font-size:18px;" 
									href="<%=request.getContextPath()%>/customerNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
								<td><%=n.getCreateDate()%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<div class="row">
					<div class="col-2"></div>
					<div class="col-8"></div>
					<div class="col-2">
						<ul class="pagination justify-content-end">
							<%
							if (currentPage > 1) {
							%>
							<li class="page-item"><a class="page-link"
								href="<%=request.getContextPath()%>/customerNoticelist.jsp?currentPage=<%=currentPage - 1%>&ROW_PER_PAGE=<%=ROW_PER_PAGE%>">이전</a>
							</li>
							<%
							}

							// 숫자페이징
							for (int i = startPage; i <= endPage; i++) {
							if (i == currentPage) {
							%>
							<li class="page-item active"><a class="page-link"
								href="<%=request.getContextPath()%>/customerNoticelist.jsp?currentPage=<%=i%>&ROW_PER_PAGE=<%=ROW_PER_PAGE%>"><%=i%></a>
							</li>
							<%
							} else {
							%>
							<li class="page-item"><a class="page-link"
								href="<%=request.getContextPath()%>/customerNoticelist.jsp?currentPage=<%=i%>&ROW_PER_PAGE=<%=ROW_PER_PAGE%>"><%=i%></a>
							</li>
							<%
							}
							}

							if (currentPage < lastPage) {
							%>
							<li class="page-item"><a class="page-link"
								href="<%=request.getContextPath()%>/customerNoticelist.jsp?currentPage=<%=currentPage + 1%>&ROW_PER_PAGE=<%=ROW_PER_PAGE%>">다음</a>
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