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
				<div class="left-width" style="height:200px">
					<h1>${board.p_name }</h1><br><br>
					<c:choose>
                          <c:when test="${board.p_star gt 4.5}">
                                      <a href="#review"><span class="gold">후기 ★★★★★(<c:out value="${board.rcount}"></c:out>)</span></a>
                             </c:when>
                             <c:when test="${board.p_star gt 3.5}">
                                      <a href="#review"><span class="gold">후기 ★★★★(<c:out value="${board.rcount}"></c:out>)</span></a>
                             </c:when>
                             <c:when test="${board.p_star gt 2.5}">
                                      <a href="#review"><span class="gold">후기 ★★★(<c:out value="${board.rcount}"></c:out>)</span></a>
                             </c:when>
                             <c:when test="${board.p_star gt 1.5}">
                                      <a href="#review"><span class="gold">후기 ★★(<c:out value="${board.rcount}"></c:out>)</span></a>
                             </c:when>
                             <c:when test="${board.p_star gt 0.5}">
                                      <a href="#review"><span class="gold">후기 ★(<c:out value="${board.rcount}"></c:out>)</span></a>
                             </c:when>
							<c:otherwise>
								<a href="#review">후기 이벤트 진행중🪄</a>
							</c:otherwise>
                    </c:choose>
				</div>
				<div class="left-width">
					<img alt="이미지" src="/img/${board.p_img1 }" width="800px">
					<img alt="이미지" src="/img/${board.p_img2 }" width="800px">
					<img alt="이미지" src="/img/${board.p_img3 }" width="800px">
					<img alt="이미지" src="/img/${board.p_img4 }" width="800px">
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
				<a name="review">
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
						             		<c:choose>
						             			<c:when test= "${not empty re.p_reviewimg }">
						                   			<img alt="이미지" src="/img/${re.p_reviewimg }" width="200px" height="150px">
						                   		</c:when>
						                   		<c:otherwise>
						                   			
						                   		</c:otherwise>
						                   </c:choose>
						                   </div>
					                 </div>
				             </c:forEach>
				          </c:when>
	 		          <c:otherwise>
							<h5>후기가 없습니다.</h5>
	 		          </c:otherwise>
	                </c:choose>
				</div>
				</a>

				
			</div>
			<div class="right-view">
				<div style="height:300px">
					<h2><fmt:formatNumber value="${board.p_fee }" pattern="#,###" />원 / (1인)</h2>
					예약 가능 인원 : <input type="text" name="p_available" value="${board.p_available }" readonly="readonly"><br>
					<form action="people" method="post" id="operForm">
						<input type="number" name="people">명
						<input type="hidden" name="p_num" value="${board.p_num }"><br>
						<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx }"><br>
						<input type="submit" value="예약하기" name="reser" style="width:300px ;height:50px">
					</form>
					<div class="wish1">
						<c:choose>
							<c:when test="${empty heart.w_num }">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
						    		<path fill="none" fill-rule="evenodd" stroke="#CED4DA" stroke-width="1.25" d="M15.876 4.625c1.205 0 2.41.46 3.33 1.379.918.92 1.378 2.124 1.378 3.33 0 1.204-.46 2.41-1.379 3.329h0l-7.1 7.1-7.101-7.1c-.92-.92-1.379-2.125-1.379-3.33s.46-2.41 1.379-3.329c.92-.92 2.124-1.379 3.33-1.379 1.204 0 2.41.46 3.329 1.379.161.162.309.332.442.51.133-.178.28-.349.442-.51.919-.92 2.124-1.379 3.329-1.379z"></path>
						    	</svg>
								<a class="WishIcon-module__container--AE7UW1" >
								위시리스트 담기
								</a>
							</c:when>
							<c:otherwise>
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
						    		<path fill="#FA5B4A" fill-rule="evenodd" stroke="#FA5B4A" stroke-width="1.25" d="M15.876 4.625c1.205 0 2.41.46 3.33 1.379.918.92 1.378 2.124 1.378 3.33 0 1.204-.46 2.41-1.379 3.329h0l-7.1 7.1-7.101-7.1c-.92-.92-1.379-2.125-1.379-3.33s.46-2.41 1.379-3.329c.92-.92 2.124-1.379 3.33-1.379 1.204 0 2.41.46 3.329 1.379.161.162.309.332.442.51.133-.178.28-.349.442-.51.919-.92 2.124-1.379 3.329-1.379z"></path>
						    	</svg>
								<a class="WishIcon-module__container--AE7UW2">
								위시리스트에 추가됨
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
				<form action="/pakage/P_pakageList" method="get" id="actionForm">
	            </form>
		</section>
		
<script type="text/javascript">
$(function(){
	
   	var m_idx = $("input[name=m_idx]").val();
    var p_num = $("input[name=p_num]").val();
   	var heart1 = $(".WishIcon-module__container--AE7UW1");
   	var heart2 = $(".WishIcon-module__container--AE7UW2");
   	var wish1 = $(".wish1");
   	
    $(heart1).on("click",function(e){
    	
    	var actionForm = $("#actionForm");
       	
    	if(m_idx == ''){
    		alert("로그인 부탁드립니다.");
    		actionForm.attr("action", "/Member/login");
            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
            actionForm.submit();
    	}else{
    		
    		var param = {p_num:p_num, m_idx:m_idx};
   			var str = '';
    		
     		$.ajax({
        		type : 'post',
        		data : JSON.stringify(param),
        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
        		contentType : 'application/json; charset=utf-8',
        		success : function(){
        			location.href = "/pakage/P_get?p_num="+p_num;
        			document.location.reload();
        			history.go(0);		
        		}
        	}); 
    	}
    });
   	
    $(heart2).on("click",function(e){
    	
    	var actionForm = $("#actionForm");
       	
    	if(m_idx == ''){
    		alert("로그인 부탁드립니다.");
    		actionForm.attr("action", "/Member/login");
            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
            actionForm.submit();
    	}else{
    		
    		var param = {p_num:p_num, m_idx:m_idx};
   			var str = '';
    		
     		$.ajax({
        		type : 'post',
        		data : JSON.stringify(param),
        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
        		contentType : 'application/json; charset=utf-8',
        		success : function(){
        			location.href = "/pakage/P_get?p_num="+p_num;
        			document.location.reload();
        			history.go(0);		
        		}
        	}); 
    	}
    });
   	
   	
    
    
    
    
   	
    var operForm=$("#operForm");
    
    $('input[name=reser]').click(function(e){
    	
    	var pe = parseInt($('input[name=people]').val());
    	var av = parseInt($("input[name=p_available]").val());
    	
    	if(pe < 1 || pe == ""){
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