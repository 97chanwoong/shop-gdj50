<%@page import="java.util.*"%>
<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	String customerNewPass = request.getParameter("customerNewPass");
	
	Map<String,Object> map = new HashMap<>();
	map.put("customerId", customerId);
	map.put("customerPass", customerPass);
	map.put("customerNewPass", customerNewPass);
	
	CustomerService customerService = new CustomerService();
	int row =  customerService.modifyCustomerPass(map);
	if(row == 0){
		System.out.println("비밀번호 수정 실패");
		response.sendRedirect(request.getContextPath()+"/customerUpdatePass.jsp?errorMsg=PassUpdate Fail&customerId="+customerId);
	} else {
		System.out.println("비밀번호 수정 성공");
		response.sendRedirect(request.getContextPath()+"/LogOut.jsp");
	}
	
%>