<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("employee")) {
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp?errorMsg=No permission");
	}
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	// 아이디값 비밀번호값 받아오기
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	
	// Customer
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	// CustomerService 생성 및  본인 확인 메서드실행
	CustomerService customerService = new CustomerService();
	customer = customerService.checkCustomerIdAndPass(customer);
	if(customer == null){
		System.out.println("본인 확인 실패");
		response.sendRedirect(request.getContextPath()+"/customerCheckIdAndPass.jsp");
		return;
	} else {
		System.out.println("본인 확인 성공");
		response.sendRedirect(request.getContextPath()+"/customerUpdateOne.jsp?customerId="+ customerId);
	}
%>