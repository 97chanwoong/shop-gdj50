package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import repository.CustomerDao;
import repository.GoodsDao;
import vo.Cart;

public class CartService {
	private DBUtil dbutil;
	private CartDao cartDao;

	// 장바구니 리스트
	public List<Map<String, Object>> getCustomerCartList(String customerId) {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<>();
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.cartDao = new CartDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getCustomerCartList conn");
			// 메서드실행
			list = this.cartDao.selectCartList(conn, customerId);
			// 분기
			if (list != null) {
				System.out.println("실행성공");
			} else {
				System.out.print("실행실패");
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

	// 장바구니 담기
	public int addCart(Cart cart) {
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.cartDao = new CartDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- addCart conn");
			// 메서드실행
			int count = cartDao.selectCart(conn, cart);
			// 분기
			if (count == 0) {
				row = this.cartDao.insertCart(conn, cart);
			} else if (count > 0) {
				row = this.cartDao.updateCartSame(conn, cart);
			}
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

	// 장바구니 수정
	public int modifyCartOne(Cart cart) {
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.cartDao = new CartDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- modifyCartOne conn");
			// 메서드실행
			row = this.cartDao.updateCartOne(conn, cart);
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

	// 장바구니 하나 삭제
	public int removeCartOne(Cart cart) {
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.cartDao = new CartDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- removeCartOne conn");
			// 메서드실행
			row = this.cartDao.deleteCartOne(conn, cart);
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

	// 장바구니 전체 삭제
	public int removeCartAll(String customerId) {
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.cartDao = new CartDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- removeCartAll conn");
			// 메서드실행
			row = this.cartDao.deleteCart(conn, customerId);
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

	// 장바구니 담긴 개수
		public int getCartCount(String customerId) {
			// 리턴값
			int cnt = 0;
			// 초기화
			Connection conn = null;

			this.dbutil = new DBUtil();
			this.cartDao = new CartDao();
			
			try {
				conn = this.dbutil.getConnection();
				// 디버깅
				System.out.println(conn + "<-- getCartCount conn");
				// 메서드실행
				cnt = this.cartDao.CartCount(conn, customerId);
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
			return cnt;
		}

	// 상품 가격 찾아주는 메서드
	public int getGoodsPrice(int goodsNo) {
		// 리턴값
		int goodsPrice = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.cartDao = new CartDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getGoodsPrice conn");
			// 메서드실행
			goodsPrice = cartDao.selectGoodsPrice(conn, goodsNo);
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
		return goodsPrice;
	}
}
