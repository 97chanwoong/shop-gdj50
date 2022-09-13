<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("employee")) {
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp?errorMsg=No permission");
	}
	
	request.setCharacterEncoding("utf-8");
	String customerId = request.getParameter("customerId");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	
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
<link rel="icon" href="tmp2/img/core-img/CKEAfavicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet" href="tmp2/css/core-style2.css">
<link rel="stylesheet" href="tmp2/css/core-style4.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

	<!-- header -->
	<jsp:include page="/inc/header.jsp" />

		<div class="Notice-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="Notice-summary">
							<h5 style="font-family: 'Jua', sans-serif;">리뷰 작성</h5>
							<br>
							<form
								action="<%=request.getContextPath()%>/customerAddReviewAction.jsp"
								method="post" id="addReviewForm">
								<input type="hidden" name="customerId" value="<%=customerId%>" >
								<input type="hidden" name="ordersNo" value="<%=ordersNo%>" >
								<label
									   style="font-family: 'Jua', sans-serif; font-size: 30px;"
									   for="reviewContents" class="form-group">리뷰내용 
							    </label>
								<textarea
									   style="font-family: 'Jua', sans-serif; font-size: 25px; width: 100%;"
									   name="reviewContents" id="reviewContents" rows="5" cols="50" 
									   class="form-control"></textarea>
								<br> 
								<br>
								<div class="form-group">
									<button type="reset" class="btn amado-btn w-100"
										style="font-family: 'Jua', sans-serif; font-size: 30px;">초기화</button>
								</div>
								<br>
								<div class="form-group">
									<button id="addBtn" type="button" class="btn login-btn w-100"
										style="font-family: 'Jua', sans-serif; font-size: 30px;">리뷰 작성</button>
								</div>
							</form>
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
<script>
	$('#addBtn').click(function() {
		if ($('#reviewContents').val()==''){
			alert('리뷰내용을 입력해주세요');
		} else {
			$('#addReviewForm').submit();
		}
	});
</script>
</html>