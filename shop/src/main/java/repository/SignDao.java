package repository;

import java.sql.*;

import vo.Customer;
import vo.Employee;

public class SignDao {
	// Id체크
	public String idCheck(Connection conn, String id) throws Exception{
		String ckId = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// customer_id, employee_id, out_id 중 중복된 값이 있는지
		String sql = "SELECT t.id FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ?";		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			ckId = rs.getString("id");
		}
		
		if(rs != null) {
			rs.close();
		}
		
		if(stmt != null) {
			stmt.close();
		}
		
		return ckId;
	}
}