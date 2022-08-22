package repository;

import java.sql.*;

public class CounterDao {
	// 오늘 날짜에 있는지 확인
	public String selectCounterToday(Connection conn) throws Exception {
		// 리턴 값
		String result = null;
		String sql = "SELECT counter_date counterDate FROM counter WHERE counter_date = CURDATE()";
		// SELECT counter_date FROM counter WHERE counter_date = CURDATE()
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- selectCounterToday stmt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("counterDate");
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return result;
	}

	public void insertCounter(Connection conn) throws Exception {
		int row = 0;
		// INSERT INTO counter(counter_date,counter_num) VALUES(CURDATE(),1)
		String sql = "INSERT INTO counter(counter_date, counter_num) VALUES(CURDATE(), 1)";
		// DB 자원
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- insertCounter stmt");
			row = stmt.executeUpdate();
		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
	}

	public void updateCounter(Connection conn) throws Exception {
		// UPDATE counter SET counter_num = counter_num+1 WHERE counter_date = CURDATE()
		int row = 0;
		String sql = "UPDATE counter SET counter_num = counter_num+1 WHERE counter_date = CURDATE()";
		// DB 자원
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- updateCounter stmt");
			row = stmt.executeUpdate();
		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
	}

	// IndexController에서 호출
	// 전체접속자 수
	// SELECT SUM(counter_num) FROM counter;
	public int selectTotalCount(Connection conn) throws Exception {
		// 리턴값
		int totalCount = 0;
		String sql = "SELECT SUM(counter_num) totalCount FROM counter";
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- selectTotalCount stmt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt("totalCount");
				System.out.println(totalCount + "전체 접속자 수 ");
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return totalCount;
	}

	// 오늘 접속자 수
	// SELECT counter_num FROM counter WHERE counter_date = CURDATE();
	public int selectTodayCount(Connection conn) throws Exception {
		int todayCount = 0;
		String sql = "SELECT counter_num counterNum FROM counter WHERE counter_date = CURDATE()";
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- selectTodayCount stmt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				todayCount = rs.getInt("counterNum");
				System.out.println(todayCount + "오늘 접속자 수 ");
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return todayCount;
	}
}
