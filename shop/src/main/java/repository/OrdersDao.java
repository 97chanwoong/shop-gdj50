package repository;

import java.sql.*;
import java.util.*;
import vo.*;

public class OrdersDao {
	
	// Customer 주문 추가
	public int insertCustomerOrders(Connection conn, Orders orders) throws SQLException {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "INSERT INTO orders (goods_no, customer_id, orders_quantity, orders_price, orders_address, orders_deaddress, orders_state, update_date, create_date) VALUES (?, ?, ?, ?, ?, ?, '주문완료',  NOW(), NOW())";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orders.getGoodsNo());
			stmt.setString(2, orders.getCustomerId());
			stmt.setInt(3, orders.getOrdersQuantity());
			stmt.setInt(4, orders.getOrdersPrice());
			stmt.setString(5, orders.getOrdersAddress());
			stmt.setString(6, orders.getOrdersDeAddress());
			// 디버깅
			System.out.println(stmt + "<-- insertCustomerOrders stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// Customer 주문 환불하기 단 결제완료상태일때만
	public int updateCustomerOrders(Connection conn, int ordersNo) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE orders SET orders_state = '환불 진행중', update_date = NOW() WHERE orders_no = ? AND orders_state = '결제완료'";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);
			// 디버깅
			System.out.println(stmt + "<--  updateCustomerOrders stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// Customer 주문 취소하기 단 주문완료상태일때만
	public int deleteCustomerOrders(Connection conn, int ordersNo) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "DELETE FROM orders WHERE orders_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);
			// 디버깅
			System.out.println(stmt + "<--  deleteCustomerOrders stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	
	
	// 5-2) 주문 상세보기
	public Map<String, Object> selectOrdersOne(Connection conn, int ordersNo) throws Exception {
		// 리턴값
		Map<String, Object> map = null;
		/*
		  SELECT o. , 주문정보 g. , 상품정보 c. , 고객정보 FROM order o INNER JOIN goods g ON
		  o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_id = c.customer_id 
		  WHERE o.orders_no = ?
		 */
		// 쿼리
		String sql = "SELECT\r\n"
				+ "o.orders_no ordersNo,\r\n"
				+ "o.orders_price ordersPrice,\r\n"
				+ "o.orders_address ordersAddress,\r\n"
				+ "o.orders_deaddress ordersDeAddress,\r\n"
				+ "o.orders_quantity ordersQuantity,\r\n"
				+ "o.orders_state ordersState,\r\n"
				+ "o.update_date updateDate,\r\n"
				+ "o.create_date createDate,\r\n"
				+ "g.goods_name goodsName,\r\n"
				+ "g.goods_price goodsPrice,\r\n"
				+ "c.customer_id customerId,\r\n"
				+ "c.customer_name customerName,\r\n"
				+ "c.customer_telephone customerTelephone\r\n"
				+ "FROM orders o INNER JOIN goods g\r\n"
				+ "ON o.goods_no = g.goods_no INNER JOIN customer c\r\n"
				+ "ON o.customer_id = c.customer_id\r\n"
				+ "WHERE o.orders_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);
			// 디버깅
			System.out.println(stmt + "<--  selectOrdersOne stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("ordersNo", rs.getInt("ordersNo"));
				map.put("ordersPrice", rs.getInt("ordersPrice"));
				map.put("ordersQuantity", rs.getInt("ordersQuantity"));
				map.put("ordersState", rs.getString("ordersState"));
				map.put("ordersAddress", rs.getString("ordersAddress"));
				map.put("ordersDeAddress", rs.getString("ordersDeAddress"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("customerId", rs.getString("customerId"));
				map.put("customerName", rs.getString("customerName"));
				map.put("customerTelephone", rs.getString("customerTelephone"));
			}
			
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		return map;
	}

	// 5-1)전체 주문 목록 (관리자 페이지)
	public List<Map<String, Object>> selectOrdersList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		/*
		 * SELECT o. FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER
		 * BY create_date DESC LIMIT ?,?
		 */
		// 쿼리
		String sql = "SELECT o.orders_no ordersNo, o.goods_no goodsNo, o.customer_id customerId, o.orders_quantity ordersQuantity, o.orders_price ordersPrice, o.orders_address ordersAddress, o.orders_deaddress ordersDeAddress, o.orders_state ordersState, o.update_date updateDate, o.create_date createDate, g.goods_name goodsName, g.goods_price goodsPrice FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY o.create_date DESC LIMIT ?,?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectOrdersList stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ordersNo", rs.getInt("ordersNo"));
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("customerId", rs.getString("customerId"));
				map.put("ordersQuantity", rs.getInt("ordersQuantity"));
				map.put("ordersPrice", rs.getInt("ordersPrice"));
				map.put("ordersAddress", rs.getString("ordersAddress"));
				map.put("ordersDeAddress", rs.getString("ordersDeAddress"));
				map.put("ordersState", rs.getString("ordersState"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getString("goodsPrice"));
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

	// 주문 리스트 총 Count
	public int selectOrdersCount(Connection conn) throws Exception {
		// 리턴값
		int totalRow = 0;
		// 쿼리
		String sql = "SELECT COUNT(*) count FROM orders";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- selectOrdersCount stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalRow = rs.getInt("count");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return totalRow;
	}

	// 2-1 고객 한명의 주문 목록(관리자, 고객 페이지 둘다)
	public List<Map<String, Object>> selectOrdersListByCustomer(Connection conn, String customerId, int rowPerPage, int beginRow) throws Exception {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		/*
		 * SELECT o. FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no WHERE
		 * customer_id = ? ORDER BY create_date DESC LIMIT ?,?
		 */
		// 쿼리
		String sql = "SELECT o.orders_no ordersNo, o.goods_no goodsNo, o.orders_quantity ordersQuantity, o.orders_price ordersPrice, o.orders_address ordersAddress, o.orders_deaddress ordersDeAddress, o.orders_state ordersState, o.update_date updateDate, o.create_date createDate, g.goods_name goodsName, g.goods_price goodsPrice, r.orders_no orederNoRv FROM orders o  LEFT JOIN review r ON o.orders_no = r.orders_no INNER JOIN goods g ON o.goods_no = g.goods_no WHERE o.customer_id = ? ORDER BY o.create_date DESC LIMIT ?,?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectOrdersListByCustomer stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ordersNo", rs.getInt("ordersNo"));
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("ordersQuantity", rs.getString("ordersQuantity"));
				map.put("ordersPrice", rs.getInt("ordersPrice"));
				map.put("ordersAddress", rs.getString("ordersAddress"));
				map.put("ordersDeAddress", rs.getString("ordersDeAddress"));
				map.put("ordersState", rs.getString("ordersState"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("orederNoRv", rs.getInt("orederNoRv"));
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
	
	
	// 관리자-> 주문 내역 수정하기 
	public int updateOrdersOne(Connection conn, Orders orders) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE orders SET orders_address = ?, orders_deaddress = ?, orders_state = ?, update_date = NOW() WHERE orders_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, orders.getOrdersAddress());
			stmt.setString(2, orders.getOrdersDeAddress());
			stmt.setString(3, orders.getOrdersState());
			stmt.setInt(4, orders.getOrdersNo());
			// 디버깅
			System.out.println(stmt + "<-- updateOrdersOne stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
}
