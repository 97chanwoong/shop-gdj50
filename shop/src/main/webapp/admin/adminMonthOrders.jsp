<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
	return;
} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
	response.sendRedirect(request.getContextPath() + "/customerIndex.jsp?errorMsg=No permission");
}
// 인코딩
request.setCharacterEncoding("utf-8");
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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script>
	$(document).ready(
			function() {
				var x = [];
				var y = [];
				$.ajax({
					url : '/shop/controller/getCountByOrder',
					type : 'get',
					success : function(json) {
						console.log(json);
						$(json).each(function(index, item) {
							x.push(item.ym); // 값 넣어주기
							y.push(item.cnt); // 값 넣어주기
							let html = '<tr>'
							html += '<td>' + item.ym + '</td>'
							html += '<td>' + item.cnt + '</td>'
							html += '</tr>'
							$('#orderCnt').append(html);
						});
						var barColors = [ "red", "green", "blue", "orange",
								"brown", "purple", "yellow", "pink" ];

						new Chart("OrderChart", {
							type : "bar",
							data : {
								labels : x,
								datasets : [ {
									backgroundColor : barColors,
									data : y
								} ]
							},
							options : {
								responsive : true,
								legend : {
									display : false
								},
								title : {
									display : true,
									text : "월별 주문량"
								}
							}
						});
					}
				});
			});
</script>
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
							<h5 style="font-family: 'Jua', sans-serif;">월별 주문 통계 그래프</h5>
							<br>
							<table class="table table-hover text-center">
								<thead class="thead-light"
									style="font-family: 'Jua', sans-serif;">
									<tr>
										<th>월별</th>
										<th>주문량</th>
									</tr>
								</thead>
								<tbody style="font-family: 'Jua', sans-serif;" id="orderCnt">
								</tbody>
							</table>
							<hr>
							<div class="container center">
								<canvas id="OrderChart" style="width: 100%; max-width: 3000px;"></canvas>
							</div>
							<hr>
							<div class="row">
								<div class="col-1">
									<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp"
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