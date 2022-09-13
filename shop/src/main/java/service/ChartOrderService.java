package service;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import repository.ChartOrderDao;
import repository.IChartOrderDao;

public class ChartOrderService implements IChartOrderService {
	private DBUtil dbutil;
	private ChartOrderDao chartorderDao;
	
	@Override
	public List<Map<String, Object>> getCountByOrder() {
		// 리턴값
		List<Map<String, Object>> list = null;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.chartorderDao = new ChartOrderDao();
		
		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getCountByOrder conn");
			// 자동커밋 막음
			conn.setAutoCommit(false);
			// 메서드실행
			list = chartorderDao.selectCountByOrder(conn);
			if (list == null) {
				throw new Exception();  // 예외처리
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
		return list;
	}

}
