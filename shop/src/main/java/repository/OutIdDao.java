package repository;

import java.sql.*;
import service.*;

public class OutIdDao {
	// 탈퇴 아이디를 입력
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int insertOutId(Connection conn, String OutId) throws Exception {
		int row = 0;
		String sql = "INSERT INTO outid(out_id,out_date) VALUES(?,NOW())";
		PreparedStatement stmt = null;
		DBUtil dbutil = new DBUtil();
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,OutId);
			row = stmt.executeUpdate();
		} finally {
			stmt.close();
		}
		// 동일한 conn
		// conn.close() X
		return row;
	}
}
