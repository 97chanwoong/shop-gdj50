<%@page import="service.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	
	// 인스턴스
	Customer customer = new Customer();
	customer.setCustomerId(request.getParameter("customerId"));
	customer.setCustomerPass(request.getParameter("customerPass"));
	customer.setCustomerName(request.getParameter("customerName"));
	customer.setCustomerAddress(request.getParameter("customerAddress"));
	customer.setCustomerTelephone(request.getParameter("customerTelephone"));
	
	System.out.println("customer: " + customer);
	
	CustomerService customerService = new CustomerService();
	
	boolean result = customerService.addCustomer(customer);
	// 디버깅
	System.out.println(result + "<-- result");
	
	if(!result){
		System.out.println("회원가입 실패");
		response.sendRedirect(request.getContextPath()+"/addCustomerForm.jsp");
		return;
	}
	System.out.println("회원가입 성공");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>