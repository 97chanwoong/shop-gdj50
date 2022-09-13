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
	// 고객 아이디 받아오기
	String customerId = request.getParameter("customerId");
	// 고객 상세보기 메서드실행
	CustomerService customerService = new CustomerService();
	Map<String, Object> map = customerService.getCustomerOne(customerId);
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
					<div class="col-12">
						<div class="Customer-summary">
							<h5 style="font-family: 'Jua', sans-serif;">고객 상세보기</h5>
							<br>
							<div style="text-align: right;">
								<button class="btn amado-btn w-30"
									onclick="updateCustomerPassBtn()">비밀번호 변경</button>
							</div>
							<br>
							<table class="table table-bordered text-center">
								<thead class="thead-light"
									style="font-family: 'Jua', sans-serif;">
									<tr>
										<th>고객 아이디</th>
										<td style="font-size: 18px;"><%=map.get("customerId")%></td>
									</tr>
									<tr>
										<th>고객 이름</th>
										<td style="font-size: 18px;"><%=map.get("customerName")%></td>
									</tr>
									<tr>
										<th>고객 주소</th>
										<td style="font-size: 18px;"><%=map.get("customerAddress")%></td>
									</tr>
									<tr>
										<th>고객 전화번호</th>
										<td style="font-size: 18px;"><%=map.get("customerTelephone")%></td>
									</tr>
									<tr>
										<th>수정 날짜</th>
										<td style="font-size: 18px;"><%=map.get("updateDate")%></td>
									</tr>
									<tr>
										<th>가입 날짜</th>
										<td style="font-size: 18px;"><%=map.get("createDate")%></td>
									</tr>
								</thead>
							</table>
							<div style="text-align: right;">
								<button class="btn amado-btn w-30" onclick="removeCustomerBtn()">탈퇴</button>
							</div>
							<div style="text-align: left;">
								<a
									href="<%=request.getContextPath()%>/admin/adminCustomerlist.jsp"
									class="btn amado-btn w-30">목록</a>
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
function updateCustomerPassBtn() {
	 var result = confirm("회원의 비밀번호를 변경하시겠습니까?");
	  if (result == true) {
		  location.href="<%=request.getContextPath()%>/admin/adminUpdateCustomerPassAction.jsp?customerId=<%=map.get("customerId")%>";
			}
		}

function removeCustomerBtn() {
 var result = confirm("회원을 탈퇴시키겠습니까?");
  if (result == true) {
	  location.href="<%=request.getContextPath()%>/admin/adminRemoveCustomerAction.jsp?customerId=<%=map.get("customerId")%>
	";
		}
	}
</script>
</html>