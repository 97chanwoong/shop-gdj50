<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	//전송받은 값
	String customerId = request.getParameter("customerId");
	String customerPass = UUID.randomUUID().toString().substring(0, 7);
	// 디버깅
	System.out.println(customerId + "<-- customerId");
	System.out.println(customerPass + "<-- customerPass");
	// Customer 객체생성
	Customer customer = new Customer();
	// set
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	// 메서드 실행 및 재요청
	CustomerService customerService = new CustomerService();
	int row = customerService.modifyCustomerPass(customer);
	if (row == 0) {
		System.out.println(customerId + " 비밀번호 변경 실패");
		response.sendRedirect(request.getContextPath() + "/admin/CustomerOne.jsp?customerId=" + customerId);
	} else {
		System.out.println(customerId + " 비밀번호 변경 성공");
		response.sendRedirect(request.getContextPath() + "/admin/adminCustomerlist.jsp");
	}
%>