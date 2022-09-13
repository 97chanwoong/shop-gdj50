<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="service.*"%>
<%
   int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
   // GoodsService 생성
   GoodsService goodsService = new GoodsService();
   // 상품 상세보기 메서드
   Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);
   
   int sumPrice = 0;
   sumPrice += (int)map.get("goodsPrice");
   // 페이징
   int currentPage = 1; // 현재 페이지
   int ROW_PER_PAGE = 5; // 5개씩
   if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아오는 페이지 있을 시 현재페이지 변수에 담기
	}
   // ReviewService 생성
   ReviewService reviewService = new ReviewService();
   // 마지막 페이지 메서드
   int lastPage = reviewService.OrdersLastPage(goodsNo, ROW_PER_PAGE);
   // 숫자페이징
   // ROW_PER_PAGE 가 10이면 1, 11, 21, 31...
   int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
   //ROW_PER_PAGE 가 10 일경우 10, 20, 30, 40...
   int endPage = startPage + ROW_PER_PAGE - 1;
   // endPage < lastPage
   endPage = Math.min(endPage, lastPage); 
   // 리뷰 메서드
   List<Map<String, Object>> list = reviewService.getReviewList(goodsNo, ROW_PER_PAGE, currentPage);
   
   // 조회수
	int row = goodsService.modifyListView(goodsNo);
   
   //오늘 방문자수, 총 방문자수
   CounterService counterService = new CounterService();
   int totalCounter = counterService.getTotalCount();
   int todayCounter = counterService.getTodayCount();
   int currentCount = (Integer)(application.getAttribute("currentCounter"));
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
input 
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

      <!-- Product Details Area Start -->
      <div class="single-product-area section-padding-100 clearfix">
         <div class="container-fluid">

            <div class="row">
               <div class="col-12">
                  <nav aria-label="breadcrumb">
                     <ol class="breadcrumb mt-50">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item"><a href="#">Shop</a></li>
                     </ol>
                  </nav>
               </div>
            </div>

            <div class="row">
               <div class="col-12 col-lg-6">
                  <div class="single_product_thumb">
                     <div class="carousel-item active">
                        <a class="gallery_img"
                           href="<%=request.getContextPath()%>/upload/<%=map.get("fileName")%>">
                           <img class="d-block w-100"
                           src='<%=request.getContextPath()%>/upload/<%=map.get("fileName")%>'>
                        </a>
                     </div>
                  </div>
               </div>
               <div class="col-12 col-lg-6">
                  <div class="single_product_desc">
                     <!-- Product Meta Data -->
                     <div class="product-meta-data">
                        <h1 class="mb-30" style="text-align: center;"><%=map.get("goodsName")%></h1>
                        <hr>
                        <!-- Ratings & Review -->
                        <!--                                 <div class="ratings-review mb-15 d-flex align-items-center justify-content-between">
                                    <div class="ratings">
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                    </div>
                                    <div class="review">
                                        <a href="#">Write A Review</a>
                                    </div>
                                </div> -->
                        <!-- Avaiable -->
                        <div class="container">
                           <p class="avaibility"
                              style="font-size: 20px; text-align: right;">
                              <i class="fa fa-circle"
                                 style="font-size: 20px; text-align: right;"></i>&nbsp;품절여부 :
                              <%=map.get("soldOut")%>
                           </p>
                           <br>
                           <div style="text-align:right;">
                           	<input class="product-price mb-50" style="font-size: 50px; text-align: right; border:none; "readOnly = "readOnly" type="text" id="goodsPrice" value="<%=map.get("goodsPrice")%>">
                           	<span  class="product-price mb-50" style="font-size: 50px; text-align: right; border:none;" >원</span>
                           </div>
                        </div>
                     </div>
                     <hr>
                     <!--상품 설명 -->
                     <!-- <div class="short_overview my-5">
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                           Aliquid quae eveniet culpa officia quidem mollitia impedit iste
                           asperiores nisi reprehenderit consequatur, autem, nostrum
                           pariatur enim?</p>
                     </div> -->

                     <!-- Add to Cart Form -->
                     <form class="cart clearfix" action="<%=request.getContextPath()%>/customerCartAction.jsp" method="post">
                        <div class="container qty-btn d-flex">
                           <input type="hidden" name="goodsNo" value="<%=map.get("goodsNo")%>">
                           <input type="hidden" name="goodsPrice" id="goodsPrice" value="<%=map.get("goodsPrice")%>">
                           <p>Qty</p>
                           <div class="quantity">
                              <input type="number" id="cartQuantity" step="1" value="1"
                                 min="1"  name="cartQuantity">
                           </div>
                           
                        </div>
                     
                        <br>
                        <div class="container" style="text-align:right;">
                           <input class="product-price mb-50" style="font-size: 50px; text-align: right; border:none; " type="text" id="sumPrice" value="<%=sumPrice%>" readOnly="readOnly">
                           <span  class="product-price mb-50" style="font-size: 50px; text-align: right; border:none;" >원</span>
                        </div>
                        <div class="container">
                           <button type="submit"
                              class="btn amado-btn w-100" value="5">Add to cart</button>
                        </div>
                     </form>
                     
                  </div>
               </div>
               <h1>Reviews</h1>
               <hr>
               <%
               for (Map<String, Object> m : list) {
               %>
               <table class="table">
                  <tr>
                     <td><%=m.get("customerId")%>님의 리뷰</td>
                     <td class="text-right"><%=m.get("createDate")%>에 작성</td>
                  </tr>
                  <tr>
                     <td>
                        <div>
                           <p><%=m.get("reviewContents")%></p>
                        </div>
                     </td>
                     <td>
                        <div  class="text-right">
                           <p><%=m.get("updateDate")%>에 수정</p>
                        </div>
                     </td>
                  </tr>
                  <%
                     }
                  %>
               </table>
				<div class="row">
					<div class="col-9"></div>
					<div class="col-2">
						<ul class="pagination justify-content-end">
							<%
							if (currentPage > 1) {
							%>
							<li class="page-item"><a class="page-link"
								href="<%=request.getContextPath()%>/customerGoodsOne.jsp?&goodsNo=<%=goodsNo%>&currentPage=<%=currentPage - 1%>">이전</a>
							</li>
							<%
							}

							// 숫자페이징
							for (int i = startPage; i <= endPage; i++) {
							if (i == currentPage) {
							%>
							<li class="page-item active"><a class="page-link"
								href="<%=request.getContextPath()%>/customerGoodsOne.jsp?&goodsNo=<%=goodsNo%>&currentPage=<%=i%>"><%=i%></a>
							</li>
							<%
							} else {
							%>
							<li class="page-item"><a class="page-link"
								href="<%=request.getContextPath()%>/customerGoodsOne.jsp?&goodsNo=<%=goodsNo%>&currentPage=<%=i%>"><%=i%></a>
							</li>
							<%
							}
							}

							if (currentPage < lastPage) {
							%>
							<li class="page-item"><a class="page-link"
								href="<%=request.getContextPath()%>/customerGoodsOne.jsp?&goodsNo=<%=goodsNo%>&currentPage=<%=currentPage + 1%>">다음</a>
							</li>
							<%
							}
							%>
						</ul>
					</div>
				</div>
			</div>
         </div>
      </div>
      <!-- Product Details Area End -->
   </div>
   <br>
   <br>
   <!-- footer -->
   <jsp:include page="/inc/footer.jsp" />

   <!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
   <script
      src="<%=request.getContextPath()%>/tmp2/js/jquery/jquery-2.2.4.min.js"></script>
   <!-- Popper js -->
   <script src="<%=request.getContextPath()%>/tmp2/js/popper.min.js"></script>
   <!-- Bootstrap js -->
   <script src="<%=request.getContextPath()%>/tmp2/js/bootstrap.min.js"></script>
   <!-- Plugins js -->
   <script src="<%=request.getContextPath()%>/tmp2/js/plugins.js"></script>
   <!-- Active js -->
   <script src="<%=request.getContextPath()%>/tmp2/js/active.js"></script>
   <script>
   $("#cartQuantity").change(function() {
        var sum=0;
            sum =  $("#cartQuantity").val()*$("#goodsPrice").val();
            console.log(sum);
           document.getElementById('sumPrice').value = sum;
   });
   </script>
</body>

</html>