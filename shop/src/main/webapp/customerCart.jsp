<%@page import="java.util.*"%>
<%@page import="service.CartService"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String customerId = (String) session.getAttribute("id");
	// 장바구니 리스트 보여주기
	CartService cartService = new CartService();
	List<Map<String, Object>> cartList = cartService.getCustomerCartList(customerId);
	// 합계 금액
	int sum = 0;
	for (Map<String, Object> m : cartList) {
		sum = sum + (int) m.get("goodsPrice") * (int) m.get("cartQuantity");
	}
	int cnt = cartService.getCartCount(customerId);
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<style>
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap')
	;
</style>
<!-- Title  -->
<title>CKEA</title>

<!-- Favicon  -->
<link rel="icon" href="tmp2/img/core-img/CKEAfavicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet" href="tmp2/css/core-style.css">
<link rel="stylesheet" href="tmp2/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

	<!-- header -->
	<jsp:include page="/inc/header.jsp" />

		<div class="cart-table-area section-padding-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12 col-lg-8">
						<div class="cart-title mt-50">
							<h2>Shopping Cart</h2>
						</div>

						<div class="cart-table clearfix">
							<table class="table table-responsive">
								<thead>
									<tr>
										<th></th>
										<th>상품명</th>
										<th>상품가격</th>
										<th>수량</th>
									</tr>
								</thead>
								<tbody>
									<%
									int i = 1;
									for (Map<String, Object> m : cartList) {
									%>
									<tr>
										<td class="cart_product_img"><img
											src="<%=request.getContextPath()%>/upload/<%=m.get("fileName")%>"
											alt="Product">
											<input type="hidden" id="goodsNo<%=i%>" value="<%=m.get("goodsNo")%>">
										</td>
										<td class="cart_product_desc">
											<h5><%=m.get("goodsName")%></h5>
										</td>
										<td class="price"><span><input type="number"
												id="goodsPrice<%=i%>" value="<%=m.get("goodsPrice")%>" readOnly="readOnly"></span>
										</td>
										<td class="qty">
											<div class="qty-btn d-flex">
												<p>Qty</p>
												<div class="quantity">
													<input type="number" class="qty-text" id="qty<%=i%>"
														step="1" min="1" max="300" name="quantity"
														value="<%=m.get("cartQuantity")%>">
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<td></td>
										<td></td>
										<td style="text-align: left;">
										<a href="<%=request.getContextPath()%>/customerCartAction.jsp?goodsNo=<%=m.get("goodsNo")%>&customerId=<%=customerId%>&check=removeOne" class="btn amado-btn w-30">삭제</a></td>
									</tr>
									<%
									i++;
									}
									%>
								</tbody>
							</table>
						</div>
					</div>
					<div class="col-12 col-lg-4">
						<div class="cart-summary">
							<h5>Cart Total</h5>
							<ul class="summary-table">
								<li><span>subtotal:</span> <span><input type="text"
										id="sum" value="<%=sum%>"></span></li>
								<li><span>delivery:</span> <span>Free</span></li>
								<li><span>total:</span> <span><input type="text"
										id="sum2" value="<%=sum%>"></span></li>
							</ul>
							<div class="cart-btn mt-100">
								<a href="<%=request.getContextPath()%>/customerCartAction.jsp?customerId=<%=customerId%>&check1=removeAll" class="btn amado-btn w-100">장바구니 전체삭제</a>
								<br><br>
								<a href="<%=request.getContextPath()%>/customerOrders.jsp?customerId=<%=customerId%>" class="btn amado-btn w-100">결제</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ##### Main Content Wrapper End ##### -->

	
	<!-- footer -->
	<jsp:include page="/inc/footer.jsp" />

	<!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
	<script
		src="<%=request.getContextPath()%>/js/jquery/jquery-2.2.4.min.js"></script>
	<!-- Popper js -->
	<script src="<%=request.getContextPath()%>/js/popper.min.js"></script>
	<!-- Bootstrap js -->
	<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
	<!-- Plugins js -->
	<script src="<%=request.getContextPath()%>/js/plugins.js"></script>
	<!-- Active js -->
	<script src="<%=request.getContextPath()%>/js/active.js"></script>

	<script>
		$(".quantity").change(function() {
			var sum = 0;
			for (var i =1; i <=<%=cartList.size()%>; i++ ) {
				var cartQuantity = $("#qty" + i).val();
				var goodsPrice = $("#goodsPrice" + i).val();
				var goodsNo = $("#goodsNo"+i).val();
				sum = sum + $("#qty" + i).val() * $("#goodsPrice" + i).val();
				document.getElementById('sum').value = sum;
				document.getElementById('sum2').value = sum;
				location.href="<%=request.getContextPath()%>/customerCartAction.jsp?&goodsPrice="+ goodsPrice +"&cartQuantity="+ cartQuantity + "&goodsNo="+goodsNo+"&checkUpdate='checkUpateOne'";
			}
		});
	</script>
</body>
</html>