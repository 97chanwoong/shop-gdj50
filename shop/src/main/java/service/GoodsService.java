package service;

import java.sql.*;
import java.util.*;

import repository.GoodsDao;
import repository.GoodsImgDao;
import vo.*;

public class GoodsService {
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;

	// 고객상품리스트액션에서 호출되는 메서드
	public int modifyListView(int goodsNo) {
		int row = 0;
		Connection conn = null;
		this.goodsDao = new GoodsDao();

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			row = goodsDao.updateListView(conn, goodsNo);
			if (row == 0) {
				throw new Exception();
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

	// 고객상품리스트액션에서 호출되는 메서드 상품목록
	public List<Map<String, Object>> getCustomerGoodsListByPage(int rowPerPage, int currentPage, int check) {
		List<Map<String, Object>> list = new ArrayList<>();
		// GoodsDao 호출
		this.goodsDao = new GoodsDao();
		Connection conn = null;

		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = new DBUtil().getConnection();
			list = goodsDao.selectCustomerGoodsListByPage(conn, rowPerPage, beginRow, check);
			if (list != null) {
				System.out.print("실행성공");
			} else {
				System.out.print("실행실패");
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
		return list;
	}

	// 고객상품리스트액션에서 호출되는 메서드 상품목록 검색어
	public List<Map<String, Object>> getCustomerGoodsListByWordPage(String word, int rowPerPage, int currentPage,
			int check) {
		List<Map<String, Object>> list = new ArrayList<>();
		// GoodsDao 호출
		this.goodsDao = new GoodsDao();
		Connection conn = null;

		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = new DBUtil().getConnection();
			list = goodsDao.selectCustomerGoodsListByWordPage(conn, word, rowPerPage, beginRow, check);
			if (list != null) {
				System.out.print("실행성공");
			} else {
				System.out.print("실행실패");
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
		return list;
	}

	// 상품리스트
	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
		List<Goods> list = null;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = new DBUtil().getConnection();
			list = goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			if (list != null) {
				System.out.println("실행 성공");
			} else {
				System.out.println("실행 실패");
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
		return list;
	}

	// 상품리스트 라스트 페이지
	public int getGoodsLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalRow = 0;
		Connection conn = null;
		this.goodsDao = new GoodsDao();

		try {
			conn = new DBUtil().getConnection();
			totalRow = goodsDao.selectGoodsCount(conn);
			lastPage = (int) Math.ceil(totalRow / (double) rowPerPage);
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

	// 상품추가
	public int addGoods(Goods goods, GoodsImg goodsImg) {
		int goodsNo = 0;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);

			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();

			goodsNo = goodsDao.insertGoods(conn, goods); // goodsNO가 AI로 자동생성되어 DB입력
			if (goodsNo != 0) { // 0 아니면 키 있음
				// 키값 setter
				goodsImg.setGoodsNo(goodsNo);
				if (goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
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
		int row = 0;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		this.goodsImgDao = new GoodsImgDao();
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			row = goodsDao.updateGoodsOne(conn, goods);
			if (row != 0) {
				if (goodsImgDao.updateGoodsImg(conn, goodsImg) == 0) {
					throw new Exception();
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
			// DB자원 해제
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

	// 상품 상세보기
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) {
		Map<String, Object> map = null;
		Connection conn = null;
		this.goodsDao = new GoodsDao();

		try {
			conn = new DBUtil().getConnection();
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
}
