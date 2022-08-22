package service;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

public interface IChartOrderService {
	List<Map<String,Object>> getCountByOrder();
}
