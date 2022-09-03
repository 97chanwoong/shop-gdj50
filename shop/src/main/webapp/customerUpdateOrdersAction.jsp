<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	String ordersState = request.getParameter("ordersState");
	
	OrdersService ordersService = new OrdersService();
	int row = 0;
	if(ordersState.equals("결제완료")){
		row = ordersService.modifyCartOrders(ordersNo);
	} else if(ordersState.equals("주문완료")){
		row = ordersService.removeCartOrders(ordersNo);
	}
	
	if(row == 0){
		System.out.println("주문 수정 실패");
	} else{
		System.out.println("주문 수정 성공");
	}
	response.sendRedirect(request.getContextPath() + "/admin/customerOrderslist.jsp?customerId=" + customerId);
%>