package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import repository.OrdersDao;

public class OrdersService {
	private OrdersDao ordersDao;
	// OrdersNo 상세보기
	public Map<String, Object> getOrdersOne(int ordersNo){
		Map<String, Object> map = null;
		Connection conn = null;
		this.ordersDao = new OrdersDao();
		
		try {
			conn = new DBUtil().getConnection();
			map = this.ordersDao.selectOrdersOne(conn, ordersNo);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		return map;
	}
	// 주문품목 리스트 라스트 페이지
	public int OrdersLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalRow = 0;
		Connection conn = null;
		this.ordersDao = new OrdersDao();
		
		try {
			conn = new DBUtil().getConnection();
			totalRow = ordersDao.selectOrdersCount(conn);
			lastPage = (int) Math.ceil (totalRow / (double)rowPerPage);
			if(lastPage == 0) {
				throw new Exception();
			}
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 실패라면 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// DB 자원해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return lastPage;
	}
	// 주문 전체리스트
	public List<Map<String, Object>> getOrdersList(int rowPerPage, int currentPage) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		
		int beginRow = (currentPage - 1)* rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			list = ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
			if(list != null) {
				System.out.println("실행 성공");
			} else {
				System.out.println("실행 실패");
				throw new Exception();
			}
					
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	// 고객 한명의 주문 리스트(관리자, 고객 페이지 둘다)
	public List<Map<String, Object>> getOrdersListByCustomer(int rowPerPage, int currentPage, String customerId) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		
		int beginRow = (currentPage - 1)* rowPerPage;
		
		try {
			conn = new DBUtil().getConnection();
			list = ordersDao.selectOrdersListByCustomer(conn, customerId, rowPerPage, beginRow);
			if(list != null) {
				System.out.println("실행 성공");
			} else {
				System.out.println("실행 실패");
				throw new Exception();
			}
					
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}

}
