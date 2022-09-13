package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CustomerDao;
import repository.SignDao;
import vo.*;

public class SignService {
	private DBUtil dbutil;
	private SignDao signDao;

	public String getIdCheck(String idck) {
		// 리턴값
		String id = null;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.signDao = new SignDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getIdCheck conn");
			// 메서드실행
			id = this.signDao.selectIdCheck(conn, idck);
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
		return id;
	}
}