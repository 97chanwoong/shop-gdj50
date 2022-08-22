package service;

import repository.CounterDao;
import java.sql.*;

public class CounterService {
	private CounterDao counterDao;
	public void count() {
		counterDao = new CounterDao();
		Connection conn = null;
		
		if(counterDao.selectCounterToday(conn) == null) { // 오늘날짜 카운터가 없으면 1 입력
			counterDao.insertCounter(conn);
		} else { // 오늘날짜의 카운터가 있으면 +1 업데이터
			counterDao.updateCounter(conn);
		}
	}
	
	public int getTotalCount() {
		counterDao = new CounterDao();
		Connection conn = null;
		int totalCount = counterDao.selectTotalCount(conn);
		return totalCount;
	}

	public int getTodayCount() {
		counterDao = new CounterDao();
		Connection conn = null;
		int todayCount = counterDao.selectTodayCount(conn);
		return todayCount;
	}
}
