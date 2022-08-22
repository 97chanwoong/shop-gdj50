package service;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import repository.ChartOrderDao;
import repository.IChartOrderDao;

public class ChartOrderService implements IChartOrderService {
	private IChartOrderDao chartorderDao;
	private DBUtil dbutil;

	@Override
	public List<Map<String, Object>> getCountByOrder() {
		// 리턴 객체
		List<Map<String, Object>> list = null;
		dbutil = new DBUtil();
		chartorderDao = new ChartOrderDao();
		// 초기화
		Connection conn = null;
		try {
			conn = dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getCountByOrder DB연동");
			// 자동커밋 막음
			conn.setAutoCommit(false);
			list = chartorderDao.selectCountByOrder(conn);
			if (list == null) {
				throw new Exception();
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
