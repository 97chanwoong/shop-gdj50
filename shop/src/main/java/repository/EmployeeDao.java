package repository;

import java.sql.*;
import java.util.*;
import vo.Employee;
import service.*;

public class EmployeeDao {
	// Employee 회원가입
	public int insertEmployee(Connection conn, Employee paramEmployee) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "INSERT INTO employee(employee_id,employee_pass,employee_name,update_date,create_date) VALUES(?, PASSWORD(?), ?, NOW(), NOW())";
		// 초기화
		PreparedStatement stmt = conn.prepareStatement(sql);
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			stmt.setString(3, paramEmployee.getEmployeeName());
			// 디버깅
			System.out.println(stmt + "<-- insertEmployee stmt");
			// 쿼리실행
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
		// 리턴값
		Employee loginEmployee = null;
		// 쿼리
		String sql = "SELECT employee_id employeeId, employee_name employeeName FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			// 디버깅
			System.out.println(stmt + "<-- selectEmployeeLoginByIdAndPw stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employeeId"));
				loginEmployee.setEmployeeName(rs.getString("employeeName"));
				// 디버깅
				System.out.println(loginEmployee + "<-- selectEmployeeLoginByIdAndPw loginEmployee");
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

	// Employee 탈퇴
	// EmployeeService.removeEmployee(Employee paramEmployee)가 호출
	public int deleteEmployee(Connection conn, Employee paramEmployee) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "DELETE FROM employee WHERE employee_id=? AND employee_pass = PASSWORD(?)";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			// 디버깅
			System.out.println(stmt + "<-- deleteEmployee stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// Employee 리스트
	// EmployeesService.getEmployeeList(int rowPerPage, int currentPage)가 호출
	public List<Employee> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		// 리턴값
		List<Employee> list = new ArrayList<Employee>();
		// 쿼리
		String sql = "SELECT employee_id employeeId, employee_name employeeName, create_date createDate, update_date updateDate, active FROM employee ORDER BY create_date limit ?,?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectEmployeeList stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			while (rs.next()) {
				Employee employee = new Employee();
				employee.setEmployeeId(rs.getString("employeeId"));
				employee.setEmployeeName(rs.getString("employeeName"));
				employee.setUpdateDate(rs.getString("updateDate"));
				employee.setCreateDate(rs.getString("createDate"));
				employee.setActive(rs.getString("active"));
				list.add(employee);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	}

	// Employee 리스트 total
	public int selectEmployeeCount(Connection conn) throws Exception {
		// 리턴값
		int totalRow = 0;
		// 쿼리
		String sql = "SELECT COUNT(*) count FROM employee";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- selectEmployeeCount stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalRow = rs.getInt("count");
				// 디버깅
				System.out.println(totalRow + "<-- selectEmployeeCount totalRow");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return totalRow;
	}

	// Employee 사원active 권한변경
	// EmployeeService.modifyEmployeeActiveById(String id, String Active)가 호출
	public int updateEmployeeActiveById(Connection conn, String employeeId, String active) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE employee SET active = ?, update_date = NOW() WHERE employee_id = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, active);
			stmt.setString(2, employeeId);
			// 디버깅
			System.out.println(stmt + "<-- updateEmployeeActiveById stmt");
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
