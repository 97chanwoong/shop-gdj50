package repository;

import java.sql.*;

import vo.Customer;
import vo.Employee;

public class SignDao {
	// id 중복검사 
	public String selectIdCheck(Connection conn, String idck) throws Exception{
		// return 변수
		String id = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// customer_id, employee_id, out_id 중 중복된 값이 있는지
		String sql = "SELECT t.id FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ?";		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, idck);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			id = rs.getString("t.id");
		}
		
		if(rs != null) {
			rs.close();
		}
		
		if(stmt != null) {
			stmt.close();
		}
		// 사용 가능한 아이디는 null
		return id;
	}
}
