<%@page import="service.NoticeService"%>
<%@page import="repository.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	//전송받은 값
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// 디버깅
	System.out.println(noticeNo + "<-- noticeNo");
	// NoticeService 객체 생성
	NoticeService noticeService = new NoticeService();
	//삭제 실행하기
	int row = noticeService.removeNotice(noticeNo);
	if (row == 1) {
		System.out.println("공지 삭제 성공");
		response.sendRedirect(request.getContextPath() + "/admin/adminNoticelist.jsp");
	} else {
		System.out.println("공지 삭제 실패");
		response.sendRedirect(request.getContextPath() + "/admin/NoticeOne.jsp?noticeNo=" + noticeNo);
	}
%>
