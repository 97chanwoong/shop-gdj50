<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="service.*"%>
<% 
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "index.jsp?errorMsg=No permission");
	}
	
	String employeeId = request.getParameter("employeeId");
	String active = request.getParameter("active");
	// 디버깅
	System.out.println(employeeId + "<--employeeId");
	System.out.println(active + "<--active");
	
	// 메서드 실행 객체생성
	EmployeeService employeeService = new EmployeeService();
	boolean result = employeeService.modifyEmployeeActiveById(employeeId, active);
	
	if(result){
		System.out.println("active update 성공");
		response.sendRedirect(request.getContextPath()+"/employeeList.jsp");
	} else {
		System.out.println("acitve update 실패");
		response.sendRedirect(request.getContextPath()+"/employeeList.jsp?errorMsg=active update fail");
	}
%>
