<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate();	// -session reset
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>