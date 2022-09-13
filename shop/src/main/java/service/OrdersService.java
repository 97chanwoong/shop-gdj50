package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import repository.OrdersDao;
import vo.Cart;
import vo.Orders;

public class OrdersService {
	private DBUtil dbutil;
	private OrdersDao ordersDao;
	
	// Customer 주문 추가
		public int addCustomerOrders(Orders orders) {
			// 리턴값
			int row = 0;
			// 초기화
			Connection conn = null;
			
			this.dbutil = new DBUtil();
			this.ordersDao = new OrdersDao();	
			
			try {
				conn = this.dbutil.getConnection();
				// 디버깅
				System.out.println(conn + "<-- addCustomerOrders conn");
				conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
				// 메서드실행
				row = this.ordersDao.insertCustomerOrders(conn, orders);
				if(row == 0) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
					throw new Exception(); // 예외처리
				}
				conn.commit();		
			} catch (Exception e) {
				e.printStackTrace();
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
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
		
	// Customer 주문 환불하기 단 결제완료상태일때만 
		public int modifyCartOrders(int ordersNo) {
			// 리턴값
			int row = 0;
			// 초기화
			Connection conn = null;
			
			this.dbutil = new DBUtil();
			this.ordersDao = new OrdersDao();	
			
			try {
				conn = this.dbutil.getConnection();
				// 디버깅
				System.out.println(conn + "<-- modifyCartOrders conn");
				// 메서드실행
				row = this.ordersDao.updateCustomerOrders(conn, ordersNo);
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
	// Customer 주문 취소하기 단 주문완료상태일때만	
		public int removeCartOrders(int ordersNo) {
			// 리턴값
			int row = 0;
			// 초기화
			Connection conn = null;
			
			this.dbutil = new DBUtil();
			this.ordersDao = new OrdersDao();	
			
			try {
				conn = this.dbutil.getConnection();
				// 디버깅
				System.out.println(conn + "<-- removeCartOrders conn");
				// 메서드실행
				row = this.ordersDao.deleteCustomerOrders(conn, ordersNo);
				if (row == 0) {
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
			return row;
		}
	// OrdersNo 상세보기
	public Map<String, Object> getOrdersOne(int ordersNo) {
		// 리턴값
		Map<String, Object> map = null;
		// 초기화
		Connection conn = null;
		
		this.dbutil = new DBUtil();
		this.ordersDao = new OrdersDao();	

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getOrdersOne conn");
			// 메서드실행
			map = this.ordersDao.selectOrdersOne(conn, ordersNo);
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

	// 주문 전체리스트
	public List<Map<String, Object>> getOrdersList(int rowPerPage, int currentPage) {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<>();
		// 초기화
		Connection conn = null;
		
		this.dbutil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getOrdersList conn");
			// 메서드실행
			list = this.ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
			if (list != null) {
				System.out.println("실행 성공");
			} else {
				System.out.println("실행 실패");
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
	
	// 주문품목 리스트 라스트 페이지
		public int OrdersLastPage(int rowPerPage) {
			// 리턴값
			int lastPage = 0;
			
			int totalRow = 0;
			// 초기화
			Connection conn = null;
			
			this.dbutil = new DBUtil();
			this.ordersDao = new OrdersDao();
			
			try {
				conn = this.dbutil.getConnection();
				// 디버깅
				System.out.println(conn + "<-- OrdersLastPage conn");
				// 메서드실행
				totalRow = this.ordersDao.selectOrdersCount(conn);
				lastPage = (int) Math.ceil(totalRow / (double) rowPerPage);
				if (lastPage == 0) {
					throw new Exception(); // 예외처리
				}
				conn.commit();
			} catch (Exception e) {
				e.printStackTrace();
				// 실패라면 rollback
				try {
					conn.rollback();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
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

	// 고객 한명의 주문 리스트(관리자, 고객 페이지 둘다)
	public List<Map<String, Object>> getOrdersListByCustomer(int rowPerPage, int currentPage, String customerId) {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<>();
		// 초기화
		Connection conn = null;
		
		this.dbutil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getOrdersList conn");
			// 메서드실행
			list = this.ordersDao.selectOrdersListByCustomer(conn, customerId, rowPerPage, beginRow);
			if (list != null) {
				System.out.println("실행 성공");
			} else {
				System.out.println("실행 실패");
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

	// 주문내역 수정하기
	public int modifyOrdersOne(Orders orders) {
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;
		
		this.dbutil = new DBUtil();
		this.ordersDao = new OrdersDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getOrdersList conn");
			// 메서드실행
			row = this.ordersDao.updateOrdersOne(conn, orders);
			if(row == 0) {
				throw new Exception(); // 예외처리
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}

}
