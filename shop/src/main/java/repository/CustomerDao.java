package repository;

import java.sql.*;
import java.util.*;

import vo.Customer;

public class CustomerDao {
	// Customer 리스트
	public List<Customer> selectCustomerList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		// 고객 리스트를 담을 ArrayList객체 생성
		List<Customer> list = new ArrayList<>();
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_telephone customerTelephone, update_date updateDate, create_date createDate FROM customer ORDER BY create_date DESC LIMIT ?,?";
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
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_telephone customerTelephone, update_date updateDate, create_date createDate FROM customer WHERE customer_id = ?";
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
		String sql = "INSERT INTO customer VALUES(?,PASSWORD(?),?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			stmt.setString(3, paramCustomer.getCustomerName());
			stmt.setString(4, paramCustomer.getCustomerAddress());
			stmt.setString(5, paramCustomer.getCustomerTelephone());
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

	// 관리자 -> 회원 임시 비밀번호 정보 수정
	public int updateCustomerPass(Connection conn, Customer customer) throws Exception {
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "UPDATE  customer SET customer_pass=PASSWORD(?) WHERE customer_id= ? ";
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
		public int deleteCustomerOne(Connection conn, String customerId) throws Exception {
			int row = 0;
			String sql ="DELETE FROM customer WHERE customer_id= ?";
			PreparedStatement stmt = null;
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, customerId);
				// 디버깅
				System.out.println(stmt + "<-- deleteCustomerOne stmt");
				row = stmt.executeUpdate();
			} finally {
				if(stmt != null) {
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
