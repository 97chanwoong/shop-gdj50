<%@page import="service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String customerId = request.getParameter("customerId");
	String reviewContents = request.getParameter("reviewContents");

	Review review = new Review();
	review.setOrdersNo(ordersNo);
	review.setReviewContents(reviewContents);
	
	ReviewService reviewService = new ReviewService();
	int row = reviewService.modifyCustomerReview(review);
	
	if(row == 0){
		System.out.println("리뷰수정 실패");
		response.sendRedirect(request.getContextPath() + "/customerUpdateReview.jsp?customerId=" + customerId+"&ordersNo="+ ordersNo);
	} else{
		System.out.println("리뷰수정 성공");
		response.sendRedirect(request.getContextPath() + "/admin/customerOrderslist.jsp?customerId=" + customerId);
	}
	
%>