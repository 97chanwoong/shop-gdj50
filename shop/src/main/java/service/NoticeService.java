package service;

import java.sql.*;
import java.util.*;

import repository.*;
import vo.Notice;

public class NoticeService {
	// 공지사항 추가
	public int addNotice(Notice notice) {
		int row = 0;
		// DB연결
		Connection conn = null;
		// Dao 객체
		NoticeDao noticeDao = new NoticeDao();
		try {
			conn = new DBUtil().getConnection();
			System.out.println(conn + "<-- addNotice conn");
			row = noticeDao.insertNotice(conn, notice);
			if (row == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}

	// 공지사항 수정
	public int modifyNotice(Notice notice) {
		int row = 0;
		// DB연결
		Connection conn = null;
		// Dao 객체
		NoticeDao noticeDao = new NoticeDao();
		try {
			conn = new DBUtil().getConnection();
			System.out.println(conn + "<-- addNotice conn");
			row = noticeDao.updateNotice(conn, notice);
			if (row == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}

	// 공지사항 삭제
	public int removeNotice(int noticeNo) {
		int row = 0;
		// DB연결
		Connection conn = null;
		// Dao 객체
		NoticeDao noticeDao = new NoticeDao();
		try {
			conn = new DBUtil().getConnection();
			System.out.println(conn + "<-- removeNotice conn");
			row = noticeDao.deleteNotice(conn, noticeNo);
			if (row == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}

	// 공지사항 리스트
	public List<Notice> getNoticeList(int rowPerPage, int currentPage) {
		List<Notice> list = new ArrayList<Notice>();
		// DB연결
		Connection conn = null;
		// Dao 객체
		NoticeDao noticeDao = new NoticeDao();
		// beginRow
		int beginRow = (currentPage - 1) * rowPerPage;
		// 디버깅
		System.out.println(beginRow + "<-- getNoticeList beginRow");
		try {
			conn = new DBUtil().getConnection();
			list = noticeDao.selectNoticeList(conn, rowPerPage, beginRow);
			if (list == null) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	// 공지사항 상세보기
	public Notice getNoticeOne(int noticeNo) throws SQLException {
		Notice notice = null;
		// DB driver
		Connection conn = null;
		// Dao 객체
		NoticeDao noticeDao = new NoticeDao();
		try {
			conn = new DBUtil().getConnection();
			System.out.println("getNoticeOne- DB Driver 연결");
			notice = noticeDao.selectNoticeOne(conn, noticeNo);
		} catch (Exception e) {
			// DB 자원 해제
			if (conn != null) {
				conn.close();
			}
		}
		return notice;
	}

	// 공지사항 LastPage
	public int getNoticeLastPage(int rowPerPage) {
		int lastPage = 0;
		// DB연결
		Connection conn = null;
		// Dao 객체
		NoticeDao noticeDao = new NoticeDao();
		try {
			conn = new DBUtil().getConnection();
			int totalRow = noticeDao.selectNoticeCount(conn);
			lastPage = (int) Math.ceil(totalRow / (double) rowPerPage);
			if (lastPage == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return lastPage;
	}

}
