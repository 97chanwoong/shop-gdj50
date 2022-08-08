package service;

import java.sql.*;
import java.util.*;

import repository.GoodsDao;
import repository.GoodsImgDao;
import vo.*;

public class GoodsService {
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;

	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
		List<Goods> list = null;
		Connection conn = null;

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
			lastPage = totalRow / rowPerPage;
			if (totalRow % rowPerPage != 0) {
				lastPage += 1;
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
		return lastPage;
	}

	//
	/* public int addGoods(Goods goods, GoodsImg goodsImg) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			int goodsNo = goodsDao.insertGoods(conn, goods); // goodsNO가 AI로 자동생성되어 DB입력
			if(goodsNo != 0) {
				/*goodsImg.setGoodsNo(goodsNo);
				if(goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					throw new Exception(); // 이미지리 입력 실패시 강제로 롤백 (catch절 이동)
				}
			}
			
			goodsImgDao.insertGoodsImg(conn, goodsImg);
			
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			conn.rollback();
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		retrun
	} */

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