package repository;

import java.sql.*;
import java.util.*;

import vo.Customer;

public class CustomerDao {
	// Customer 리스트
	public List<Customer> selectCustomerList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		// 고객 리스트를 담을 ArrayList객체 생성
		List<Customer> list = new ArrayList<>();
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_deaddress customerDeAddress ,customer_telephone customerTelephone, update_date updateDate, create_date createDate FROM customer ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectCustomerList stmt");
			rs = stmt.executeQuery();
			while (rs.next()) {
				Customer customer = new Customer();
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setCustomerDeAddress(rs.getString("customerDeAddress"));
				customer.setCustomerTelephone(rs.getString("customerTelephone"));
				customer.setUpdateDate(rs.getString("updateDate"));
				customer.setCreateDate(rs.getString("createDate"));
				list.add(customer);
			}
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	}

	// Customer 상세보기
	public Map<String, Object> selectCustomerOne(Connection conn, String customerId) throws Exception {
		// Map 객체 생성
		Map<String, Object> map = null;
		// DB 자원
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_deaddress customerDeAddress, customer_telephone customerTelephone, update_date updateDate, create_date createDate FROM customer WHERE customer_id = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println(stmt + "<-- selectCustomerOne stmt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				map = new HashMap<>();
				map.put("customerId", rs.getString("customerId"));
				map.put("customerName", rs.getString("customerName"));
				map.put("customerAddress", rs.getString("customerAddress"));
				map.put("customerDeAddress", rs.getString("customerDeAddress"));
				map.put("customerTelephone", rs.getString("customerTelephone"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return map;
	}

	// Customer 리스트 total
	public int selectCustomerCount(Connection conn) throws Exception {
		int totalRow = 0;
		String sql = "SELECT COUNT(*) count FROM customer";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalRow = rs.getInt("count");
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

	// 회원가입
	public int insertCustomer(Connection conn, Customer paramCustomer) throws Exception {
		int row = 0;
		String sql = "INSERT INTO customer VALUES(?,PASSWORD(?),?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			stmt.setString(3, paramCustomer.getCustomerName());
			stmt.setString(4, paramCustomer.getCustomerAddress());
			stmt.setString(5, paramCustomer.getCustomerDeAddress());
			stmt.setString(6, paramCustomer.getCustomerTelephone());
			System.out.println(stmt + "<--stmt");
			row = stmt.executeUpdate();
			System.out.println(row + "<--row");
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// Customer 로그인
	public Customer selectCustomerLoginByIdAndPw(Connection conn, Customer customer) throws Exception {
		Customer loginCustomer = null;
		String sql = "SELECT customer_id customerId, customer_name customerName FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			rs = stmt.executeQuery();
			if (rs.next()) {
				loginCustomer = new Customer();
				loginCustomer.setCustomerId(rs.getString("customerId"));
				loginCustomer.setCustomerName(rs.getString("customerName"));
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return loginCustomer;
	}

	// 회원 정보수정을 위한 아이디 비밀번호 확인
	public Customer selectCustomerIdAndPass(Connection conn, Customer customer) throws Exception {
		Customer checkCustomer = null;
		String sql = "SELECT customer_id customerId FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			rs = stmt.executeQuery();
			if (rs.next()) {
				 checkCustomer = new Customer();
				 checkCustomer.setCustomerId(rs.getString("customerId"));
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return  checkCustomer;
	}

	// 개인정보수정
	public int updateCustomerOne(Connection conn, Customer customer) throws Exception {
		int row = 0;
		String sql = "UPDATE customer SET customer_name = ?, customer_address = ?, customer_deaddress = ?, customer_telephone = ?, update_date = NOW() WHERE customer_id = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerName());
			stmt.setString(2, customer.getCustomerAddress());
			stmt.setString(3, customer.getCustomerDeAddress());
			stmt.setString(4, customer.getCustomerTelephone());
			stmt.setString(5, customer.getCustomerId());
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 비밀번호 변경
	public int updateCustomerPass(Connection conn, Map<String,Object> map) throws Exception {
		int row = 0;
		String sql = "UPDATE  customer SET customer_pass = PASSWORD(?), update_date = NOW() WHERE customer_id= ? And customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, (String)map.get("customerNewPass"));
			stmt.setString(2, (String)map.get("customerId"));
			stmt.setString(3,(String)map.get("customerPass"));
			// 디버깅
			System.out.println(stmt + "<-- updateCustomerPass stmt");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 관리자 -> 회원 임시 비밀번호 변경
	public int updateAdminCustomerPass(Connection conn, Customer customer) throws Exception {
		int row = 0;
		String sql = "UPDATE  customer SET customer_pass = PASSWORD(?), update_date = NOW() WHERE customer_id= ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerPass());
			stmt.setString(2, customer.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- updateCustomerPass stmt");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 관리자 -> 회원 강제 탈퇴
	public int deleteAdminCustomer(Connection conn, String customerId) throws Exception {
		int row = 0;
		String sql = "DELETE FROM customer WHERE customer_id= ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println(stmt + "<-- deleteCustomerOne stmt");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 탈퇴
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int deleteCustomer(Connection conn, Customer paramCustomer) throws Exception {
		int row = 0;
		String sql = "DELETE FROM customer WHERE customer_id=? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			row = stmt.executeUpdate();
		} finally {
			stmt.close();
		}
		// 동일한 conn
		// conn.close() X
		return row;
	}
}
