<%@page import="service.OrdersService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");
	
	Map<String, Object> map = new HashMap<>();
	map.put("ordersNo", Integer.parseInt(request.getParameter("ordersNo")));
	map.put("ordersAddress", request.getParameter("ordersAddress"));
	map.put("ordersState", request.getParameter("ordersState"));
	
	OrdersService ordersService = new OrdersService();
	int row = ordersService.getOrdersOne(map);
	
	if(row == 1){
		System.out.println("주문 내역 수정 성공");
		response.sendRedirect(request.getContextPath()+"/admin/adminOrderslist2.jsp");
	} else {
		System.out.println("주문 내역 수정 실패");
		response.sendRedirect(request.getContextPath()+"/admin/updateOrdersOne.jsp?ordersNo=ordersNo");
	}
%>