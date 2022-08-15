package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import vo.Goods;

public class GoodsDao {
	
	// 고객이 상품리스트를 확인할 때 조회수를 늘려주는 쿼리
	public int updateListView(Connection conn, int goodsNo) throws Exception {
		int row = 0;
		String sql = "UPDATE goods SET goods_count  = goods_count+1  WHERE goods_no = ?";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 고객 상품리스트 페이지에서 사용

	public List<Map<String, Object>> selectCustomerGoodsListByPage(Connection conn, int rowPerPage, int beginRow,
			int check) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 판매량순
		String sql = null;
		
		if(check == 0) { sql = ""; }
		else if(check == 1) { sql = "";}
		else if(check == 2) {sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, IFNULL(t.sumNum, 0) sumNum, gi.filename fileName FROM goods g LEFT JOIN (SELECT goods_no, SUM(orders_quantity) sumNum FROM orders GROUP BY goods_no) t ON g.goods_no = t.goods_no INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY IFNULL(t.sumNum, 0) DESC LIMIT ?,?";}
		else if(check == 3) {sql = "";}
		else if(check == 4) {sql = "";}
		/*
		 * 고객이 판매량수 많은것 부터 SELECT g.goods_no goodsNo , g.goods_name goodsName ,
		 * g.goods_price goodsPrice , gi.filename filename FROM goods g LEFT JOIN
		 * (SELECT goods_no, SUM(orders_quantity) sumNum FROM orders GROUP BY goods_no)
		 * t ON g.goods_no = t.goods_no INNER JOIN goods_img gi ON g.goods_no =
		 * gi.goods_no ORDER BY IFNULL(t.sumNUm, 0) DESC
		 */
		try {

			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("goodsNo", rs.getInt("goodsNo"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("goodsPrice", rs.getInt("goodsPrice"));
				m.put("soldOut", rs.getString("soldOut"));
				m.put("fileName", rs.getString("fileName"));
				// 디버깅
				System.out.println(m.get("goodsNo") + " <-- goodsNo selectCustomerGoodsListByPage");
				System.out.println(m.get("goodsName") + " <-- goodsName selectCustomerGoodsListByPage");
				System.out.println(m.get("goodsPrice") + " <-- goodsPrice selectCustomerGoodsListByPage");
				System.out.println(m.get("soldOut") + " <-- soldOut selectCustomerGoodsListByPage");
				System.out.println(m.get("fileName") + " <-- fileName selectCustomerGoodsListByPage");
				list.add(m);
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

	public List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage, int beginRow) throws Exception {
		List<Goods> list = new ArrayList<Goods>();
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, update_date updateDate, create_date createDate, sold_out soldOut FROM goods ORDER BY goods_no DESC limit ?, ?";
		ResultSet rs = null;
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Goods g = new Goods();
				g.setGoodsNo(rs.getInt("goodsNo"));
				g.setGoodsName(rs.getString("goodsName"));
				g.setGoodsPrice(rs.getInt("goodsPrice"));
				g.setUpdateDate(rs.getString("updateDate"));
				g.setCreateDate(rs.getString("createDate"));
				g.setSoldOut(rs.getString("soldOut"));
				list.add(g);
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

	public int selectGoodsCount(Connection conn) throws Exception {
		int totalRow = 0;
		String sql = "SELECT COUNT(*) count FROM goods";
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

	// 반환값 : key값 jdbc(API)
	public int insertGoods(Connection conn, Goods goods) throws Exception {
		int keyId = 0;
		String sql = "INSERT INTO goods (goods_name, goods_price, update_date, create_date, sold_out) VALUES(?,?,NOW(),NOW(),?)";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // 키값을 반환하게 변경
		stmt.setString(1, goods.getGoodsName());
		stmt.setInt(2, goods.getGoodsPrice());
		stmt.setString(3, goods.getSoldOut());
		// 디버깅
		System.out.println(stmt + "<-- GoodsDao insertGoods stmt");
		// 1) insert
		stmt.executeUpdate(); // 성공한 row 의 수
		// 2) select last key 값
		ResultSet rs = stmt.getGeneratedKeys(); // select last_key
		if (rs.next()) {
			keyId = rs.getInt(1);
		}
		if (rs != null) {
			rs.getInt(1);
		}
		if (stmt != null) {
			stmt.close();
		}
		return keyId;
	}
	// 상품 품절 변경
	/*
	 * public int updateGoodsSoldOut(Connection conn, int goodsNo, String soldOut)
	 * throws Exception { int row = 0;
	 * 
	 * }
	 */

	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws Exception {
		Map<String, Object> map = null;
		String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.update_date updateDate, g.create_date createDate, g.sold_out soldOut, gi.filename filename, gi.origin_filename originFilename, gi.content_type contentType FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		/*
		 * SELECT g.*, gi.* FROM goods g INNER JOIN goods_img gi ON g.goods_no =
		 * gi.goods_no WHERE g.goods_no = ?
		 * 
		 * if(rs.next()) { map = new HashMap<String, Object>() map.put("goodsNo",
		 * rs.getInt("goodsNo")); }
		 * 
		 * 쿼리에서 where 조건이 없다면..반환 타입 List<Map<String, Object>> list
		 */
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			rs = stmt.executeQuery();
			if (rs.next()) {
				map = new HashMap<String, Object>();
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("soldOut", rs.getString("soldOut"));
				map.put("fileName", rs.getString("fileName"));
				map.put("originfileName", rs.getString("originfileName"));
				map.put("contentType", rs.getString("contentType"));
			}

		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return map;
	}
}
