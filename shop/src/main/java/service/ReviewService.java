package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.NoticeDao;
import repository.ReviewDao;


public class ReviewService {
	private ReviewDao reviewDao;
	
	//리뷰 리스트
	public List<Map<String,Object>> getReviewList(int goodsNo) {
		//리턴할 객체 생성
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		// 초기화
		Connection conn = null;
		// reviewDao
		reviewDao = new ReviewDao();
		try {
			conn = new DBUtil().getConnection();
			list = reviewDao.selectReviewList(conn, goodsNo);
			if(list == null) {
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
	
	// 관리자 -> 리뷰 강제 삭제 & 고객 -> 리뷰 삭제
	public int removeAdminReview(int ordersNo) {
		int row = 0;
		// 초기화
		Connection conn = null;
		// Dao 객체
		reviewDao = new ReviewDao();
		try {
			conn = new DBUtil().getConnection();
			System.out.println(conn + "<-- removeNotice conn");
			row = reviewDao.deleteAdminReview(conn, ordersNo);
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
