<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/customerIndex.jsp?errorMsg=No permission");
	}
	// 인코딩
	request.setCharacterEncoding("utf-8");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	
	// 오더객체에 값 넣어주기
	Orders orders = new Orders();
	orders.setOrdersNo(Integer.parseInt(request.getParameter("ordersNo")));
	orders.setOrdersAddress(request.getParameter("ordersAddress"));
	orders.setOrdersDeAddress(request.getParameter("ordersDeAddress"));
	orders.setOrdersState(request.getParameter("ordersState"));
	
	// 메서드 객체 생성 및 실행
	OrdersService ordersService = new OrdersService();
	int row = ordersService.modifyOrdersOne(orders);
	
	// 재요청
	if(row == 1){
		System.out.println("주문 내역 수정 성공");
		response.sendRedirect(request.getContextPath()+"/admin/adminOrdersOne.jsp?ordersNo=" + ordersNo);
	} else {
		System.out.println("주문 내역 수정 실패");
		response.sendRedirect(request.getContextPath()+"/admin/adminOrdersOne.jsp?ordersNo="  + ordersNo + "&errorMsg=Orders Update Fail" );
	}
%>