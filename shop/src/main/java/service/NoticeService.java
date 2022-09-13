package service;

import java.sql.*;
import java.util.*;

import repository.*;
import vo.Notice;

public class NoticeService {
	private DBUtil dbutil;
	private NoticeDao noticeDao;

	// 공지사항 리스트
	public List<Notice> getNoticeList(int rowPerPage, int currentPage) {
		// 리턴값
		List<Notice> list = new ArrayList<Notice>();
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.noticeDao = new NoticeDao();

		// beginRow
		int beginRow = (currentPage - 1) * rowPerPage;
		// 디버깅
		System.out.println(beginRow + "<-- getNoticeList beginRow");

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getNoticeList conn");
			// 메서드실행
			list = noticeDao.selectNoticeList(conn, rowPerPage, beginRow);
			if (list == null) {
				throw new Exception(); // 예외처리
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

	// 공지사항 LastPage
	public int getNoticeLastPage(int rowPerPage) {
		// 리턴값
		int lastPage = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.noticeDao = new NoticeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getNoticeOne conn");
			// 메서드실행
			int totalRow = noticeDao.selectNoticeCount(conn);
			lastPage = (int) Math.ceil(totalRow / (double) rowPerPage);
			if (lastPage == 0) {
				throw new Exception(); // 예외처리
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

	// 공지사항 상세보기
	public Map<String, Object> getNoticeOne(int noticeNo) {
		// 리턴값
		Map<String, Object> map = null;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.noticeDao = new NoticeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getNoticeOne conn");
			// 메서드실행
			map = noticeDao.selectNoticeOne(conn, noticeNo);
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
		return map;
	}

	// 공지사항 추가
	public int addNotice(Notice notice) {
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.noticeDao = new NoticeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- addNotice conn");
			// 메서드실행
			row = this.noticeDao.insertNotice(conn, notice);
			if (row == 0) {
				throw new Exception(); // 예외처리
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
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.noticeDao = new NoticeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- modifyNotice conn");
			// 메서드실행
			row = noticeDao.updateNotice(conn, notice);
			if (row == 0) {
				throw new Exception(); // 예외처리
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
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.noticeDao = new NoticeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- removeNotice conn");
			// 메서드실행
			row = noticeDao.deleteNotice(conn, noticeNo);
			if (row == 0) {
				throw new Exception(); // 예외처리
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
}
