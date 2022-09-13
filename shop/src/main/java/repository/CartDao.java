package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Cart;

public class CartDao {
	// 장바구니 리스트
	public List<Map<String, Object>> selectCartList(Connection conn, String customerId) throws Exception {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<>();
		// 쿼리
		String sql = "SELECT c.cart_quantity cartQuantity, c.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename fileName FROM cart c INNER JOIN goods g USING(goods_no) INNER JOIN goods_img gi USING(goods_no) WHERE customer_Id = ?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println(stmt + "<-- selectCartList stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("cartQuantity", rs.getInt("cartQuantity"));
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("fileName", rs.getString("fileName"));
				list.add(map);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	}

	// 장바구니에 같은담은 상품이 있는지 확인
	public int selectCart(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int count = 0;
		// 쿼리
		String sql = "SELECT COUNT(*) count FROM cart WHERE customer_id = ? AND goods_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cart.getCustomerId());
			stmt.setInt(2, cart.getGoodsNo());
			// 디버깅
			System.out.println(stmt + "<-- selectCart stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return count;
	}

	// 장바구니 담기
	public int insertCart(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "INSERT INTO cart (goods_no, customer_id, cart_quantity, update_date, create_date) VALUES (?, ?, ?, NOW(), NOW())";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			stmt.setInt(3, cart.getCartQuantity());
			// 디버깅
			System.out.println(stmt + "<-- insertCart stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 장바구니에 같은물건이 있을 경우 update문
	public int updateCartSame(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE cart SET cart_quantity =  cart_quantity + ? WHERE goods_no = ? AND customer_id = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getCartQuantity());
			stmt.setInt(2, cart.getGoodsNo());
			stmt.setString(3, cart.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- updateCartSame stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 장바구니 상품수정
	public int updateCartOne(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE cart SET cart_quantity = ? WHERE goods_no = ? AND customer_id = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getCartQuantity());
			stmt.setInt(2, cart.getGoodsNo());
			stmt.setString(3, cart.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- updateCartOne stmt");
			// 쿼리실행
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
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "DELETE FROM cart WHERE goods_no = ? AND customer_id = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- deleteCartOne stmt");
			// 쿼리실행
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
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "DELETE FROM cart WHERE customer_id = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println(stmt + "<-- deleteCart stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 장바구니 담긴 개수
	public int CartCount(Connection conn, String customerId) throws Exception {
		// 리턴값
		int cnt = 0;
		// 쿼리
		String sql = "SELECT COUNT(*) cnt FROM cart WHERE customer_Id = ?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println(stmt + "<-- CartCount stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt("cnt");
				// 디버깅
				System.out.println(cnt + " <-- CartCount cnt");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return cnt;
	}

	// 상품 가격 찾아주는 메서드
	public int selectGoodsPrice(Connection conn, int goodsNo) throws Exception {
		// 리턴값
		int goodsPrice = 0;
		// 쿼리
		String sql = "SELECT goods_price goodsPrice FROM goods WHERE goods_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println(stmt + "<-- selectGoodsPrice stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				goodsPrice = rs.getInt("goodsPrice");
				System.out.println(goodsPrice + " <-- selectGoodsPrice  goodsPrice");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return goodsPrice;
	}
}