<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String user = (String)session.getAttribute("user");
	String id = (String)session.getAttribute("id");
	String pass = request.getParameter("Pass");
	
	boolean result = false; // 결과 값을 받을 변수
	
	// 세션에 저장된 user 값 == customer 
	if("customer".equals(user)){
		// 인스턴스
		Customer customer = new Customer();
		customer.setCustomerId(id);
		customer.setCustomerPass(pass);
		
		CustomerService customerService = new CustomerService();
		result = customerService.removeCustomer(customer);
		
	} else {
		//세션에 저장된 user 값 == employee 
		Employee employee = new Employee();
		employee.setEmployeeId(id);
		employee.setEmployeePass(pass);
		
		
		EmployeeService employeeService = new EmployeeService();
		result = employeeService.removeEmployee(employee);
	}
	
	// 재요청
	if(result == true){
		System.out.println("탈퇴성공");
		response.sendRedirect(request.getContextPath() + "/LogOut.jsp");
	} else {
		System.out.println("탈퇴실패");
		response.sendRedirect(request.getContextPath() + "/removeIdForm2.jsp");
	}
	
	
%>