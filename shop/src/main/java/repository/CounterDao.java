package repository;

import java.sql.*;

public class CounterDao {
	// 오늘 날짜에 있는지 확인
	public String selectCounterToday(Connection conn) throws Exception {
		// 리턴 값 
		String result = null;
		String sql = "SELECT counter_date counterDate FROM counter WHERE counter_date = CURDATE()";
		// SELECT counter_date FROM counter WHERE counter_date = CURDATE()
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- selectCounterToday stmt");
			rs = stmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("counterDate");
			}
		} finally{
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		return result;	
	}
	
	public void insertCounter(Connection conn) throws Exception {
		int row = 0;
		// INSERT INTO counter(counter_date,counter_num) VALUES(CURDATE(),1)
		String sql = "INSERT INTO counter(counter_date, counter_num) VALUES(CURDATE(), 1)";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- insertCounter stmt");
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
	}
	
	
	public void updateCounter(Connection conn) {
		// UPDATE counter SET counter_num = counter_num+1 WHERE counter_date = CURDATE()
		int row = 0;
		String sql = "";
	}
	
	
	// IndexController에서 호출
	// 전체접속자 수
	// SELECT SUM(counter_num) FROM counter; 
	public int selectTotalCount(Connection conn) {
		return 0;
	}
	
	// 오늘 접속자 수
	// SELECT counter_num FROM counter WHERE counter_date = CURDATE();
	public int selectTodayCount(Connection conn) {
		return 0;
	}
}
