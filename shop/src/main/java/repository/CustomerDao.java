package repository;

import java.sql.*;
import java.util.*;

import vo.Customer;

public class CustomerDao {
	//  관리자 -> Customer 리스트
	public List<Customer> selectCustomerList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		// 리턴값
		List<Customer> list = new ArrayList<>();
		// 쿼리
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_deaddress customerDeAddress ,customer_telephone customerTelephone, update_date updateDate, create_date createDate FROM customer ORDER BY create_date DESC LIMIT ?,?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectCustomerList stmt");
			// 쿼리실행
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
	
	// 관리자 -> 회원 임시 비밀번호 변경
		public int updateAdminCustomerPass(Connection conn, Customer customer) throws Exception {
			// 리턴값
			int row = 0;
			// 쿼리
			String sql = "UPDATE  customer SET customer_pass = PASSWORD(?), update_date = NOW() WHERE customer_id= ?";
			// 초기화
			PreparedStatement stmt = null;
			try {
				// 쿼리담기
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, customer.getCustomerPass());
				stmt.setString(2, customer.getCustomerId());
				// 디버깅
				System.out.println(stmt + "<-- updateCustomerPass stmt");
				// 쿼리실행
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
			// 리턴값
			int row = 0;
			// 쿼리
			String sql = "DELETE FROM customer WHERE customer_id= ?";
			// 초기화
			PreparedStatement stmt = null;
			try {
				// 쿼리담기
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, customerId);
				// 디버깅
				System.out.println(stmt + "<-- deleteCustomerOne stmt");
				// 쿼리실행
				row = stmt.executeUpdate();
			} finally {
				if (stmt != null) {
					stmt.close();
				}
			}
			return row;
		}

	// Customer 리스트 total
	public int selectCustomerCount(Connection conn) throws Exception {
		// 리턴값
		int totalRow = 0;
		// 쿼리
		String sql = "SELECT COUNT(*) count FROM customer";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- selectCustomerCount stmt");
			// 쿼리실행
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
	
	// Customer 상세보기
		public Map<String, Object> selectCustomerOne(Connection conn, String customerId) throws Exception {
			// 리턴값
			Map<String, Object> map = null;
			// 쿼리
			String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_deaddress customerDeAddress, customer_telephone customerTelephone, update_date updateDate, create_date createDate FROM customer WHERE customer_id = ?";
			// 초기화
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				// 쿼리담기
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, customerId);
				// 디버깅
				System.out.println(stmt + "<-- selectCustomerOne stmt");
				// 쿼리실행
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


	// 회원가입
	public int insertCustomer(Connection conn, Customer paramCustomer) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "INSERT INTO customer VALUES(?,PASSWORD(?),?,?,?,?,NOW(),NOW())";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			stmt.setString(3, paramCustomer.getCustomerName());
			stmt.setString(4, paramCustomer.getCustomerAddress());
			stmt.setString(5, paramCustomer.getCustomerDeAddress());
			stmt.setString(6, paramCustomer.getCustomerTelephone());
			// 디버깅
			System.out.println(stmt + "<-- insertCustomer stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// Customer 로그인
	public Customer selectCustomerLoginByIdAndPw(Connection conn, Customer customer) throws Exception {
		// 리턴값
		Customer loginCustomer = null;
		// 쿼리
		String sql = "SELECT customer_id customerId, customer_name customerName FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			// 디버깅
			System.out.println(stmt + "<-- selectCustomerLoginByIdAndPw stmt");
			// 쿼리실행
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

	// Customer 정보수정을 위한 아이디 비밀번호 확인
	public Customer selectCustomerIdAndPass(Connection conn, Customer customer) throws Exception {
		// 리턴값
		Customer checkCustomer = null;
		// 쿼리
		String sql = "SELECT customer_id customerId FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			// 디버깅
			System.out.println(stmt + "<-- selectCustomerIdAndPass stmt");
			// 쿼리실행
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

	// Customer 개인정보수정
	public int updateCustomerOne(Connection conn, Customer customer) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE customer SET customer_name = ?, customer_address = ?, customer_deaddress = ?, customer_telephone = ?, update_date = NOW() WHERE customer_id = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerName());
			stmt.setString(2, customer.getCustomerAddress());
			stmt.setString(3, customer.getCustomerDeAddress());
			stmt.setString(4, customer.getCustomerTelephone());
			stmt.setString(5, customer.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- updateCustomerOne stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	
	//  Customer 비밀번호 변경
	public int updateCustomerPass(Connection conn, Map<String,Object> map) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE  customer SET customer_pass = PASSWORD(?), update_date = NOW() WHERE customer_id= ? And customer_pass = PASSWORD(?)";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, (String)map.get("customerNewPass"));
			stmt.setString(2, (String)map.get("customerId"));
			stmt.setString(3,(String)map.get("customerPass"));
			// 디버깅
			System.out.println(stmt + "<-- updateCustomerPass stmt");
			// 쿼리실행
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
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "DELETE FROM customer WHERE customer_id=? AND customer_pass = PASSWORD(?)";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			// 디버깅
			System.out.println(stmt + "<-- deleteCustomer stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			stmt.close();
		}
		return row;
	}
}
