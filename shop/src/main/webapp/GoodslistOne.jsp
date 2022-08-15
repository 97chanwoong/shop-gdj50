<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")) ;
	
	GoodsService goodsService = new GoodsService();
	int row = goodsService.modifyListView(goodsNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
조회수 : 
</div>
</body>
</html>