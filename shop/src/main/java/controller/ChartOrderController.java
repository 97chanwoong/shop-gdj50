package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.ChartOrderService;
import service.IChartOrderService;

@WebServlet("/controller/*")
public class ChartOrderController extends HttpServlet {
	private IChartOrderService chartorderService;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 응답 형태 결정
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		
		// gson 객체생성
		Gson gson = new Gson();
		String result = "";
		
		String uri = request.getRequestURI();
		// 디버깅
		System.out.println("uri --> " + uri);
		
		int n = request.getContextPath().length();
		String command = uri.substring(n);
		
		// 초기화
		chartorderService = new ChartOrderService();
		
		if(command.equals("/controller/getCountByOrder")) {
			List<Map<String, Object>> list = chartorderService.getCountByOrder();
			result = gson.toJson(list);
		} else {
			System.out.println("잘못된 요청");
		}
		
		PrintWriter out = response.getWriter();
		out.write(result);
		out.flush();
		out.close();
	}

}
