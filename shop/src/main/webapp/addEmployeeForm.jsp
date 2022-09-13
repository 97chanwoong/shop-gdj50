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
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap')
	;
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
							<h2 style="font-family: 'Jua', sans-serif; text-align: center;">관리자
								회원가입</h2>
							<br> 
							<label style="font-family: 'Jua', sans-serif;"
								for="idck" class="form-group">아이디
							</label> 
							<input
								style="font-family: 'Jua', sans-serif;" type="text"
								placeholder="아이디를 입력하세요" name="idck" id="idck"
								class="form-control"> 
							<br>
							<div class="form-group" style="text-align: right;">
								<button type="button" class="btn login-btn w-10" id="idckBtn"
									style="font-family: 'Jua', sans-serif;">ID 중복검사</button>
							</div>
							<hr>
							<form id="addEmployeeForm"
								action="<%=request.getContextPath()%>/addEmployeeAction.jsp"
								method="post">
								<label style="font-family: 'Jua', sans-serif;" for="employeeId">아이디</label>
								<input style="font-family: 'Jua', sans-serif;" 
									   type="text" class="form-control" name="employeeId"
										id="employeeId" readonly="readonly">
								<br>
								<label style="font-family: 'Jua', sans-serif;" for="employeePass">비밀번호</label>		
								<input style="font-family: 'Jua', sans-serif;" 
										type="password" class="form-control"
										placeholder="비밀번호를 입력하세요" name="employeePass"
										id="employeePass">
								<br>		
								<label style="font-family: 'Jua', sans-serif;" for="employeeName">이름</label>	
								<input style="font-family: 'Jua', sans-serif;"
									   type="text" class="form-control"
									   placeholder="이름을 입력하세요" name="employeeName"
									   id="employeeName">
							
							<br>
							<div class="form-group">
								<button type="reset"
								        class="btn amado-btn w-100"
								        style="font-family: 'Jua', sans-serif;" >초기화</button>	
							</div>
							<br>
							<div class="form-group">	
								<button id="addBtn" type="button"
										class="btn login-btn w-100"
										style="font-family: 'Jua', sans-serif;">회원가입</button> 
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
	// 관리자 아이디 중복검사
	$('#idckBtn').click(function() {
		if ($('#idck').val().length < 4) {
			alert('아이디는 4자이상 입력하세요');
		} else {
			// 비동기 호출   
			$.ajax({
				url : '/shop/idckController',
				type : 'post',
				data : {
					idck : $('#idck').val()
				},
				success : function(json) {
					if (json == 'y') {
						$('#employeeId').val($('#idck').val());
					} else {
						alert('이미 사용중인 아이디입니다');
						$('#employeeId').val('');
					}
				},
				error : function(err) {
					alert('요청실패');
					console.log(err);
				}
			});
		}
	});
	// 직원 빈칸검사
	$('#addBtn').click(function(){		
		if($('#employeeId').val() == ''){
			alert('관리자 아이디를 입력하세요');
		} else if($('#employeeIdPass').val() == ''){
			alert('관리자 패스워드를 입력하세요');
		} else if($('#employeeIdName').val() == ''){
			alert('이름을 입력하세요');
		} else {
			$('#addEmployeeForm').submit();
		}
	});;
</script>
</html>