package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.SignDao;
import vo.*;

public class SignService {
	private SignDao signDao;

	public String getIdCheck(String idck) {
		// return 변수
		String id = null;
		this.signDao = new SignDao();
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			id = signDao.selectIdCheck(conn, idck);
			
		} catch (Exception e) { // 오류발생
			e.printStackTrace();
			if(conn != null) {
	            try {
	               conn.rollback();
	            } catch (SQLException e1) {
	               e1.printStackTrace();
	            }
	         }
	      } finally {
	         if(conn != null) {
	            try {
	               conn.close();
	            } catch (SQLException e) {
	               e.printStackTrace();
	            }
	         }
	      }
		return id;
	}
}