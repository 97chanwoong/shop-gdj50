<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	//전송받은 값들을 Notice 객체에 셋팅
	Notice notice = new Notice();
	notice.setNoticeTitle(request.getParameter("noticeTitle"));
	notice.setNoticeContent(request.getParameter("noticeContent"));
	// 디버깅
	System.out.println(notice);
	
	// 메서드 객체 생성 및 실행
	NoticeService noticeService = new NoticeService();
	int row = noticeService.addNotice(notice);
	
	if(row == 1){
		System.out.println("공지사항 추가에 성공하였습니다");
	} else {
		System.out.println("공지사항 추가에 실패하였습니다.");
	}
	// 재요청
	response.sendRedirect(request.getContextPath()+"/admin/adminNoticelist.jsp");
%>