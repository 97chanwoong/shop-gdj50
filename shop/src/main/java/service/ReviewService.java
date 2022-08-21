package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
}
