package repository;

import java.sql.*;
import java.util.*;
import vo.*;

public class OrdersDao {
	// 5-2) 주문 상세보기
	public Map<String, Object> selectOrdersOne(Connection conn, int ordersNo) throws Exception {
		Map<String, Object> map = null;
		/*
		  SELECT o. , 주문정보 g. , 상품정보 c. , 고객정보 FROM order o INNER JOIN goods g ON
		  o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_id = c.customer_id 
		  WHERE o.orders_no = ?
		 */
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
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);
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
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		/*
		 * SELECT o. FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER
		 * BY create_date DESC LIMIT ?,?
		 */
		String sql = "SELECT o.orders_no ordersNo, o.goods_no goodsNo, o.customer_id customerId, o.orders_quantity ordersQuantity, o.orders_price ordersPrice, o.orders_address ordersAddress, o.orders_deaddress ordersDeAddress, o.orders_state ordersState, o.update_date updateDate, o.create_date createDate, g.goods_name goodsName, g.goods_price goodsPrice FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY o.create_date DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectOrdersList stmt");
			rs = stmt.executeQuery();
			// 디버깅
			System.out.println(rs + "<-- selectOrdersList rs");
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
		int totalRow = 0;
		String sql = "SELECT COUNT(*) count FROM orders";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
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
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		/*
		 * SELECT o. FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no WHERE
		 * customer_id = ? ORDER BY create_date DESC LIMIT ?,?
		 */
		String sql = "SELECT\r\n" 
					+ "o.orders_no ordersNo,\r\n" 
					+ "o.goods_no goodsNo,\r\n"
					+ "o.orders_quantity ordersQuantity,\r\n" 
					+ "o.orders_price ordersPrice,\r\n"
					+ "o.orders_address ordersAddress,\r\n" 
					+ "o.orders_deaddress ordersDeAddress,\r\n" 
					+ "o.orders_state ordersState,\r\n"
					+ "o.update_date updateDate,\r\n" 
					+ "o.create_date createDate,\r\n" 
					+ "g.goods_name goodsName,\r\n"
					+ "g.goods_price goodsPrice\r\n" 
					+ "FROM orders o INNER JOIN goods g\r\n"
					+ "ON o.goods_no = g.goods_no\r\n" 
					+ "WHERE customer_id = ? \r\n" 
					+ "ORDER BY o.create_date DESC\r\n"
					+ "LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			System.out.println(stmt + "<-- selectOrdersListByCustomer stmt");
			rs = stmt.executeQuery();
			// 디버깅
			System.out.println(rs + "<-- selectOrdersListByCustomer rs");
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
	
	
	// 주문 내역 수정하기 
	public int updateOrdersOne(Connection conn, Orders orders) throws Exception {
		int row = 0;
		String sql = "UPDATE orders SET orders_address = ?, orders_deaddress = ?, orders_state = ?, update_date = NOW() WHERE orders_no = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, orders.getOrdersAddress());
			stmt.setString(2, orders.getOrdersDeAddress());
			stmt.setString(3, orders.getOrdersState());
			stmt.setInt(4, orders.getOrdersNo());
			// 디버깅
			System.out.println(stmt + "<-- updateOrdersOne stmt");
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
}
