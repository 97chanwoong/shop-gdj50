package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.SignService;

@WebServlet("/idckController")
public class IdCkController extends HttpServlet {
	private SignService signService;
	@Override
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
	     response.setContentType("application/json");
	     response.setCharacterEncoding("utf-8");
	     // SignService 객체 생성
	     this.signService = new SignService();
	     // 중복검사 값
	     String idck = request.getParameter("idck");
	     System.out.println(idck+ "<-- idck") ;
	     // 서비스에서 받은 리턴값 저장
	     String id = this.signService.getIdCheck(idck);
	    
		 Gson gson = new Gson();
		 String jsonStr = "";
		 if(id == null) {
			 jsonStr = gson.toJson("y"); // id -> null idck사용가능 -> yes
		 } else {
			 jsonStr = gson.toJson("n"); // id -> select값 O -> idck 사용불가 -> no
		 }
		 // java에서 웹으로 출력 시
		 PrintWriter out = response.getWriter();
		 out.write(jsonStr);
		 out.flush();
		 out.close();
	}
}
