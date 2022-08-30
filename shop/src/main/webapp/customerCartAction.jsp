<%@page import="service.CartService"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	CartService cartService = new CartService();
	Cart cart = new Cart();
	
	String customerId = (String)session.getAttribute("id");
	cart.setCustomerId(customerId);
	//전체 삭제
	if(request.getParameter("check1")!=null){
		cartService.removeCartAll(customerId);
		response.sendRedirect(request.getContextPath()+"/customerCart.jsp");
		return;
	}
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	cart.setGoodsNo(goodsNo);
	
	
	
	//단일삭제
	if(request.getParameter("check")!=null){
		cartService.removeCartOne(cart);
		response.sendRedirect(request.getContextPath()+"/customerCart.jsp");
		return;
	}
	
	int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
	System.out.println(cartQuantity);
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	cart.setCartQuantity(cartQuantity);
	// 디버깅
	System.out.println(customerId);
	
	if(request.getParameter("checkUpdate")!=null){
		cartService.modifyCartOne(cart);
		response.sendRedirect(request.getContextPath()+"/customerCart.jsp");
		return;
	}
	
	
	
	int row = cartService.addCart(cart);
	if(row == 0){
		System.out.println("장바구니 담기 실패");
		response.sendRedirect(request.getContextPath()+"/customerGoodsOne.jsp");
	} else {
		System.out.println("장바구니 담기 성공");
		response.sendRedirect(request.getContextPath()+"/customerCart.jsp");
	}

%>
