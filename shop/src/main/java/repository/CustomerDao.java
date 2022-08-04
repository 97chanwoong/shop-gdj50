package repository;

import java.sql.*;
import vo.Customer;

public class CustomerDao {
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
