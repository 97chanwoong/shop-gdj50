package repository;

import java.sql.*;
import java.util.*;

public class ChartOrderDao implements IChartOrderDao {

	@Override
	public List<Map<String, Object>> selectCountByOrder(Connection conn) throws Exception {
		// 리턴 list
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		String sql = ChartOrderQuery.SELECT_COUNT_BY_MONTH_ORDER;
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println(stmt + "<-- selectCountByOrder stmt");
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("ym", rs.getString("ym"));
				m.put("cnt", rs.getInt("cnt"));
				list.add(m);
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		return list;
	}
}
