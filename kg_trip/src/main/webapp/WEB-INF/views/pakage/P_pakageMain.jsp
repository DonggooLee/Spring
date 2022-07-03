<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>

<style type="text/css">
	.searchSection{
		width: 1200px;
		height : 200px;
		background-color: white;
	}
	.pakageSection{
		width: 1200px;
	}
	.pakageList{
		width: 300px;
		height: 400px;
		float: left;
		background-color: white;
	}
	
	.conted {
		/* position: relative; */
		width: 100%;
		max-width: 1200px;
		margin: 0 auto;
		height: 1600px;
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
			
			<div class="searchSection">
				<h2>어디로 떠나세요?</h2>
				<ul>
					<li><a href="/pakage/P_allList">전체보기</a></li>
				</ul>
			</div>
			<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}" >
			<!------------------------->
			<h1>Best 유럽여행지 특가!</h1>
			<div class="pakageSection">
	        	<c:choose>
        		<c:when test="${not empty listWeu }">
		             <c:forEach var="weu" items="${listWeu }">
				             <div class="pakageList">
				             		<div style="position: relative;">
				             			<a href="/pakage/P_get?p_num=${weu.p_num }">
				                   			<img alt="이미지" src="/resources/images/${weu.p_mainimg }" width="295px" height="180px"/>
			                   			</a>
				                   		<div style="position: absolute; top: 5px; right: 10px" class="heart">
				                   			<img alt="이미지" src="/resources/images/h2.svg" data-num="${weu.p_num}" class="wish"/>
				                   		</div>
				                    </div>
			             <a href="/pakage/P_get?p_num=${weu.p_num }">
				                   <div>
				                 		<c:out value="${weu.p_region2}"></c:out><br>
				                 		<c:out value="${weu.p_name}"></c:out><br>
				                 		<c:out value="${weu.p_period}"></c:out><br>
										<c:choose>
			                              <c:when test="${weu.p_star gt 4.5}">
			                                          <span class="gold">★★★★★</span>
			                                 </c:when>
			                                 <c:when test="${weu.p_star gt 3.5}">
			                                          <span class="gold">★★★★</span>
			                                 </c:when>
			                                 <c:when test="${weu.p_star gt 2.5}">
			                                          <span class="gold">★★★</span>
			                                 </c:when>
			                                 <c:when test="${weu.p_star gt 1.5}">
			                                          <span class="gold">★★</span>
			                                 </c:when>
			                                 <c:when test="${weu.p_star gt 0.5}">
			                                          <span class="gold">★</span>
			                                 </c:when>
											<c:otherwise>
														후기 이벤트 진행중🥰
											</c:otherwise>
			                              </c:choose>
			                              (<c:out value="${weu.rcount}"></c:out>)<br>
				                 		<fmt:formatNumber value="${weu.p_fee }" pattern="#,###" />원 /1인
				                   </div>
			                 </div>
		                 </a>
		             </c:forEach>
		          </c:when>
 		          <c:otherwise>
						<h5>게시물이 없습니다.</h5>
 		          </c:otherwise>
             </c:choose>
			</div>
			<h1>우리가 찾던 허니문</h1>
			<div class="pakageSection">
	        	<c:choose>
        		<c:when test="${not empty listSai }">
		             <c:forEach var="sai" items="${listSai }">
			              <a href="/pakage/P_get?p_num=${sai.p_num }">
				             <div class="pakageList">
				             		<div>
				                   		<img alt="이미지" src="/resources/images/${sai.p_mainimg }" width="250px" height="180px">
				                   </div>
				                   <div>
				                 		<c:out value="${sai.p_region2}"></c:out><br>
				                 		<c:out value="${sai.p_name}"></c:out><br>
				                 		<c:out value="${sai.p_period}"></c:out><br>
										<c:choose>
			                              <c:when test="${sai.p_star gt 4.5}">
			                                          <span class="gold">★★★★★</span>
			                                 </c:when>
			                                 <c:when test="${sai.p_star gt 3.5}">
			                                          <span class="gold">★★★★</span>
			                                 </c:when>
			                                 <c:when test="${sai.p_star gt 2.5}">
			                                          <span class="gold">★★★</span>
			                                 </c:when>
			                                 <c:when test="${sai.p_star gt 1.5}">
			                                          <span class="gold">★★</span>
			                                 </c:when>
			                                 <c:when test="${sai.p_star gt 0.5}">
			                                          <span class="gold">★</span>
			                                 </c:when>
											<c:otherwise>
														후기 이벤트 진행중🥰
											</c:otherwise>
			                              </c:choose>
			                              (<c:out value="${sai.rcount}"></c:out>)<br>
				                 		<fmt:formatNumber value="${sai.p_fee }" pattern="#,###" />원 /1인
				                   </div>
			                 </div>
		                 </a>
		             </c:forEach>
		          </c:when>
 		          <c:otherwise>
						<h5>게시물이 없습니다.</h5>
 		          </c:otherwise>
             </c:choose>
			</div>
			<h1>국내로 떠나는 섬캉스</h1>
			<div class="pakageSection">
	        	<c:choose>
        		<c:when test="${not empty listkos }">
		             <c:forEach var="kos" items="${listkos }">
			              <a href="/pakage/P_get?p_num=${kos.p_num }">
				             <div class="pakageList">
				             		<div>
				                   		<img alt="이미지" src="/resources/images/${kos.p_mainimg }" width="250px" height="180px">
				                   </div>
				                   <div>
				                 		<c:out value="${kos.p_region2}"></c:out><br>
				                 		<c:out value="${kos.p_name}"></c:out><br>
				                 		<c:out value="${kos.p_period}"></c:out><br>
				                 		<c:choose>
			                              <c:when test="${kos.p_star gt 4.5}">
			                                          <span class="gold">★★★★★</span>
			                                 </c:when>
			                                 <c:when test="${kos.p_star gt 3.5}">
			                                          <span class="gold">★★★★</span>
			                                 </c:when>
			                                 <c:when test="${kos.p_star gt 2.5}">
			                                          <span class="gold">★★★</span>
			                                 </c:when>
			                                 <c:when test="${kos.p_star gt 1.5}">
			                                          <span class="gold">★★</span>
			                                 </c:when>
			                                 <c:when test="${kos.p_star gt 0.5}">
			                                          <span class="gold">★</span>
			                                 </c:when>
											<c:otherwise>
														후기 이벤트 진행중🥰
											</c:otherwise>
			                              </c:choose>
			                              (<c:out value="${kos.rcount}"></c:out>)<br>
				                 		<fmt:formatNumber value="${kos.p_fee }" pattern="#,###" />원 /1인
				                   </div>
			                 </div>
		                 </a>
		             </c:forEach>
		          </c:when>
 		          <c:otherwise>
						<h5>게시물이 없습니다.</h5>
 		          </c:otherwise>
             </c:choose>
			</div>
           	<form id="actionForm">
        	</form>
		</section>
		
<script type="text/javascript">

$(function(){
	
	
   	var m_idx = $("input[name=m_idx]").val();
   	var heart = $(".heart")
   	
    $(heart).on("click", "img",function(e){
    	
    	
    	var actionForm = $("#actionForm");
    	var p_num = $(this).data("num");
       	
    	if(m_idx == ''){
    		alert("로그인 부탁드립니다.");
            actionForm.attr("action", "/userP/login");
            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
            actionForm.submit();
    	}else{
    		alert(p_num);
    		alert(m_idx);
    		
    		$.ajax({
        		type : 'post',
        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert?p_num='+ p_num + '&m_idx=' + m_idx,
        		contentType : 'application/json; charset=utf-8',
        		success : function(wlist) {
    				var str = '';
    				
					str += '<img alt="이미지" src="/resources/images/h1.svg" data-num="'+ ${weu.p_num} +'" class="wish"/>'
						
        			console.log(wlist);
					heart.html(str)
        		}
        	});
    		
    		
    		
    		
    	}
    	
    });
	
	
});

</script>		

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>