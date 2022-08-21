package repository;

import java.sql.*;
import java.util.*;

public class ReviewDao {
	// 리뷰 리스트
	public List<Map<String, Object>> selectReviewList(Connection conn, int goodsNo) throws Exception {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB
		String sql = "SELECT r.orders_no ordersNo, r.review_contents reviewContents, r.update_date updateDate, r.create_date createDate, o.customer_id customerId FROM review r INNER JOIN orders o USING (orders_no) WHERE o.goods_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println(goodsNo + "<-- goodsNo");
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("ordesNo", rs.getInt("ordersNo"));
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
	
	// 리뷰 강제 삭제
	public int deleteAdminReview(Connection conn, int orderNo) throws Exception {
		int row = 0;
		
	}
}
