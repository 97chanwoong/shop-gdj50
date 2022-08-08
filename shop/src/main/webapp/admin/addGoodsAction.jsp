<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Goods"%>
<%@ page import="vo.GoodsImg"%>
<%@ page import="java.io.File"%>
<%@ page import="java.net.URLEncoder"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=No permission");
	}
	
	String dir = request.getServletContext().getRealPath("/upload");
	// 디버깅
	System.out.println(dir + "<--dir");
	
	// 파일 사이즈
	int max = 10 * 1024 * 1024;
	
	// MultipartRequest는 request를 매개변수로 받아 request를 매개변수로 받아 request를 랩핑한 랩핑 타입
	//													객체  서버경로 파일크기  인코딩             파일이름
	MultipartRequest mRequest = new MultipartRequest(request, dir,  max,  "utf-8",  new DefaultFileRenamePolicy());
	
	// 입력값 받기
	String goodsName = mRequest.getParameter("goodsName");
	int goodsPrice = Integer.parseInt(mRequest.getParameter("goodsPrice"));
	String soldOut = mRequest.getParameter("soldOut");
	// 디버깅
	System.out.println(goodsName + "<-- goodsName");
	System.out.println(goodsName + "<-- goodsName");
	System.out.println(soldOut + "<-- soldOut");
	
	// 파일값 받기
	String fileName = mRequest.getFilesystemName("imgFile");
	String originFileName = mRequest.getOriginalFileName("imgFile");
	String contentType = mRequest.getContentType("imgFile");
	// 디버깅
	System.out.println(fileName + "<-- fileName");
	System.out.println(originFileName + "<-- originFileName");
	System.out.println(contentType + "<-- contentType ");

	// goods 객체 생성 후 담기
	Goods goods = new Goods();
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
	
	// goodsIMG 객체 생성 후 담기
	GoodsImg goodsImg = new GoodsImg();
	goodsImg.setFileName(fileName);
	goodsImg.setOriginFileName(originFileName);
	goodsImg.setContentType(contentType);
	
	// 메서드 실행
	GoodsService goodsService = new GoodsService();
	goodsService.addGoods(goods, goodsImg);
	
	// 이미지 파일이 아닐 경우 막기
	if(!(contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg"))){
		// 이미 업로드된 파일을 삭제
		File f = new File(dir + "/" + fileName);
		if(f.exists()){ // 파일이 존재하면 삭제
			f.delete();
		}
		
		// 에러메세지
		String errorMsg = URLEncoder.encode("이미지파일만 업로드가능합니다", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/addGoodsForm.jsp?errorMsg=" + errorMsg);
		return;
	}
	
	// 재요청
	response.sendRedirect(request.getContextPath()+"/admin/adminGoodslist.jsp");

%>