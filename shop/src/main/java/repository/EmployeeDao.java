package repository;

import java.sql.*;

import vo.Employee;
import service.*;

public class EmployeeDao {
	// 회원가입
	public int insertEmployee(Connection conn, Employee paramEmployee) throws Exception {
		int row = 0;

		String sql = "INSERT INTO employee(employee_id,employee_pass,employee_name,update_date,create_date) VALUES(?, PASSWORD(?), ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			stmt.setString(3, paramEmployee.getEmployeeName());
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// Employee 로그인
	public Employee selectEmployeeLoginByIdAndPw(Connection conn, Employee employee) throws Exception {
		Employee loginEmployee = null;
		String sql = "SELECT employee_id employeeId, employee_name employeeName FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			rs = stmt.executeQuery();
			if (rs.next()) {
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employeeId"));
				loginEmployee.setEmployeeName(rs.getString("employeeName"));
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return loginEmployee;
	}

	// 탈퇴
	// EmployeeService.removeEmployee(Employee paramEmployee)가 호출
	public int deleteEmployee(Connection conn, Employee paramEmployee) throws Exception {
		int row = 0;
		String sql = "DELETE FROM employee WHERE employee_id=? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		DBUtil dbutil = new DBUtil();
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			row = stmt.executeUpdate();
		} finally {
			stmt.close();
		}
		// 동일한 conn
		// conn.close() X
		return row;
	}

}
