<%@page import="service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String customerId = request.getParameter("customerId");

	ReviewService reviewService = new ReviewService();
	int row = reviewService.removeAdminReview(ordersNo);
	if(row == 0){
		System.out.println("리뷰삭제 실패");
	} else{
		System.out.println("리뷰삭제 성공");
	}
	response.sendRedirect(request.getContextPath() + "/admin/customerOrderslist.jsp?customerId=" + customerId);
%>