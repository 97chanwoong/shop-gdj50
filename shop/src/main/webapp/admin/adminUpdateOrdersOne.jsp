<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="repository.*"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>	
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
		return;
	} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/customerIndex.jsp?errorMsg=No permission");
	}

	// 오더정보 받아오기
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	// 디버깅
	System.out.println(ordersNo + "<-- ordersNo");
	// 주문상품 상세 보기 메서드
	OrdersService ordersService = new OrdersService();
	Map<String, Object> map = ordersService.getOrdersOne(ordersNo);
	
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
<!-- font -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap')
	;
</style>
<!-- Title  -->
<title>CKEA</title>

<!-- Favicon  -->
<link rel="icon" href="../tmp2/img/core-img/CKEAfavicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet" href="../tmp2/css/core-style2.css">
<link rel="stylesheet" href="../tmp2/css/core-style5.css">
<link rel="stylesheet" href="../tmp2/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
	<!-- Search Wrapper Area Start -->
	<div class="search-wrapper section-padding-100">
		<div class="search-close">
			<i class="fa fa-close" aria-hidden="true"></i>
		</div>
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="search-content">
						<form action="#" method="get">
							<input type="search" name="search" id="search"
								placeholder="Type your keyword...">
							<button type="submit">
								<img src="../tmp2/img/core-img/search.png" alt="">
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Search Wrapper Area End -->

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

		<!-- Mobile Nav (max width 767px)-->
		<div class="mobile-nav">
			<!-- Navbar Brand -->
			<div class="amado-navbar-brand">
				<a href="LoginForm2.jsp"><img
					src="../tmp2/img/core-img/CKEALOGO.png" alt=""></a>
			</div>
			<!-- Navbar Toggler -->
			<div class="amado-navbar-toggler">
				<span></span><span></span><span></span>
			</div>
		</div>

		<!-- Header Area Start -->
		<header class="header-area clearfix">
			<!-- Close Icon -->
			<div class="nav-close">
				<i class="fa fa-close" aria-hidden="true"></i>
			</div>
			<!-- Logo -->
			<div class="logo">
				<a href="<%=request.getContextPath()%>/Main.jsp"><img
					src="../tmp2/img/core-img/CKEALOGO.png" alt=""></a>
			</div>
			<!-- Amado Nav -->
			<nav class="amado-nav">
				<ul>
					<li><a href="<%=request.getContextPath()%>/Main.jsp">Home</a></li>
					<li><a href="shop.html">Shop</a></li>
					<li><a href="#">Community</a></li>
					<li><a href="#">Contact</a></li>
				</ul>
			</nav>

		</header>
		<!-- Header Area End -->

		<div class="Order-table-area section-padding-100 mb-100">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12 col-sm-6">
						<div class="Order-summary">
							<h5 style="font-family: 'Jua', sans-serif;">주문 수정(상품정보)</h5>
							<br> 
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="goodsName" class="form-group">상품 이름
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="goodsName" id="goodsName" readonly="readonly" value="<%=map.get("goodsName")%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="ordersPrice" class="form-group">상품 가격
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="ordersPrice" id="ordersPrice" readonly="readonly" value="<%=map.get("ordersPrice")%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="ordersQuantity" class="form-group">상품 수량
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="ordersQuantity" id="ordersQuantity" readonly="readonly" value="<%=map.get("ordersQuantity")%>"
										class="form-control"> 
								<br>
						</div>
					</div>
					<div class="col-12 col-sm-6">
						<div class="Order-summary">
							<h5 style="font-family: 'Jua', sans-serif;">주문 수정(고객정보)</h5>
							<br> 
							<form id="updateOrdersForm"
								action="<%=request.getContextPath()%>/admin/adminUpdateOrdersOneAction.jsp"
								method="post">
								<input type="hidden" id="ordersNo" name="ordersNo" value="<%=map.get("ordersNo")%>">
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="customerName" class="form-group">고객 이름
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="customerName" id="customerName" readonly="readonly" value="<%=map.get("customerName")%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="customerId" class="form-group">고객 아이디
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="customerId" id="customerId" readonly="readonly" value="<%=map.get("customerId")%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;"
										for="customerTelephone" class="form-group" >고객 연락처
								</label> 
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
										name="customerTelephone" id="customerTelephone" readonly="readonly" value="<%=map.get("customerTelephone")%>"
										class="form-control"> 
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;" for="ordersAddress">배송주소</label>	
								<input style="font-family: 'Jua', sans-serif;"
									   type="text" class="form-control"
									   name="ordersAddress" id="ordersAddress" value="<%=map.get("ordersAddress") %>"
									   readonly="readonly">	
								<br>
								<div style="text-align:right;">	   
								 <button style="font-family: 'Jua', sans-serif;"
								 	     type="button" id="addrBtn" class="btn login-btn w-10" 
								 		 onclick="sample2_execDaumPostcode()">주소검색</button>	   
								</div>
								<label style="font-family: 'Jua', sans-serif; font-size:30px;" for="ordersDeAddress">상세주소</label>	
								<input style="font-family: 'Jua', sans-serif; font-size:25px;"
									   type="text" class="form-control"
									   placeholder="상세주소를 입력하세요" name="ordersDeAddress" value="<%=map.get("ordersDeAddress")%>"
									   id="ordersDeAddress">
								<br>
								<label style="font-family: 'Jua', sans-serif; font-size:35px;"
										for="ordersState">배송 현황
								</label>
								<br>
								<select id="ordersState" name="ordersState">
										<option value="default">------- 주문상황--------</option>
										<option value="결제대기">결제 대기</option>
										<option value="주문완료">주문 완료</option>
										<option value="배송준비중">배송 준비중</option>
										<option value="배송중">배송 중</option>
										<option value="배송완료">배송 완료</option>
								</select>
							<br>
							<br>
							<div class="form-group">
								<button type="reset"
								        class="btn amado-btn w-100"
								        style="font-family: 'Jua', sans-serif; font-size:30px;" >초기화</button>	
							</div>
							<br>
							<div class="form-group">	
								<button id="updateBtn" type="button"
										class="btn login-btn w-100"
										style="font-family: 'Jua', sans-serif; font-size:30px;">주문 수정</button> 
							</div>			       
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ##### Main Content Wrapper End ##### -->
	<br>
	<br>
	<!-- ##### Footer Area Start ##### -->
	<footer class="footer_area clearfix mt-100">
		<div class="container">
			<div class="row align-items-center">
				<!-- Single Widget Area -->
				<div class="col-12 col-lg-4">
					<div class="single_widget_area">
						<!-- Logo -->
						<div class="footer-logo mr-50">
							<a href="index.html"><img src="img/core-img/logo2.png" alt=""></a>
						</div>
						<!-- Copywrite Text -->
						<p class="copywrite">
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							Copyright &copy;
							<script>
								document.write(new Date().getFullYear());
							</script>
							All rights reserved | This template is made with <i
								class="fa fa-heart-o" aria-hidden="true"></i> by <a
								href="https://colorlib.com" target="_blank">Colorlib</a>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							& Re-distributed by <a href="https://themewagon.com/"
								target="_blank">Themewagon</a>
						</p>
					</div>
				</div>
				<!-- Single Widget Area -->
				<div class="col-12 col-lg-8">
					<div class="single_widget_area">
						<!-- Footer Menu -->
						<div class="footer_menu">
							<nav class="navbar navbar-expand-lg justify-content-end">
								<button class="navbar-toggler" type="button"
									data-toggle="collapse" data-target="#footerNavContent"
									aria-controls="footerNavContent" aria-expanded="false"
									aria-label="Toggle navigation">
									<i class="fa fa-bars"></i>
								</button>
								<div class="collapse navbar-collapse" id="footerNavContent">
									<ul class="navbar-nav ml-auto">
										<li class="nav-item active"><a class="nav-link"
											href="<%=request.getContextPath()%>/Main.jsp">Home</a></li>
										<li class="nav-item"><a class="nav-link" href="shop.html">Shop</a>
										</li>
										<li class="nav-item"><a class="nav-link" href="#">Community</a>
										</li>
										<li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
									</ul>
								</div>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- ##### Footer Area End ##### -->

	<!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
	<script src="../tmp2/js/jquery/jquery-2.2.4.min.js"></script>
	<!-- Popper js -->
	<script src="../tmp2/js/popper.min.js"></script>
	<!-- Bootstrap js -->
	<script src="../tmp2/js/bootstrap.min.js"></script>
	<!-- Plugins js -->
	<script src="../tmp2/js/plugins.js"></script>
	<!-- Active js -->
	<script src="../tmp2/js/active.js"></script>
<script>
	$('#updateBtn').click(function(){
		if($('#ordersAddress').val().length == "") {
			alert('배송지를 입력하세요');
		} else if($('#ordersState').val() == 'default') {
			alert('배송현황을 선택하세요');
		} else {
			updateOrdersForm.submit();
		}
	});
</script>
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<script>
	$('#addrBtn').click(function(){
		sample2_execDaumPostcode();
	});
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
/* 	
 
 	선언식
 	
	z1()
    
	function z1(){
		
	}
	
	z2()
	var z2 = function(){
		
		
	};
	z2();
 */
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer'); 

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var ordersAddress = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                	ordersAddress = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                	ordersAddress = data.jibunAddress;
                }
            
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    // document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // document.getElementById('sample2_postcode').value = data.zonecode;
                // document.getElementById("sample2_address").value = addr;
                
                // $('#addr').val(data.zonecode + ' ' + addr);
                document.getElementById('ordersAddress').value = data.zonecode + ' ' + ordersAddress;
                
                
                // 커서를 상세주소 필드로 이동한다.
                // document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 400; //우편번호서비스가 들어갈 element의 width
        var height = 500; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 7; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
</body>
</html>