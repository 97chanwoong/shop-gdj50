package repository;

import java.sql.*;

public class CounterDao {
	// 오늘 날짜에 있는지 확인
	public String selectCounterToday(Connection conn) throws Exception {
		// 리턴 값
		String result = null;
		// 쿼리
		String sql = "SELECT counter_date counterDate FROM counter WHERE counter_date = CURDATE()";
		// SELECT counter_date FROM counter WHERE counter_date = CURDATE()
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- selectCounterToday stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("counterDate");
				// 디버깅
				System.out.println(result + "selectCounterToday result");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return result;
	}
	
	// 접속자 수 추가
	public void insertCounter(Connection conn) throws Exception {
		// 리턴값
		int row = 0;
		// INSERT INTO counter(counter_date,counter_num) VALUES(CURDATE(),1)
		// 쿼리
		String sql = "INSERT INTO counter(counter_date, counter_num) VALUES(CURDATE(), 1)";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- insertCounter stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
	}
	
	// 접속자 수 수정
	public void updateCounter(Connection conn) throws Exception {
		// UPDATE counter SET counter_num = counter_num+1 WHERE counter_date = CURDATE()
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE counter SET counter_num = counter_num+1 WHERE counter_date = CURDATE()";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- updateCounter stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
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
		// 쿼리
		String sql = "SELECT SUM(counter_num) totalCount FROM counter";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- selectTotalCount stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt("totalCount");
				// 디버깅
				System.out.println(totalCount + "전체 접속자 수 ");
			}
		} finally {
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
		// 리턴값
		int todayCount = 0;
		// 쿼리
		String sql = "SELECT counter_num counterNum FROM counter WHERE counter_date = CURDATE()";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- selectTodayCount stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				todayCount = rs.getInt("counterNum");
				// 디버깅
				System.out.println(todayCount + "오늘 접속자 수 ");
			}
		} finally {
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
