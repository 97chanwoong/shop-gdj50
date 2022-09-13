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
	private DBUtil dbutil;
	private CustomerDao customerDao;

	// 관리자 -> Customer 리스트
	public List<Customer> getCustomerList(int rowPerPage, int currentPage) {
		// 리턴값
		List<Customer> list = new ArrayList<>();
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		// beginRow
		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getCustomerList conn");
			// 메서드실행
			list = this.customerDao.selectCustomerList(conn, rowPerPage, beginRow);
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

	// 관리자 -> 회원 임시 비밀번호 변경
	public int modifyAdminCustomerPass(Customer customer) {
		// 리턴 갑
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- modifyAdminCustomerPass conn");
			// 메서드실행
			row = this.customerDao.updateAdminCustomerPass(conn, customer);
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

	// 관리자 -> 회원 강제 탈퇴
	public boolean removeAdminCustomer(String customerId) {
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- removeAdminCustomer conn");

			conn.setAutoCommit(false); // executeUpdate() 실행시 자동 커밋 막음
			// 분기
			if (this.customerDao.deleteAdminCustomer(conn, customerId) != 1) { // 1)
				throw new Exception(); // 예외처리
			}
			OutIdDao CustomerOutIdDao = new OutIdDao();
			if (CustomerOutIdDao.insertOutId(conn, customerId) != 1) {
				throw new Exception(); // 예외처리
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
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return true; // 탈퇴 성공
	}

	// 고객리스트 LastPage
	public int getCustomerLastPage(int rowPerPage) {
		// 리턴값
		int lastPage = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getCustomerLastPage conn");
			// 메서드실행
			int totalRow = this.customerDao.selectCustomerCount(conn);
			lastPage = (int) Math.ceil(totalRow / (double) rowPerPage);
			if (lastPage == 0) {
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
		return lastPage;
	}

	// Customer 상세보기
	public Map<String, Object> getCustomerOne(String customerId) {
		// 리턴값
		Map<String, Object> map = null;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getCustomerOne conn");
			// 메서드실행
			map = this.customerDao.selectCustomerOne(conn, customerId);
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
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- addCustomer conn");

			conn.setAutoCommit(false); // executeUpdate(); 실행시 자동 커밋을 막는다

			if (this.customerDao.insertCustomer(conn, paramCustomer) != 1) {
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

	// Customer 로그인 customerLoginAction.jsp 호출
	public Customer getCustomerByIdAndPw(Customer paramCustomer) {
		// 리턴값
		Customer customer = null;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getCustomerByIdAndPw conn");
			// 메서드실행
			customer = this.customerDao.selectCustomerLoginByIdAndPw(conn, paramCustomer);
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

	// Customer 정보수정을 위한 아이디 비밀번호 확인
	public Customer checkCustomerIdAndPass(Customer paramCustomer) {
		// 리턴값
		Customer customer = null;
		// conn 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- checkCustomerIdAndPass conn");
			// 메서드 실행
			customer = this.customerDao.selectCustomerIdAndPass(conn, paramCustomer);
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

	// Customer 개인정보수정
	public int modifyCustomerOne(Customer customer) {
		// 리턴값
		int row = 0;
		// conn 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- modifyCustomerOne conn");
			// 메서드실행
			row = this.customerDao.updateCustomerOne(conn, customer);
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

	// Customer 비밀번호 변경
	public int modifyCustomerPass(Map<String, Object> map) {
		// 리턴 갑
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- modifyCustomerPass conn");
			// 메서드실행
			row = this.customerDao.updateCustomerPass(conn, map);
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

	// 회원탈퇴 액션페이지에서 호출되는 메서드
	public boolean removeCustomer(Customer paramCustomer) {
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.customerDao = new CustomerDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- removeCustomer conn");

			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음

			if (this.customerDao.deleteCustomer(conn, paramCustomer) != 1) { // 1)
				throw new Exception(); // 예외처리
			}
			OutIdDao CustomerOutIdDao = new OutIdDao();
			if (CustomerOutIdDao.insertOutId(conn, paramCustomer.getCustomerId()) != 1) {
				throw new Exception(); // 예외처리
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
