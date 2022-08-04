<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="repository.*" %>
<%@ page import="service.*" %>
<%
	//재요청 - 접근 막기
	if(session.getAttribute("loginCustomer") != null){ // 로그인된 사람 막기
		response.sendRedirect("./loginForm.jsp"); // 페이지 재요청
		return;
	}
	
	
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// loginForm Customer id,pw 값 받아오기
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	// 디버깅
	System.out.println(customerId + "<-- customerId");
	System.out.println(customerPass + "<-- customerPass");
	
	// 오류검사
	if(customerId == null || customerPass == null || customerId.length() < 4 ||customerPass.length() < 4){
		response.sendRedirect("./loginForm.jsp?errorMsg=Invalid Access");
		return; 
	}
	
	// customer 객체 생성
	Customer customer = new Customer();
	// customer set
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	// 디버깅
	System.out.println(customer.getCustomerId() + "customer.getCustomerId()");
	System.out.println(customer.getCustomerPass() + "customer.getCustomerPass()");
	
	// 메서드 실행위한 객체생성
	CustomerService customerService = new CustomerService();
	// 메서드 리턴받을 객체생성
	Customer loginCustomer = new Customer();
	// 로그인메서드에 객체담기
	loginCustomer = customerService.getCustomerByIdAndPw(customer);
	
	// 재요청
	if(loginCustomer == null){
		System.out.println("로그인 실패");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=login Fail");
		return;
	} else {
		System.out.println("로그인 성공");
		session.setAttribute("user", "customer");
 		session.setAttribute("id", loginCustomer.getCustomerId());
 		session.setAttribute("name", loginCustomer.getCustomerName());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>