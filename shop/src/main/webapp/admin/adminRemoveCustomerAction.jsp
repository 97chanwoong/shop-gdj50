<%@page import="service.CustomerService"%>
<%@page import="service.GoodsService"%>
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
	// CustomerId 받은 값
	String customerId = request.getParameter("customerId");
	// 디버깅
	System.out.println(customerId + "<-- customerId");
	//삭제 실행하기
	boolean result = false;
	
	CustomerService customerService = new CustomerService();
	result = customerService.removeAdminCustomer(customerId);
	
	if (result == true) {
		System.out.println(customerId + " 탈퇴 성공");
		response.sendRedirect(request.getContextPath() + "/admin/adminCustomerlist.jsp");
	} else {
		System.out.println(customerId + " 탈퇴 실패");
		response.sendRedirect(request.getContextPath() + "/admin/adminCustomerOne.jsp?customerId=" + customerId);
}
%>