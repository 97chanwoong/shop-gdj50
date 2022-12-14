<%@page import="service.*"%>
<%@page import="repository.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/customerIndex.jsp?errorMsg=No permission");
	}
	//인코딩
	request.setCharacterEncoding("utf-8");
	//전송받은 값
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	// 디버깅
	System.out.println(ordersNo + "<-- ordersNo");
	// ReviewService 객체 생성
	ReviewService reviewService = new ReviewService();
	//삭제 실행하기
	int row = reviewService.removeAdminReview(ordersNo);
	if (row == 1) {
		System.out.println(ordersNo + " 리뷰 삭제 성공");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNo="+ goodsNo);
	} else {
		System.out.println(ordersNo + " 리뷰 삭제 실패");
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNo="+ goodsNo);
	}
%>
