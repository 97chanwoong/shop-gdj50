<%@page import="service.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//인스턴스
	Employee employee = new Employee();
	employee.setEmployeeId(request.getParameter("employeeId"));
	employee.setEmployeePass(request.getParameter("employeePass"));
	employee.setEmployeeName(request.getParameter("employeeName"));
	
	System.out.println("employee: " + employee);
	
	EmployeeService employeeService = new EmployeeService();
	
	boolean result = employeeService.addEmployee(employee);
	// 디버깅
	System.out.println(result + "<-- result");
	
	if(!result){
		System.out.println("회원가입 실패");
		response.sendRedirect(request.getContextPath()+"/addEmployeeForm2.jsp");
		return;
	}
	System.out.println("회원가입 성공");
	response.sendRedirect(request.getContextPath()+"/LoginForm2.jsp");

%>