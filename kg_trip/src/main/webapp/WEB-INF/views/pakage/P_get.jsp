<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<style type="text/css">
	.left-view{
		width: 900px;
		height: 3000px;
		float: left;
		background-color: white;
	}
	.right-view{
		width: 300px;
		float: right;
		background-color: white;
	}
	.left-width{
		width: 900px;
	}
	
	.conted {
	/* position: relative; */
	width: 100%;
	max-width: 1200px;
	margin: 0 auto;
	height: 15000px;
	background-color: #F0FFFF;
	

	을지가 수정한 것들 !! 여기부터
	background-color: gray;
	border: 2px solid pink;
	padding: 20px;
	을지가 수정한 것들 !! 여기까지
	}
</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="conted">
			<div class="left-view">
				<div class="left-width" height="100px"><h1>${board.p_name }</h1></div>
				<div class="left-width">
					<img alt="이미지" src="/resources/images/${board.p_img1 }" width="800px">
					<img alt="이미지" src="/resources/images/${board.p_img2 }" width="800px">
					<img alt="이미지" src="/resources/images/${board.p_img3 }" width="800px">
					<img alt="이미지" src="/resources/images/${board.p_img4 }" width="800px">
				</div>
				<div class="left-width">
					<h3>상품 정보</h3>
					${board.p_information }
				</div>
				<div class="left-width">
					<h3>이용 안내</h3>
					${board.p_guide }
				</div>
				<div class="left-width">
				취소 및 환불 규정<br>
				■■■ 특별약관 규정안내 ■■■<br>
				▶이 상품은 항공(또는 선박)좌석 또는 호텔객실에 대한 비용을 일부 선납해 놓은 상품으로, 취소시 별도의 취소료가 적용됨을 양해해 주시기 바랍니다.<br>
				<br>
				1) 여행자의 여행계약 해제 요청이 있는 경우(여행자의 취소 요청시)<br>
				- 여행출발일 ~50일전까지 취소 통보시 - 계약금 환급<br>
				- 여행출발일 49~30일 전까지 취소 통보시 - 여행 요금의 10% 배상<br>
				- 29~20일전까지 취소 통보시 - 여행요금의 20% 배상<br>
				- 여행출발일 19~10일전까지 취소 통보시 - 여행요금의 30% 배상<br>
				- 여행출발일 9~1일전 / 당일 취소까지 취소 통보시 - 여행요금의 60% 배상<br>
				- 여행 출발일 이후는 취소가 불가합니다.<br>
				</div>
				<div class="left-width">
				기업정보
				</div>
				<div class="left-width" style="border: 1px solid black">
					<h2>후기</h2>
		        	<c:choose>
		        		<c:when test="${not empty review }">
						<h1><fmt:formatNumber value="${star.p_star}" pattern=".0"/>점</h1>
				             <c:forEach var="re" items="${review }">
						             <div style="border-top : 1px solid black">
						                   <div>
						                 		<c:out value="${re.m_id}"></c:out><br>
						                 		<c:choose>
					                              <c:when test="${re.p_star eq 5}">
					                                          <span class="gold">★★★★★</span>
					                                 </c:when>
					                                 <c:when test="${re.p_star eq 4}">
					                                          <span class="gold">★★★★</span>
					                                 </c:when>
					                                 <c:when test="${re.p_star eq 3}">
					                                          <span class="gold">★★★</span>
					                                 </c:when>
					                                 <c:when test="${re.p_star eq 2}">
					                                          <span class="gold">★★</span>
					                                 </c:when>
					                                 <c:when test="${re.p_star eq 1}">
					                                          <span class="gold">★</span>
					                                 </c:when>
					                                 <c:otherwise>
					                                 			후기를 남겨주세요
					                                 </c:otherwise>
					                              </c:choose>
						                 		<c:out value="${re.p_reviewdate}"></c:out><br>
						                 		<c:out value="${re.p_reviewcontent}"></c:out>
						                   </div>
						             		<div>
						             			<c:if test= "${not empty re.p_reviewimg }">
						                   			<img alt="이미지" src="/resources/images/${re.p_reviewimg }" width="50px" height="50px">
						                   		</c:if>
						                   </div>
					                 </div>
				             </c:forEach>
				          </c:when>
	 		          <c:otherwise>
							<h5>후기가 없습니다.</h5>
	 		          </c:otherwise>
	                </c:choose>
				</div>
				<div class="left-width">
				함께 보면 좋은 상품
				</div>
				
			</div>
			<div class="right-view">
				<div>
					<fmt:formatNumber value="${board.p_fee }" pattern="#,###" />원 /(1인)<br>
					예약 가능 인원 : <input type="text" name="p_available" value="${board.p_available }" readonly="readonly"><br>
					<form action="people" method="post" id="operForm">
						<input type="number" name="people">명
						<input type="hidden" name="p_num" value="${board.p_num }">
						<input type="submit" value="예약하기" name="reser">
					</form>
					<%-- <a class="wish" href='${board.p_num }'>위시리스트 담기</a> --%>
				</div>
			</div>
				<form action="/pakage/P_pakageList" method="get" id="actionForm">
	            </form>
		</section>
		
<script type="text/javascript">
$(function(){
    var operForm=$("#operForm");
    
    $('input[name=reser]').click(function(e){
    	
    	var pe = parseInt($('input[name=people]').val());
    	var av = parseInt($("input[name=p_available]").val());
    	
    	if(pe < 1){
	    	e.preventDefault();
    		alert("1명 이상 선택해주세요.");
    		return;
    	}
    	
    	if(pe > av){
	    	e.preventDefault();
    		alert("예약 가능한 인원보다 많습니다.");
    		return;
    	}
    	
    	
    });
 });
 


</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>