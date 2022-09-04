package repository;

import java.sql.*;
import java.util.*;

import vo.Review;

public class ReviewDao {
	// 리뷰 리스트
	public List<Map<String, Object>> selectReviewList(Connection conn, int goodsNo, int rowPerPage, int beginRow) throws Exception {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB
		String sql = "SELECT r.orders_no ordersNo, r.review_contents reviewContents, r.update_date updateDate, r.create_date createDate, o.customer_id customerId FROM review r INNER JOIN orders o USING (orders_no) WHERE o.goods_no = ? ORDER BY goods_no LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			// 디버깅
			System.out.println(goodsNo + "<-- goodsNo");
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("ordersNo", rs.getInt("ordersNo"));
				m.put("reviewContents", rs.getString("reviewContents"));
				m.put("updateDate", rs.getString("updateDate"));
				m.put("createDate", rs.getString("createDate"));
				m.put("customerId", rs.getString("customerId"));
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

	public int reviewTotalCountBygoodsNo(Connection conn, int goodsNo) throws Exception {
		// 리턴값 초기화
		int totalCount = 0;

		// 쿼리
		String sql = "SELECT COUNT(*) count FROM review r INNER JOIN orders o ON r.orders_no = o.orders_no INNER JOIN goods g ON o.goods_no = g.goods_no WHERE o.goods_no = ?";

		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println(stmt + "<--reviewTotalCountBygoodsNo stmt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt("count");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}

		return totalCount;
	}


	// 고객 리뷰 작성
	public int insertCustomerReview(Connection conn, Review review) throws Exception {
		// 리턴값
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO review (orders_no, review_contents, update_date, create_date) VALUES (?, ?, NOW(), NOW())";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, review.getOrdersNo());
			stmt.setString(2, review.getReviewContents());
			System.out.println(stmt + "<-- insertCustomerReview stmt");
			row = stmt.executeUpdate();
		} finally {
			// DB자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 고객 리뷰 수정
	public int updateCustomerReviewByOrderNo(Connection conn, Review review) throws Exception {
		// 리턴값 초기화
		int row = 0;

		// 쿼리
		String sql = "UPDATE review SET review_contents = ?, update_date = NOW() WHERE orders_no = ?";

		// 초기화
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, review.getReviewContents());
			stmt.setInt(2, review.getOrdersNo());
			// 디버깅
			System.out.println(stmt + "<-- update updateCustomerReviewByOrderNo");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 관리자 -> 리뷰 강제 삭제 & 고객 -> 리뷰 삭제
	public int deleteAdminReview(Connection conn, int ordersNo) throws Exception {
		int row = 0;
		String sql = "DELETE FROM review WHERE orders_no = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);
			// 디버깅
			System.out.println(stmt + "ordersNo");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
}
