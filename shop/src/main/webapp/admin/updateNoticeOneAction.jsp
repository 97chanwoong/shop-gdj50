<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	// 파라미터 값 받아오기
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	// 디버깅
	System.out.println(noticeNo + "<-- noticeNo");
	System.out.println(noticeTitle + "<-- noticeTitle");
	System.out.println(noticeContent+ "<-- noticeContent");
	
	// 객체 생성
	Notice notice = new Notice();
	// 값 담기
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	// 메서드 생성 및 실행
	NoticeService noticeService = new NoticeService();
	int row = noticeService.modifyNotice(notice);
	
	// 재요청
	if(row == 1){
		System.out.println("공지사항 수정 성공");
		response.sendRedirect(request.getContextPath()+"/admin/adminNoticelist.jsp");
	} else {
		System.out.println("공지사항 수정 실패");
		response.sendRedirect(request.getContextPath()+"/admin/updateNoticeOne.jsp?noticeNo=noticeNo");
	}
%>