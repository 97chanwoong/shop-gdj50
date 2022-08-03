<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="model.*" %>
<%
	//재요청 - 접근 막기
	if(session.getAttribute("loginEmployee") != null){ // 로그인된 사람 막기
		response.sendRedirect("./loginForm.jsp"); // 페이지 재요청
		return;
	}
	
	
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// loginForm Employee id,pw 값 받아오기
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	// 디버깅
	System.out.println(employeeId + "<-- employeeId");
	System.out.println(employeePass + "<-- employeePass");
	
	// 오류검사
	if(employeeId == null || employeePass == null || employeeId.length() < 4 || employeePass.length() < 4){
		response.sendRedirect("./loginForm.jsp?errorMsg=Invalid Access");
		return; 
	}
	
	// employee 객체 생성
	Employee employee = new Employee();
	// employee set
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePass);
	// 디버깅
	System.out.println(employee.getEmployeeId() + "employee.getEmployeeId()");
	System.out.println(employee.getEmployeePass() + "employee.getEmployeePass()");
	
	// customerDao 객채 생성 & 메서드 실행
	EmployeeDao employeeDao = new EmployeeDao();
	Employee loginEmployee = employeeDao.EmployeeLogin(employee);
	
	// 재요청
	if(loginEmployee == null){
		System.out.println("로그인 실패");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=login Fail");
		return;
	} else {
		System.out.println("로그인 성공");
		session.setAttribute("user", "employee");
 		session.setAttribute("id", loginEmployee.getEmployeeId());
 		session.setAttribute("name", loginEmployee.getEmployeeName());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>