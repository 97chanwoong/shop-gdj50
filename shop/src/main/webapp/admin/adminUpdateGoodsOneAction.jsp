<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.GoodsImg"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="service.GoodsService"%>
<%@page import="vo.Goods"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/customerIndex.jsp?errorMsg=No permission");
	}
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	String dir = request.getServletContext().getRealPath("/upload");
	// 디버깅
	System.out.println(dir + "<--dir");
	
	// 파일 사이즈
	int max = 10 * 1024 * 1024;
	
	// MultipartRequest는 request를 매개변수로 받아 request를 매개변수로 받아 request를 랩핑한 랩핑 타입
	//													객체  서버경로 파일크기  인코딩             파일이름
	MultipartRequest mRequest = new MultipartRequest(request, dir,  max,  "utf-8",  new DefaultFileRenamePolicy());
	
	// 삭제파일
	String preImg = mRequest.getParameter("preImg");
	// 디버깅
	System.out.println(preImg + "<-- preImg");
	
	// 데이터 셋팅할 객체 생성
	Goods goods = new Goods();
	goods.setGoodsNo(Integer.parseInt(mRequest.getParameter("goodsNo")));
	goods.setGoodsName(mRequest.getParameter("goodsName"));
	goods.setGoodsPrice(Integer.parseInt(mRequest.getParameter("goodsPrice")));
	goods.setSoldOut(mRequest.getParameter("soldOut"));
	// 디버깅
	System.out.println(goods.getGoodsNo() +"<-- goodsNo");
	System.out.println(goods.getGoodsName() +"<-- goodsName");
	System.out.println(goods.getGoodsPrice() +"<-- goodsPrice");
	System.out.println(goods.getSoldOut() +"<-- soldOut");
	
	// 파일값 받기
	String fileName = mRequest.getFilesystemName("imgFile");
	String originFileName = mRequest.getOriginalFileName("imgFile");
	String contentType = mRequest.getContentType("imgFile");
	// 디버깅
	System.out.println(fileName + "<-- fileName");
	System.out.println(originFileName + "<-- originFileName");
	System.out.println(contentType + "<-- contentType ");
	
	//파일 형식 제한
	if (!( contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg") ) ) {
		//
		File f = new File(dir + "/" + fileName);
		//이미 업로드된 파일을 삭제
		if (f.exists()) {
			f.delete();
		}
		System.out.println("이미지 파일만 업로드 가능");
		//String errorMsg = URLEncoder.encode("이미지 파일만 업로드 가능", "utf-8");
		response.sendRedirect(request.getContextPath() + "/admin/adminUpdateGoodsOne.jsp");
		return;
	}
	
	// GoodsImg 객체생성
	GoodsImg goodsImg = new GoodsImg();
	goodsImg.setGoodsNo(Integer.parseInt(mRequest.getParameter("goodsNo")));
	goodsImg.setFileName(fileName);
	goodsImg.setOriginFileName(originFileName);
	goodsImg.setContentType(contentType);
	
	GoodsService goodsService = new GoodsService();
	
	int row = goodsService.getGoodsOne(goods, goodsImg);
	
	if(row == 1){
		File f = new File(dir+"/"+preImg);
		if(f.exists()) {
			f.delete();
			System.out.println("예전 사진 삭제 성공");
		} else {
			System.out.println("예전 사진 삭제 실패");
		}
		System.out.println("상품 수정 성공");
		response.sendRedirect(request.getContextPath() + "/admin/adminUpdateGoodsOne.jsp?goodsNo="+goods.getGoodsNo());
	} else {
		System.out.println("상품 수정 실패");
		response.sendRedirect(request.getContextPath() + "/admin/adminUpdateGoodsOne.jsp?goodsNo="+goods.getGoodsNo());
	}
	
%>