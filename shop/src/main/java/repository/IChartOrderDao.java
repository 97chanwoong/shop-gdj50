package repository;

import java.sql.Connection;
import java.util.*;

public interface IChartOrderDao {
	List<Map<String,Object>> selectCountByOrder(Connection conn) throws Exception;
}
