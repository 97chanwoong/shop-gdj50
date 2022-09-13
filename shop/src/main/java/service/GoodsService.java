package service;

import java.sql.*;
import java.util.*;

import repository.GoodsDao;
import repository.GoodsImgDao;
import vo.*;

public class GoodsService {
	private DBUtil dbutil;
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;

	// 고객이 상품리스트를 확인할 때 조회수변경
	public int modifyListView(int goodsNo) {
		// 리턴값
		int row = 0;

		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.goodsDao = new GoodsDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- modifyListView conn");

			conn.setAutoCommit(false);
			// 메서드실행
			row = this.goodsDao.updateListView(conn, goodsNo);
			if (row == 0) {
				throw new Exception(); // 예외처리
			} else {
				System.out.println("실행성공");
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
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
		return row;
	}

	// GoodsListPage
	public List<Map<String, Object>> getCustomerGoodsListByPage(int rowPerPage, int currentPage, int check) {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<>();

		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.goodsDao = new GoodsDao();

		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getCustomerGoodsListByPage conn");
			// 메서드
			list = this.goodsDao.selectCustomerGoodsListByPage(conn, rowPerPage, beginRow, check);
			if (list != null) {
				System.out.print("실행성공");
			} else {
				System.out.print("실행실패");
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

	// GoodsListPage 검색어ver
	public List<Map<String, Object>> getCustomerGoodsListByWordPage(String word, int rowPerPage, int currentPage,
			int check) {
		// 리턴값
		List<Map<String, Object>> list = new ArrayList<>();
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.goodsDao = new GoodsDao();

		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getCustomerGoodsListByWordPage conn");
			// 메서드실행
			list = this.goodsDao.selectCustomerGoodsListByWordPage(conn, word, rowPerPage, beginRow, check);
			if (list != null) {
				System.out.print("실행성공");
			} else {
				System.out.print("실행실패");
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

	// 관리자 -> GoodsListPage
	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
		// 리턴값
		List<Goods> list = null;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.goodsDao = new GoodsDao();

		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getGoodsListByPage conn");
			// 메서드실행
			list = this.goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			if (list != null) {
				System.out.println("실행 성공");
			} else {
				System.out.println("실행 실패");
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

	// 상품리스트 라스트 페이지
	public int getGoodsLastPage(int rowPerPage) {
		// 리턴값
		int lastPage = 0;

		int totalRow = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.goodsDao = new GoodsDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<--getGoodsLastPage conn");
			// 메서드실행
			totalRow = this.goodsDao.selectGoodsCount(conn);
			lastPage = (int) Math.ceil(totalRow / (double) rowPerPage);
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

	// 상품 상세보기
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) {
		// 리턴값
		Map<String, Object> map = null;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.goodsDao = new GoodsDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getGoodsAndImgOne conn");
			// 메서드실행
			map = this.goodsDao.selectGoodsAndImgOne(conn, goodsNo);
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
		return map;
	}

	// 상품추가
	public int addGoods(Goods goods, GoodsImg goodsImg) {
		// 리턴값
		int goodsNo = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.goodsDao = new GoodsDao();
		this.goodsImgDao = new GoodsImgDao();
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- addGoods conn");

			conn.setAutoCommit(false);
			// 메서드실행
			goodsNo = this.goodsDao.insertGoods(conn, goods); // goodsNO가 AI로 자동생성되어 DB입력
			if (goodsNo != 0) { // 0 아니면 키 있음
				// 키값 setter
				goodsImg.setGoodsNo(goodsNo);
				if (this.goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					throw new Exception(); // 이미지리 입력 실패시 강제로 롤백 (catch절 이동)
				}
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
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
		return goodsNo;
	}

	// 상품수정
	public int getGoodsOne(Goods goods, GoodsImg goodsImg) {
		// 리턴값
		int row = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.goodsDao = new GoodsDao();
		this.goodsImgDao = new GoodsImgDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getGoodsOne conn");

			conn.setAutoCommit(false);
			// 메서드실행
			row = this.goodsDao.updateGoodsOne(conn, goods);
			if (row != 0) {
				if (this.goodsImgDao.updateGoodsImg(conn, goodsImg) == 0) {
					throw new Exception(); // 예외처리
				}
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return row;

	}

}
