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

	// 고객이 상품리스트를 확인할 때 조회수변경
	public int updateListView(Connection conn, int goodsNo) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE goods SET goods_count  = goods_count+1  WHERE goods_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println(stmt + "<-- updateListView stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// GoodsListPage
	public List<Map<String, Object>> selectCustomerGoodsListByPage(Connection conn, int rowPerPage, int beginRow,
			int check) throws Exception {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리 판매량순
		String sql = "SELECT g.goods_no goodsNo , g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename filename, g.goods_count cnt FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY cnt DESC LIMIT ?,?";

		if (check == 1) {
			sql = "SELECT g.goods_no goodsNo , g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename filename FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY g.create_date DESC LIMIT ?,?";
		} else if (check == 2) {
			sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, IFNULL(t.sumNum, 0) sumNum, gi.filename fileName FROM goods g LEFT JOIN (SELECT goods_no, SUM(orders_quantity) sumNum FROM orders GROUP BY goods_no) t ON g.goods_no = t.goods_no INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY IFNULL(t.sumNum, 0) DESC LIMIT ?,?";
		} else if (check == 3) {
			sql = "SELECT g.goods_no goodsNo , g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename filename FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY g.goods_price DESC LIMIT ?,?";
		} else if (check == 4) {
			sql = "SELECT g.goods_no goodsNo , g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename filename FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY g.goods_price ASC LIMIT ?,?";
		}
		/*
		 * 고객이 판매량수 많은것 부터 SELECT g.goods_no goodsNo , g.goods_name goodsName ,
		 * g.goods_price goodsPrice , gi.filename filename FROM goods g LEFT JOIN
		 * (SELECT goods_no, SUM(orders_quantity) sumNum FROM orders GROUP BY goods_no)
		 * t ON g.goods_no = t.goods_no INNER JOIN goods_img gi ON g.goods_no =
		 * gi.goods_no ORDER BY IFNULL(t.sumNUm, 0) DESC
		 */
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectCustomerGoodsListByPage stmt");
			// 쿼리실행
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

	// GoodsListPage 검색어ver
	public List<Map<String, Object>> selectCustomerGoodsListByWordPage(Connection conn, String word, int rowPerPage,
			int beginRow, int check) throws Exception {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리 판매량순
		String sql = "SELECT g.goods_no goodsNo , g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename filename, g.goods_count cnt FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_name LIKE ? ORDER BY cnt DESC LIMIT ?,?";

		if (check == 1) {
			sql = "SELECT g.goods_no goodsNo , g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename filename FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_name LIKE ? ORDER BY g.create_date DESC LIMIT ?,?";
		} else if (check == 2) {
			sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, IFNULL(t.sumNum, 0) sumNum, gi.filename fileName FROM goods g LEFT JOIN (SELECT goods_no, SUM(orders_quantity) sumNum FROM orders GROUP BY goods_no) t ON g.goods_no = t.goods_no INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_name LIKE ? ORDER BY IFNULL(t.sumNum, 0) DESC LIMIT ?,?";
		} else if (check == 3) {
			sql = "SELECT g.goods_no goodsNo , g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename filename FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_name LIKE ? ORDER BY g.goods_price DESC LIMIT ?,?";
		} else if (check == 4) {
			sql = "SELECT g.goods_no goodsNo , g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename filename FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_name LIKE ? ORDER BY g.goods_price ASC LIMIT ?,?";
		}
		/*
		 * 고객이 판매량수 많은것 부터 SELECT g.goods_no goodsNo , g.goods_name goodsName ,
		 * g.goods_price goodsPrice , gi.filename filename FROM goods g LEFT JOIN
		 * (SELECT goods_no, SUM(orders_quantity) sumNum FROM orders GROUP BY goods_no)
		 * t ON g.goods_no = t.goods_no INNER JOIN goods_img gi ON g.goods_no =
		 * gi.goods_no ORDER BY IFNULL(t.sumNUm, 0) DESC
		 */
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + word + "%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectCustomerGoodsListByWordPage stmt");
			// 쿼리실행
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

	// 관리자 -> GoodsListPage
	public List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage, int beginRow) throws Exception {
		// 리턴값
		List<Goods> list = new ArrayList<Goods>();
		// 쿼리
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, update_date updateDate, create_date createDate, sold_out soldOut FROM goods ORDER BY goods_no DESC limit ?, ?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<--  selectGoodsListByPage stmt");
			// 쿼리실행
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

	// Goods List total
	public int selectGoodsCount(Connection conn) throws Exception {
		// 리턴값
		int totalRow = 0;
		// 쿼리
		String sql = "SELECT COUNT(*) count FROM goods";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<--  selectGoodsCount stmt");
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

	// 상품 상세보기
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws Exception {
		// 리턴값
		Map<String, Object> map = null;
		// 쿼리
		String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.update_date updateDate, g.create_date createDate, g.sold_out soldOut, gi.filename filename, gi.origin_filename originFilename, gi.content_type contentType FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		// 초기화
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
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println(stmt + "<-- selectGoodsAndImgOne stmt");
			// 쿼리실행
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

	// 반환값 : key값 jdbc(API)
	// 상품 추가
	public int insertGoods(Connection conn, Goods goods) throws Exception {
		// 리턴값
		int keyId = 0;
		// 쿼리
		String sql = "INSERT INTO goods (goods_name, goods_price, update_date, create_date, sold_out) VALUES(?,?,NOW(),NOW(),?)";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // 키값을 반환하게 변경
		// 쿼리담기
		stmt.setString(1, goods.getGoodsName());
		stmt.setInt(2, goods.getGoodsPrice());
		stmt.setString(3, goods.getSoldOut());
		// 디버깅
		System.out.println(stmt + "<-- insertGoods stmt");
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

	// 상품 수정
	public int updateGoodsOne(Connection conn, Goods goods) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE goods SET goods_name = ?, goods_price = ?, sold_out = ?, update_date = NOW() WHERE goods_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			stmt.setString(3, goods.getSoldOut());
			stmt.setInt(4, goods.getGoodsNo());
			// 디버깅
			System.out.println(stmt + "<-- updateGoodsOne stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

}
