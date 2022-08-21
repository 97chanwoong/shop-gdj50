package repository;

import java.sql.*;
import vo.Cart;

public class CartDao {
	// 장바구니
	
	// 장바구니 담기
	public int insertCart(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int row = 0;
		String sql = "INSERT INTO CART (goods_no, customer_id, cart_quantity, update_date, create_date) VALUES (?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			stmt.setInt(3, cart.getCartQuantity());
			// 디버깅
			System.out.println(stmt + "<-- insertCart");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 장바구니 수정
	public int updateCart(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int row = 0;
		// DB
		String sql = "UPDATE cart SET cart_quantity = ? WHERE goods_no = ? AND customer_id = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getCartQuantity());
			stmt.setInt(2, cart.getGoodsNo());
			stmt.setString(3, cart.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- updateCart stmt");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 장바구니 상품 하나삭제
	public int deleteCartOne(Connection conn, Cart cart) throws Exception {
		// 리턴할 변수 선언
		int row = 0;
		// DB
		String sql = "DELETE FROM cart WHERE goods_no = ? AND customer_id = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- deleteCartOne stmt");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	// 장바구니 상품 전체삭제
		public int deleteCart(Connection conn, String customerId) throws Exception {
			// 리턴할 변수 선언
			int row = 0;
			// DB
			String sql = "DELETE FROM cart WHERE customer_id = ?";
			PreparedStatement stmt = null;
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, customerId);
				// 디버깅
				System.out.println(stmt + "<-- deleteCart stmt");
				row = stmt.executeUpdate();
			} finally {
				if (stmt != null) {
					stmt.close();
				}
			}
			return row;
		}
}
