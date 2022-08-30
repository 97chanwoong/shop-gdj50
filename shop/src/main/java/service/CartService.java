package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import repository.GoodsDao;
import vo.Cart;

public class CartService {
	private CartDao cartDao;
	private DBUtil dbutil;

	// 장바구니 리스트
	public List<Map<String, Object>> getCustomerCartList(String customerId) {
		List<Map<String, Object>> list = new ArrayList<>();
		cartDao = new CartDao();
		dbutil = new DBUtil();
		Connection conn = null;

		try {
			conn = dbutil.getConnection();
			list = cartDao.selectCartList(conn, customerId);
			if (list != null) {
				System.out.println("실행성공");
			} else {
				System.out.print("실행실패");
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
		return list;
	}

	// 장바구니 담기
	public int addCart(Cart cart) {
		int row = 0;
		Connection conn = null;
		cartDao = new CartDao();
		dbutil = new DBUtil();

		try {
			conn = dbutil.getConnection();
			int count = cartDao.selectCart(conn, cart);
			if (count == 0) {
				row = cartDao.insertCart(conn, cart);
			} else if (count > 0) {
				row = cartDao.updateCartSame(conn, cart);
			}
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
	
	// 장바구니 수정
		public int modifyCartOne(Cart cart) {
			int row = 0;
			Connection conn = null;
			cartDao = new CartDao();
			dbutil = new DBUtil();

			try {
				conn = dbutil.getConnection();
				row = cartDao.updateCartOne(conn, cart);
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

	// 장바구니 하나 삭제
	public int removeCartOne(Cart cart) {
		int row = 0;
		Connection conn = null;
		cartDao = new CartDao();
		dbutil = new DBUtil();
		try {
			conn = dbutil.getConnection();
			row = cartDao.deleteCartOne(conn, cart);
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
	
	// 장바구니 전체 삭제
	public int removeCartAll(String customerId) {
		int row = 0;
		Connection conn = null;
		cartDao = new CartDao();
		dbutil = new DBUtil();
		try {
			conn = dbutil.getConnection();
			row = cartDao.deleteCart(conn, customerId);
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


}
