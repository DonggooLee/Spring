<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/corpHeader.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont2">
			<div class="all" style="display: flex;">
				<jsp:include page="/WEB-INF/views/include/corpMenuBar.jsp"></jsp:include>
				
				<div class="content_section" style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
					<div class="content" style=" margin : 10px; background-color: white;">
		<h2>${loginCorpInfo.c_dname}님의 패키지 목록</h2>
             <div>
             	<table style="background-color: white; text-align:center">
             		<tr>
             			<td width=100px>패키지 번호</td>
             			<td width=100px></td>
             			<td width=100px>지역</td>
             			<td width=300px>패키지명</td>
             			<td width=100px>패키지 기간</td>
             			<td width=100px>별점</td>
             			<td width=100px>가격(인)</td>
             			<td width=100px>구분</td>
             			<td width=100px>수정 / 삭제</td>
             		</tr>
					<c:choose>
		        		<c:when test="${not empty clist }">
				             <c:forEach var="clist" items="${clist }">
			             		<tr>
			             			<td>
			             				<c:out value="${clist.p_num}"></c:out>
			             			</td>
			                   		<td>
			                   			<img alt="이미지" src="/img/${clist.p_mainimg }" width="130px" height="100px">
		                   			</td>
		                   			<td>
			                 			<c:out value="${clist.p_region2}"></c:out>
		                 			</td>
		                 			<td>
	         						    <a href="/pakage/P_get?p_num=${clist.p_num }">
				                 			<c:out value="${clist.p_name}"></c:out>
		                 				</a>
		                 			</td>
		                 			<td>
				                 		<c:out value="${clist.p_period}"></c:out>
		                 			</td>
		                 			<td>
				                 		<c:choose>
			                              <c:when test="${clist.p_star == 0.0}">
                                    			후기 없음
			                                 </c:when>
											<c:otherwise>
												<c:out value="${clist.p_star}"></c:out>
											</c:otherwise>
			                              </c:choose>
		                 			</td>
		                 			<td>
				                 		<fmt:formatNumber value="${clist.p_fee }" pattern="#,###" />원
		                 			</td>
		                 			<td>
		                 				<c:out value="${clist.p_division}"></c:out>
		                 			</td>
		                 			<td>
		                 				  <a href="/pakage/P_cmodify?p_num=${clist.p_num }">수정</a>
		                 				 /
		                 				 <a href="/pakage/P_cdelete?p_num=${clist.p_num }"> 삭제</a>
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
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
