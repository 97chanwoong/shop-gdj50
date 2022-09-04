package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.NoticeDao;
import repository.OrdersDao;
import repository.ReviewDao;
import vo.Review;

public class ReviewService {
	private ReviewDao reviewDao;

	// 리뷰 리스트
	public List<Map<String, Object>> getReviewList(int goodsNo, int rowPerPage, int currentPage) {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// 초기화
		Connection conn = null;
		// reviewDao
		reviewDao = new ReviewDao();
		// beginRow 구하는 식
		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = new DBUtil().getConnection();
			list = reviewDao.selectReviewList(conn, goodsNo, rowPerPage, beginRow);
			if (list == null) {
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

	// 상품별 리뷰리스트 라스트 페이지
	public int OrdersLastPage(int goodsNo,int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		// 초기화
		Connection conn = null;
		// reviewDao
		reviewDao = new ReviewDao();
		try {
			conn = new DBUtil().getConnection();
			totalCount = reviewDao.reviewTotalCountBygoodsNo(conn, goodsNo);
			lastPage = (int) Math.ceil(totalCount / (double) rowPerPage);
			if (lastPage == 0) {
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// 실패라면 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// DB 자원해제
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return lastPage;
	}


	// 고객 리뷰작성
	public int addCustomerReview(Review review) {
		int row = 0;
		Connection conn = null;
		// Dao 객체
		reviewDao = new ReviewDao();
		try {
			conn = new DBUtil().getConnection();
			System.out.println(conn + "<-- addCustomerReview conn");
			row = reviewDao.insertCustomerReview(conn, review);
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

	// 고객 리뷰 수정
	public int modifyCustomerReview(Review review) {
		int row = 0;
		Connection conn = null;
		// Dao 객체
		reviewDao = new ReviewDao();
		try {
			conn = new DBUtil().getConnection();
			System.out.println(conn + "<-- modifyCustomerReview conn");
			row = reviewDao.updateCustomerReviewByOrderNo(conn, review);
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
