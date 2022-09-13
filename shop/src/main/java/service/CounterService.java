package service;

import repository.*;
import java.sql.*;

public class CounterService {
	private DBUtil dbutil;
	private CounterDao counterDao;
	
	public void count() {
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.counterDao = new CounterDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "CounterService  count DB 연결성공");
			// conn 자동커밋해제
			conn.setAutoCommit(false);
			// 분기 및 메서드실행
			if (this.counterDao.selectCounterToday(conn) == null) { // 오늘날짜 카운터가 없으면 1 입력
				// 디버깅
				System.out.println("todayCounter 없음");
				this.counterDao.insertCounter(conn);
			} else { // 오늘날짜의 카운터가 있으면 +1 업데이트
				// 디버깅
				System.out.println("todayCounter 있음");
				this.counterDao.updateCounter(conn);
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
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
	}
	
	// 전체접속자 수
	public int getTotalCount() {
		// 리턴값
		int totalCount = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.counterDao = new CounterDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "CounterService getTotalCount DB 연결성공");
			// 메서드실행
			totalCount = this.counterDao.selectTotalCount(conn);
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

	// 오늘 접속자 수
	public int getTodayCount() {
		// 리턴값
		int todayCount = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.counterDao = new CounterDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "CounterService getTodayCount DB 연결성공");
			// 메서드실행
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
