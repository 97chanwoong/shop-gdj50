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
	
	// 상품번호
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo + "<--goodsNo");
	
	int currentPage = 1; // 현재 페이지
	int ROW_PER_PAGE = 5; // 5개씩
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아오는 페이지 있을 시 현재페이지 변수에 담기
	}
	
	// 상세페이지 메서드
	GoodsService goodsService = new GoodsService();
	Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);
	
	//리뷰 가져오기
	ReviewService reviewService = new ReviewService();
	List<Map<String, Object>> list = reviewService.getReviewList(goodsNo, ROW_PER_PAGE, currentPage);
	// 마지막 페이지 메서드
	int lastPage = reviewService.OrdersLastPage(goodsNo, ROW_PER_PAGE);
	// 숫자페이징
	// ROW_PER_PAGE 가 10이면 1, 11, 21, 31...
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	//ROW_PER_PAGE 가 10 일경우 10, 20, 30, 40...
	int endPage = startPage + ROW_PER_PAGE - 1;
	// endPage < lastPage
	endPage = Math.min(endPage, lastPage); 
	
	// ordersNo값 list에서 빼오기
	int ordersNo = 0;
	for (Map<String, Object> m : list) {
		if (list != null) {
			ordersNo = Integer.parseInt(list.get(0).get("ordersNo").toString());
		}
	}
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
					<%
					if (request.getParameter("errorMsg") != null) {
					%>
					<span style="color: red"><%=request.getParameter("errorMsg")%></span>
					<%
					}
					%>
					<div class="col-12">
						<div class="Order-summary">
							<h5 style="font-family: 'Jua', sans-serif;">상품 상세보기</h5>
							<br>
							<div style="text-align: center;">
								<img
									src="<%=request.getContextPath()%>/upload/<%=map.get("fileName")%>"
									alt="제품이미지">
							</div>
							<br>
							<div style="text-align: right;">
								<a
									href="<%=request.getContextPath()%>/admin/adminUpdateGoodsOne.jsp?goodsNo=<%=map.get("goodsNo")%>"
									class="btn amado-btn w-30">수정</a>
							</div>
							<br>
							<table class="table table-borderless text-center">
								<thead class="thead-light"
									style="font-family: 'Jua', sans-serif;">
									<tr>
										<th>상품번호</th>
										<th>상품이름</th>
										<th>상품가격</th>
									</tr>
								</thead>
								<tbody style="font-family: 'Jua', sans-serif;">
									<tr>
										<td><%=map.get("goodsNo")%></td>
										<td><%=map.get("goodsName")%></td>
										<td><%=map.get("goodsPrice")%></td>
									</tr>
								</tbody>
								<thead class="thead-light"
									style="font-family: 'Jua', sans-serif;">
									<tr>
										<th>등록날짜</th>
										<th>수정날짜</th>
										<th>재고여부</th>
									</tr>
								</thead>
								<tbody style="font-family: 'Jua', sans-serif;">
									<tr>
										<td><%=map.get("createDate")%></td>
										<td><%=map.get("updateDate")%></td>
										<td><%=map.get("soldOut")%></td>
									</tr>
								</tbody>
								<thead class="thead-light"
									style="font-family: 'Jua', sans-serif;">
									<tr>
										<th>이미지이름</th>
										<th>파일이름</th>
										<th>확장자명</th>
									</tr>
								</thead>
								<tbody style="font-family: 'Jua', sans-serif;">
									<tr>
										<td><%=map.get("fileName")%></td>
										<td><%=map.get("originfileName")%></td>
										<td><%=map.get("contentType")%></td>
									</tr>
								</tbody>
							</table>
							<hr>

							<div class="form-gruop">
								<h2 style="font-family: 'Jua', sans-serif;">Review</h2>
								<table class="table table-striped text-center">
									<thead style="font-family: 'Jua', sans-serif;">
										<tr>
											<th>고객 아이디</th>
											<th>내용</th>
											<th>수정날짜</th>
											<th>작성날짜</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tbody style="font-family: 'Jua', sans-serif;">
										<%
											for (Map<String, Object> m : list) {
										%>
										<tr>
											<td style="font-size: 20px;"><%=m.get("customerId")%></td>
											<td style="font-size: 20px;"><%=m.get("reviewContents")%></td>
											<td style="font-size: 20px;"><%=m.get("updateDate")%></td>
											<td style="font-size: 20px;"><%=m.get("createDate")%></td>
											<td><button class="btn amado-btn"
													onclick="removeReviewBtn()">삭제</button></td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
								<div class="row">
									<div class="col-9"></div>
									<div class="col-2">
										<ul class="pagination justify-content-end">
											<%
											if (currentPage > 1) {
											%>
											<li class="page-item"><a class="page-link"
												href="<%=request.getContextPath()%>/adminGoodsOne.jsp?&goodsNo=<%=goodsNo%>&currentPage=<%=currentPage - 1%>">이전</a>
											</li>
											<%
											}

											// 숫자페이징
											for (int i = startPage; i <= endPage; i++) {
											if (i == currentPage) {
											%>
											<li class="page-item active"><a class="page-link"
												href="<%=request.getContextPath()%>/adminGoodsOne.jsp?&goodsNo=<%=goodsNo%>&currentPage=<%=i%>"><%=i%></a>
											</li>
											<%
											} else {
											%>
											<li class="page-item"><a class="page-link"
												href="<%=request.getContextPath()%>/adminGoodsOne.jsp?&goodsNo=<%=goodsNo%>&currentPage=<%=i%>"><%=i%></a>
											</li>
											<%
											}
											}

											if (currentPage < lastPage) {
											%>
											<li class="page-item"><a class="page-link"
												href="<%=request.getContextPath()%>/adminGoodsOne.jsp?&goodsNo=<%=goodsNo%>&currentPage=<%=currentPage + 1%>">다음</a>
											</li>
											<%
											}
											%>
										</ul>
									</div>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-1">
									<a
										href="<%=request.getContextPath()%>/admin/adminGoodslist.jsp"
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
<script>
function removeReviewBtn() {
	 var result = confirm("리뷰를 삭제하시겠습니까?");
	  if (result == true) {
		  location.href="<%=request.getContextPath()%>/admin/adminRemoveReviewOneAction.jsp?ordersNo=<%=ordersNo%>&&goodsNo=<%=map.get("goodsNo")%>";
		}
	}
</script>
</html>