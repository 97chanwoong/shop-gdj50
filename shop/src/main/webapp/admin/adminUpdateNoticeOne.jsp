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
	// noticeNo 값 받아오기
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// 디버깅
	System.out.println(noticeNo + "<-- noticeNo");
	
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
<link rel="stylesheet" href="../tmp2/css/core-style4.css">
<link rel="stylesheet" href="../tmp2/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">
	
	<!-- header -->
	<jsp:include page="../inc/header.jsp" />

		<div class="Notice-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="Notice-summary">
							<h5 style="font-family: 'Jua', sans-serif;">공지 수정</h5>
							<br> 
							<form id="updateNoticeForm"
								action="<%=request.getContextPath()%>/admin/adminUpdateNoticeOneAction.jsp"
								method="post">
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="noticeNo" class="form-group">번호
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="noticeNo" id="noticeNo" readonly="readonly" value="<%=noticeNo%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="noticeTitle" class="form-group">제목
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="noticeTitle" id="noticeTitle"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="noticeContent" class="form-group" >내용
								</label> 
								<textarea style="font-family:'Jua', sans-serif;font-size: 25px; width: 100%;" 
								          name="noticeContent" id="noticeContent" rows="5" cols="50" class="form-control"></textarea>
								<br>
								<br>
								<div class="form-group">
									<a href="<%=request.getContextPath()%>/admin/adminNoticelist.jsp" type="button"
										class="btn amado-btn w-100" 
										style="font-family: 'Jua', sans-serif; font-size: 30px;">이전</a>	
									<br>
									<br>
									<button type="reset"
									        class="btn amado-btn w-100"
									        style="font-family: 'Jua', sans-serif; font-size:30px;" >초기화</button>	
								</div>
								<br>
								<div class="form-group">	
									<button id="updateBtn" type="button"
											class="btn login-btn w-100"
											style="font-family: 'Jua', sans-serif; font-size:30px;">공지 수정</button> 
								</div>			       
							</form>
							<br>
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
	$('#updateBtn').click(function(){
		if($('#noticeTitle').val().length == "") {
			alert('제목을 입력하세요');
		} else if($('#noticeContent').val()==''){
			alert('내용을 입력해주세요');
		} else {
			updateNoticeForm.submit();
		}
	});
</script>
</html>