package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CustomerDao;
import repository.NoticeDao;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	private CustomerDao customerDao;

	// 회원 정보수정을 위한 아이디 비밀번호 확인
	public Customer checkCustomerIdAndPass(Customer paramCustomer) {
		Customer customer = null;
		Connection conn = null;
		customerDao = new CustomerDao();
		try {
			conn = new DBUtil().getConnection();
			customer = customerDao.selectCustomerIdAndPass(conn, paramCustomer);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return customer;
	}

	// 비밀번호 변경
	public int modifyCustomerPass(Customer customer) {
		// 리턴 갑
		int row = 0;
		// 초기화
		Connection conn = null;
		// CustomerDao
		customerDao = new CustomerDao();
		try {
			conn = new DBUtil().getConnection();
			row = customerDao.updateCustomerPass(conn, customer);
			if (row == 0) {
				throw new Exception(); // 예외처리
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}

	// 회원 강제 탈퇴
	public boolean removeAdminCustomer(String customerId) {
		// 초기화
		Connection conn = null;
		// CustomerDao
		customerDao = new CustomerDao();
		// OutIdDao
		OutIdDao CustomerOutIdDao = new OutIdDao();
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행시 자동 커밋 막음
			if (customerDao.deleteAdminCustomer(conn, customerId) != 1) { // 1)
				throw new Exception();
			}
			if (CustomerOutIdDao.insertOutId(conn, customerId) != 1) {
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

	// 고객 리스트
	public List<Customer> getCustomerList(int rowPerPage, int currentPage) {
		List<Customer> list = new ArrayList<>();
		Connection conn = null;
		customerDao = new CustomerDao();
		// beginRow
		int beginRow = (currentPage - 1) * rowPerPage;
		try {
			conn = new DBUtil().getConnection();
			list = customerDao.selectCustomerList(conn, rowPerPage, beginRow);
			if (list == null) {
				throw new Exception(); // 예외처리
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}

	// 고객리스트 LastPage
	public int getCustomerLastPage(int rowPerPage) {
		int lastPage = 0;
		// 초기화
		Connection conn = null;
		// CustomerDao 객체
		customerDao = new CustomerDao();
		try {
			conn = new DBUtil().getConnection();
			int totalRow = customerDao.selectCustomerCount(conn);
			lastPage = (int) Math.ceil(totalRow / (double) rowPerPage);
			if (lastPage == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return lastPage;
	}

	// 고객 상세보기
	public Map<String, Object> getCustomerOne(String customerId) {
		// 리턴 객체 생성
		Map<String, Object> map = null;
		// 초기화
		Connection conn = null;
		// CustomerDao
		customerDao = new CustomerDao();
		try {
			conn = new DBUtil().getConnection();
			map = customerDao.selectCustomerOne(conn, customerId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return map;
	}

	// 회원가입 addCustomerAction.jsp 호출
	public boolean addCustomer(Customer paramCustomer) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate(); 실행시 자동 커밋을 막는다

			CustomerDao customerDao = new CustomerDao();

			if (customerDao.insertCustomer(conn, paramCustomer) != 1) {
				throw new Exception(); // 강제 예외 처리
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 1) or 2) 실행시 예외가 발생하면 현재 conn 실행쿼리 모두 롤백
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false; // 회원가입 실패
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true; // 회원가입 성공
	}

	// 로그인 customerLoginAction.jsp 호출
	public Customer getCustomerByIdAndPw(Customer paramCustomer) {
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
			if (customerDao.deleteCustomer(conn, paramCustomer) != 1) { // 1)
				throw new Exception();
			}
			OutIdDao CustomerOutIdDao = new OutIdDao();
			if (CustomerOutIdDao.insertOutId(conn, paramCustomer.getCustomerId()) != 1) {
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
