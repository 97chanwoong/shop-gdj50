package repository;

import java.sql.*;
import vo.Customer;

public class CustomerDao {
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
			System.out.println(stmt +"<--stmt");
			row = stmt.executeUpdate();
			System.out.println(row +"<--row");
		} finally {
			if(stmt != null ) {
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
			if(rs.next()) {
				loginCustomer = new Customer();
				loginCustomer.setCustomerId(rs.getString("customerId"));
				loginCustomer.setCustomerName(rs.getString("customerName"));
			}
		} finally {
			if(rs!=null) {
				rs.close();
			}
			if(stmt!=null) {
				stmt.close();
			}
		}
		return loginCustomer;
	}
	
	//탈퇴
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
		return row ;
	}
}
