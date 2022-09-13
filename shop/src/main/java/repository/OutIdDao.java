package repository;

import java.sql.*;
import service.*;

public class OutIdDao {
	// 탈퇴 아이디를 입력
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int insertOutId(Connection conn, String OutId) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "INSERT INTO outid(out_id,out_date) VALUES(?,NOW())";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,OutId);
			// 디버깅
			System.out.println(stmt + "<-- insertOutId stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
}
