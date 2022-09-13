package repository;

import java.sql.*;

import vo.Customer;
import vo.Employee;

public class SignDao {
	// id 중복검사
	public String selectIdCheck(Connection conn, String idck) throws Exception {
		// 리턴값
		String id = null;
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// customer_id, employee_id, out_id 중 중복된 값이 있는지
		// 쿼리
		String sql = "SELECT t.id FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ?";
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, idck);
			// 디버깅
			System.out.println(stmt + "<--  selectIdCheck stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				id = rs.getString("t.id");
			}
		} finally {

			if (rs != null) {
				rs.close();
			}

			if (stmt != null) {
				stmt.close();
			}
		}
		// 사용 가능한 아이디는 null
		return id;
	}
}
