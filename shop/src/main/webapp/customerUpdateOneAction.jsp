<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 인스턴스
	Customer customer = new Customer();
	customer.setCustomerId(request.getParameter("customerId"));
	customer.setCustomerName(request.getParameter("customerName"));
	customer.setCustomerAddress(request.getParameter("customerAddress"));
	customer.setCustomerDeAddress(request.getParameter("customerDeAddress"));
	customer.setCustomerTelephone(request.getParameter("customerTelephone"));
	// 디버깅
	System.out.println(customer + "<-- customer");
	
	// CustomerService 생성 및 회원정보수정 메서드 실행
	CustomerService customerService = new CustomerService();
	int row = customerService.modifyCustomerOne(customer);
	if(row == 0){
		System.out.println("정보수정 실패");
		response.sendRedirect(request.getContextPath()+"/customerIndex.jsp");
		return;
	} else {
		System.out.println("정보수정 성공");
		response.sendRedirect(request.getContextPath()+"/customerOne.jsp?customerId="+customer.getCustomerId());
	}
%>