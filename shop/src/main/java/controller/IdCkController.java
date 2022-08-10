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
	     this.signService = new SignService();
	     String idck = request.getParameter("idck");
	     System.out.println(idck+ "<-- idck") ;
	      String id = this.signService.getIdCheck(idck);
	      // id -> null idck사용가능 -> yes
	      // id -> select값 O -> idck 사용불가 -> no
	      Gson gson = new Gson();
	      String jsonStr = "";
	      if(id == null) {
	    	  jsonStr = gson.toJson("y");
	      } else {
	    	  jsonStr = gson.toJson("n");
	      }
	      PrintWriter out = response.getWriter();
	      out.write(jsonStr);
	      out.flush();
	      out.close();
	}
	
}
