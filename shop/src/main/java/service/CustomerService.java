package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CustomerDao;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	// customerLoginAction.jsp 호출
	public Customer getCustomerByIdAndPw(Customer paramCustomer)  {
		Connection conn = null;
		Customer customer = null;
		try {
			DBUtil dbutil = new DBUtil();
			conn = dbutil.getConnection();
			
			CustomerDao customerDao = new CustomerDao();
			customer = customerDao.selectCustomerLoginByIdAndPw(conn, paramCustomer);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return customer;
	}

	// 회원탈퇴 액션페이지에서 호출되는 메서드
	public boolean removeCustomer(Customer paramCustomer) {

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음

			CustomerDao customerDao = new CustomerDao();
			if(customerDao.deleteCustomer(conn, paramCustomer) != 1) { // 1)
				throw new Exception();
			}	
			OutIdDao  CustomerOutIdDao = new OutIdDao();
			if(CustomerOutIdDao.insertOutId(conn, paramCustomer.getCustomerId()) != 1 ) {
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

