<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont2">
			<div class="all" style="display: flex;">
				<jsp:include page="/WEB-INF/views/include/publicMenuBar.jsp"></jsp:include>
				<div class="content_section" style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
					<div class="content" style=" margin : 10px; background-color: white;">
						<div>
		            		<form action="/pakage/P_pakageList" method="get" id="actionForm">
		           			</form>
						</div>
						<h2>${loginPublicInfo.m_name}님의 패키지 목록</h2>
						<div>
			             	<table style="background-color: white">
			             		<tr style="text-align:center">
			             			<td width="100px">예약번호</td>
			             			<td width="100px"></td>
			             			<td width="80px">지역</td>
			             			<td width="300px">패키지명</td>
			             			<td width="200px">패키지 기간</td>
			             			<td width="100px">가격 / 인원</td>
			             			<td width="200px">구분</td>
			             			<td width="100px">예약상태</td>
			             			<td width="100px"></td>
			             		</tr>
								<c:choose>
				        			<c:when test="${not empty mlist }">
						            	 <c:forEach var="mlist" items="${mlist }">
						             		<tr style="text-align:center">
						             			<td>
						             				<c:out value="${mlist.p_rnum}"></c:out>
						             			</td>
						                   		<td>
						                   			<img alt="이미지" src="/img/${mlist.p_mainimg }" width="130px" height="100px">
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
							                 		<fmt:formatNumber value="${mlist.p_totalfee }" pattern="#,###" />원 /
							                 		<c:out value="${mlist.p_rpeople}"/>인
					                 			</td>
				
					                 			<td width="100px">	
					                 				<c:choose>
					                 					<c:when test="${mlist.p_completion == '환불완료'}">
						                 					
					                 					</c:when>
					                 					<c:when test="${mlist.p_renum == 0}">
						                 					<a class="move" href='/pakage/P_rinsert?p_rnum=${mlist.p_rnum }&p_num=${mlist.p_num }'>후기작성</a>
					                 					</c:when>
					                 					<c:otherwise>
						                 					 <a href="/pakage/P_get?p_num=${mlist.p_num }">작성완료</a>
					                 					</c:otherwise>
					                 				</c:choose>
					                 			</td>
					                 			<td>
					                 				<c:out value="${mlist.p_completion}"></c:out>
					                 			</td>
					                 				                 			<td width="100px">
					                 				<c:choose>
					                 					<c:when test="${mlist.p_completion == '환불완료' || mlist.p_renum != 0 }">	
					                 						 
					                 					</c:when>
					                 					<c:otherwise>
					                 						<form action="P_kakaoPayCancel" method="post" id="refundForm">
					                 						<input type="hidden" value="${mlist.p_rnum }" name="p_rnum">
					                 						<input type="hidden" value="${mlist.p_num }" name="p_num">
					                 						<input type="hidden" value="${mlist.p_totalfee }" name="p_totalfee">
					                 						<input type="hidden" value="${mlist.p_tid }" name="tid">
						                 						<button class="refundBtn">
						                 							결제취소
						                 						</button>
					                 						</form>
					                 					</c:otherwise>
					                 				</c:choose>
					                 			</td>	
						             		</tr>
						             </c:forEach>
						          </c:when>
				 		          <c:otherwise>
								  	<h5>게시물이 없습니다.</h5>
				 		          </c:otherwise>
			            	  </c:choose>
	             			</table>
			   			</div>
					</div>
				</div>
			</div>
		</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<script type="text/javascript">

$(function() {

	$(".refundBtn").on("click", function(e){
        e.preventDefault();
        confirm("정말 환불하시겠습니까?");
        $("#refundForm").submit();
	});
});	
	
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
