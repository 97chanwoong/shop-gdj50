<%@page import="service.SignService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String signId = request.getParameter("signId");
	// Customer / Employee 인지 구별값을 받아옴
	String Identity = request.getParameter("Identity");
	// 디버깅
	System.out.println(signId);
	System.out.println(Identity);
	
	// 리턴받을 메서드 객체 생성
	SignService signService = new SignService();
	boolean result = signService.idCheck(signId); 
	
	if(!result){ // return false
		// 고객 폼 or 관리자 폼으로 이동 
		response.sendRedirect(request.getContextPath() + "/add" + Identity + "Form.jsp?errorMsg=ID not available");
		return;
	}
	// true
	response.sendRedirect(request.getContextPath() + "/add" + Identity + "Form.jsp?signId=" + signId);
%>