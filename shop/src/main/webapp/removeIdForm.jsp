<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

		<div class="login-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						<div class="login-summary">
							<h2 style="font-family: 'Jua', sans-serif; text-align: center;">탈퇴 하기</h2>
							<br> 
							<form id="removeForm" 
								  action="<%=request.getContextPath()%>/removeIdAction.jsp" method="post">
								<label style="font-family: 'Jua', sans-serif;" for="Pass">비밀번호</label>
								<input style="font-family: 'Jua', sans-serif;" 
									   type="password" class="form-control" name="Pass"
										id="Pass">
							<br>
							<div class="form-group">	
								<button id="removebtn" type="button"
										class="btn amado-btn w-100"
										style="font-family: 'Jua', sans-serif;">탈퇴</button> 
							</div>			       
							</form>
						</div>
					</div>
					<div class="col-md-3"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- ##### Main Content Wrapper End ##### -->
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
<script>
// 비밀번호 빈칸 검사
	$('#removebtn').click(function(){
		if($('#Pass').val() == '') {
			alert('패스워드를 입력하세요');
		} else {
			removeForm.submit();
		}
	});
</script>
</html>