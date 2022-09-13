package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CustomerDao;
import repository.NoticeDao;
import repository.OrdersDao;
import repository.ReviewDao;
import vo.Review;

public class ReviewService {
	private DBUtil dbutil;
	private ReviewDao reviewDao;

	// 리뷰 리스트
	public List<Map<String, Object>> getReviewList(int goodsNo, int rowPerPage, int currentPage) {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.reviewDao = new ReviewDao();
		
		// beginRow 구하는 식
		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getReviewList conn");
			list = this.reviewDao.selectReviewList(conn, goodsNo, rowPerPage, beginRow);
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
		// 리턴값
		int lastPage = 0;
		
		int totalCount = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.reviewDao = new ReviewDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- OrdersLastPage conn");
			// 메서드실행
			totalCount = this.reviewDao.reviewTotalCountBygoodsNo(conn, goodsNo);
			lastPage = (int) Math.ceil(totalCount / (double) rowPerPage);
			if (lastPage == 0) {
				throw new Exception(); // 예외처리
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
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.reviewDao = new ReviewDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- addCustomerReview conn");
			// 메서드실행
			row = this.reviewDao.insertCustomerReview(conn, review);
			if (row == 0) {
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
		return row;
	}

	// 고객 리뷰 수정
	public int modifyCustomerReview(Review review) {
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.reviewDao = new ReviewDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- modifyCustomerReview conn");
			// 메서드 실행
			row = this.reviewDao.updateCustomerReviewByOrderNo(conn, review);
			if (row == 0) {
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
		return row;
	}

	// 관리자 -> 리뷰 강제 삭제 & 고객 -> 리뷰 삭제
	public int removeAdminReview(int ordersNo) {
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.reviewDao = new ReviewDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- removeAdminReview conn");
			// 메서드실행
			row = this.reviewDao.deleteAdminReview(conn, ordersNo);
			if (row == 0) {
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
		return row;
	}
}
