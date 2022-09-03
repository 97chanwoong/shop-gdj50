<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@page import="service.CartService"%>
<%@page import="java.util.*"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String customerId = request.getParameter("customerId");
	String ordersAddress = request.getParameter("customerAddress");
	String ordersDeAddress = request.getParameter("customerDeAddress");
	CartService cartService = new CartService();
	List<Map<String, Object>> cartList = cartService.getCustomerCartList(customerId);
	OrdersService ordersService = new OrdersService();
	Orders orders = new Orders();
	int row = 0;
	for(Map<String,Object> m : cartList){
		int price = cartService.getGoodsPrice((int)m.get("goodsNo"));
		int goodsPrice = price * (int)m.get("cartQuantity");
		orders.setCustomerId(customerId);
		orders.setGoodsNo((int)m.get("goodsNo"));
		orders.setOrdersQuantity((int)m.get("cartQuantity"));
		orders.setOrdersPrice(goodsPrice);
		orders.setOrdersAddress(ordersAddress);
		orders.setOrdersDeAddress(ordersDeAddress);
		row = ordersService.addCustomerOrders(orders);
		cartService.removeCartAll(customerId);
	}
	if(row == 0){
		System.out.println("결제 실패");
		response.sendRedirect(request.getContextPath() + "/customerOrders.jsp?customerId="+customerId);
	} else{
		System.out.println("결제 성공");
		response.sendRedirect(request.getContextPath() + "/admin/customerOrderslist.jsp?customerId="+customerId);
	}
%>