<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div>		
			<form id="removeForm" action="<%=request.getContextPath()%>/removeIdAction.jsp" method="post">
				<fieldset>
				<legend>쇼핑몰 탈퇴</legend>
					<table border="1">
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" name="Pass" id="Pass">
							</td>
						</tr>
					</table>
					<div>
					<button type="button" id="removebtn">회원 탈퇴하기</button>
					</div>
				</fieldset>
			</form>
	</div>
</body>
<script>
	$('#removebtn').click(function(){
		if($('#Pass').val() == '') {
			alert('패스워드를 입력하세요');
		} else {
			removeForm.submit();
		}
	});
</script>
</html>