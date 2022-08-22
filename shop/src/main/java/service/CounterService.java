package service;

import repository.*;
import java.sql.*;

public class CounterService {
	private CounterDao counterDao;
	private DBUtil dbutil;

	public void count() {
		counterDao = new CounterDao();
		dbutil = new DBUtil();
		// 초기화
		Connection conn = null;
		try {
			conn = dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "CounterService  count DB 연결성공");
			// conn 자동커밋해제
			conn.setAutoCommit(false);
			if (counterDao.selectCounterToday(conn) == null) { // 오늘날짜 카운터가 없으면 1 입력
				System.out.println("todayCounter 없음");
				counterDao.insertCounter(conn);
			} else { // 오늘날짜의 카운터가 있으면 +1 업데이트
				System.out.println("todayCounter 있음");
				counterDao.updateCounter(conn);
			}
			conn.commit();
		}  catch(Exception e) {
			e.printStackTrace();
			// 문제 발생 시 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// 자원해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
	}

	public int getTotalCount() {
		// 리턴값
		int totalCount = 0;
		counterDao = new CounterDao();
		dbutil = new DBUtil();
		// 초기화
		Connection conn = null;
		try {
			conn = dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "CounterService getTotalCount DB 연결성공");
			totalCount = counterDao.selectTotalCount(conn);
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
		return totalCount;
	}

	public int getTodayCount() {
		// 리턴값
		int todayCount = 0;
		counterDao = new CounterDao();
		dbutil = new DBUtil();
		// 초기화
		Connection conn = null;
		try {
			conn = dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "CounterService getTodayCount DB 연결성공");
			todayCount = counterDao.selectTodayCount(conn);
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
		return todayCount;
	}
}
