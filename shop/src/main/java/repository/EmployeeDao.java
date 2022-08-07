package repository;

import java.sql.*;
import java.util.*;
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
	// 사원active 권한변경
	// EmployeeService.modifyEmployeeActiveById(String id, String Active)가 호출
	public int updateEmployeeActiveById(Connection conn, String employeeId, String active) throws Exception {
		int row = 0;
		String sql = "UPDATE employee SET active = ?, update_date = NOW() WHERE employee_id = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, active);
			stmt.setString(2, employeeId);
			row = stmt.executeUpdate();
		} finally {
			if( stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// EmployeeService.lastPage()가 호출
	public int lastPage(Connection conn) throws Exception {
		int lastPage = 0;
		String sql = "SELECT COUNT(*) count FROM employee";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				lastPage = rs.getInt("count");
			}
		} finally {
			if( rs != null) {
				rs.close();
			}
			if( stmt != null) {
				stmt.close();
			}
		}
		return lastPage;
	}
	
	// 사원 리스트
	// EmployeesService.getEmployeeList(int rowPerPage, int currentPage)가 호출
	public List<Employee> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		List<Employee> list = new ArrayList<Employee>();
		String sql = "SELECT employee_id employeeId, employee_name employeeName, create_date createDate, update_date updateDate, active FROM employee limit ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Employee employee = new Employee();
				employee.setEmployeeId(rs.getString("employeeId"));
				employee.setEmployeeName(rs.getString("employeeName"));
				employee.setUpdateDate(rs.getString("updateDate"));
				employee.setCreateDate(rs.getString("createDate"));
				employee.setActive(rs.getString("active"));
				list.add(employee);
			}
		} finally {
			if( rs != null) {
				rs.close();
			}
			if( stmt != null) {
				stmt.close();
			}
		}
		return list;
	}
	
}
