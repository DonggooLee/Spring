<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
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
	ul li{
		float: left;
		width: 100px;
		height : 80px;
	}
</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="cont">
			
			<div class="searchSection">
				패키지 > 전체 지역<br>
				<h2>어디로 떠나세요?</h2>
				<ul>
					<li>유럽</li>
					<li>동남아시아/일본</li>
					<li>하와이</li>
					<li>괌/사이판</li>
					<li>국내여행</li>
				</ul>
			</div>
			<div>
				<form action="/pakage/P_search" method="post" role="form">
					<h4>국가, 지역명, 도시를 검색하세요 !</h4>
					<input type="text" name="region">
					<button data-oper="P_search" >검색</button>
				</form>
			</div>
			<div>
	            <form action="/pakage/P_pakageList" method="get" id="actionForm">
	            </form>
			</div>
			<!------------------------->
			<h1>전체 여행</h1>
			<div class="pakageSection">
	        	<c:choose>
        		<c:when test="${not empty list }">
		             <c:forEach var="list" items="${list }">
			             <a class="move" href='${list.p_num }'>
				             <div class="pakageList">
				             		<div>
				                   		<img alt="이미지" src="/resources/images/${list.p_mainimg }" width="250px" height="180px">
				                   </div>
				                   <div>
				                 		<c:out value="${list.p_region2}"></c:out><br>
				                 		<c:out value="${list.p_name}"></c:out><br>
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
			                              </c:choose><br>
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

		</section>
		
<script type="text/javascript">
	var actionForm = $("#actionForm");
	
	$(function(){
		
		 $(".move").click(function(e){
	         e.preventDefault();
	         actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>"); 
	         actionForm.attr("action", "/pakage/P_get");
	         console.log(actionForm);
	         actionForm.submit();
	      });
	});
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>