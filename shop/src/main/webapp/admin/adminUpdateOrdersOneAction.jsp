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
	// 객체 생성
	Map<String, Object> map = new HashMap<>();
	// 파라미터 값 받아오기
	map.put("ordersNo", Integer.parseInt(request.getParameter("ordersNo")));
	map.put("ordersAddress", request.getParameter("ordersAddress"));
	map.put("ordersState", request.getParameter("ordersState"));
	// 메서드 생성 및 실행
	OrdersService ordersService = new OrdersService();
	int row = ordersService.getOrdersOne(map);
	
	// 재요청
	if(row == 1){
		System.out.println("주문 내역 수정 성공");
		response.sendRedirect(request.getContextPath()+"/admin/adminOrderslist.jsp");
	} else {
		System.out.println("주문 내역 수정 실패");
		response.sendRedirect(request.getContextPath()+"/admin/adminUpdateOrdersOne.jsp?ordersNo=ordersNo");
	}
%>