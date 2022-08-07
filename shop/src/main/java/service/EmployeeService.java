package service;

import java.sql.*;

import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	// 회원가입 addEmployeeAction.jsp 호출
	public boolean addEmployee(Employee paramEmployee) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.

			EmployeeDao employeeDao = new EmployeeDao();
			
			if (employeeDao.insertEmployee(conn, paramEmployee) != 1) {
				throw new Exception(); // 강제 예외처리
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	// employeeLoginAction.jsp 호출
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) {
		Connection conn = null;
		Employee employee = null;
		try {
			DBUtil dbutil = new DBUtil();
			conn = dbutil.getConnection();

			EmployeeDao employeeDao = new EmployeeDao();
			employee = employeeDao.selectEmployeeLoginByIdAndPw(conn, paramEmployee);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return employee;
	}

	// Employee 탈퇴 액션페이지에서 호출되는 메서드
	public boolean removeEmployee(Employee paramEmployee) {

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음

			EmployeeDao employeeDao = new EmployeeDao();
			if (employeeDao.deleteEmployee(conn, paramEmployee) != 1) { // 1)
				throw new Exception();
			}
			OutIdDao OutIdDao = new OutIdDao();
			if (OutIdDao.insertOutId(conn, paramEmployee.getEmployeeId()) != 1) {
				throw new Exception();
			} // 2)

			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 1) or 2) 실행시 예외가 발생하면 현재 conn 실행쿼리 모두 롤백
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false; // 탈퇴 실패
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true; // 탈퇴 성공
	}

}
