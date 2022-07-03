<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<style type="text/css">
	td{
		width : 200px;
	}
</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="cont">
			<div>
	            <form action="/pakage/P_pakageList" method="get" id="actionForm">
	            </form>
			</div>
			<h2>${loginPublicInfo.m_name}님의 패키지 목록</h2>
			<div>
				<c:choose>
	        		<c:when test="${not empty mlist }">
			             <c:forEach var="mlist" items="${mlist }">
					             <div>
					             	<table style="background-color: white">
					             		<tr>
					             			<td colspan="2">예약번호</td>
					             			
					             			<td>지역</td>
					             			<td>패키지명</td>
					             			<td>패키지 기간</td>
					             			<td>가격 / 명</td>
					             			<td>구분</td>
					             			<td></td>
					             		</tr>
					             		<tr>
					             			<td>
					             				<c:out value="${mlist.p_rnum}"></c:out>
					             			</td>
					                   		<td>
					                   			<img alt="이미지" src="/resources/images/${mlist.p_mainimg }" width="130px" height="100px">
				                   			</td>
				                   			<td>
					                 			<c:out value="${mlist.p_region2}"></c:out>
				                 			</td>
				                 			<td>
			         						   <a href="/pakage/P_get?p_num=${mlist.p_num }">
						                 			<c:out value="${mlist.p_name}"></c:out>
				                 				</a>
				                 			</td>
				                 			<td>
						                 		<c:out value="${mlist.p_period}"></c:out>
				                 			</td>
				                 			<td>
						                 		<fmt:formatNumber value="${mlist.p_totalfee }" pattern="#,###" /> /
						                 		<c:out value="${mlist.p_rpeople}"></c:out>
				                 			</td>
				                 			<td>
				                 				<a class="move" href='/pakage/P_mdelete?p_rnum=${mlist.p_rnum }&p_num=${mlist.p_num }'>결제취소하기</a>
				                 				/
				                 				<c:choose>
				                 					<c:when test="${mlist.p_renum == 0}">
					                 					<a class="move" href='/pakage/P_rinsert?p_rnum=${mlist.p_rnum }&p_num=${mlist.p_num }'>후기작성하기</a>
				                 					</c:when>
				                 					<c:otherwise>
					                 					 <a href="/pakage/P_get?p_num=${mlist.p_num }">후기작성완료</a>
				                 					</c:otherwise>
				                 				</c:choose>
				                 			</td>
					             		</tr>
				             		</table>
				                 </div>
			             </c:forEach>
			          </c:when>
	 		          <c:otherwise>
							<h5>게시물이 없습니다.</h5>
	 		          </c:otherwise>
	             </c:choose>
			</div>
		</section>
		
<script type="text/javascript">

</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>