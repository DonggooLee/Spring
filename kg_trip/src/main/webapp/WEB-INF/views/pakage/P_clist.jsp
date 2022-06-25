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
			<h2>c_dname 님의 패키지 목록</h2>
			<div>
				<c:choose>
	        		<c:when test="${not empty clist }">
			             <c:forEach var="clist" items="${clist }">
					             <div>
					             	<table style="background-color: white">
					             		<tr>
					             			<td colspan="2">패키지 번호</td>
					             			
					             			<td>지역</td>
					             			<td>패키지명</td>
					             			<td>패키지 기간</td>
					             			<td>별점</td>
					             			<td>가격(인)</td>
					             			<td>구분</td>
					             			<td></td>
					             		</tr>
					             		<tr>
					             			<td>
					             				<c:out value="${clist.p_num}"></c:out>
					             			</td>
					                   		<td>
					                   			<img alt="이미지" src="/resources/images/${clist.p_mainimg }" width="130px" height="100px">
				                   			</td>
				                   			<td>
					                 			<c:out value="${clist.p_region2}"></c:out>
				                 			</td>
				                 			<td>
			         						    <a class="move" href='${clist.p_num }'>
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
				                 				<a class="movea" href='${clist.p_num }'>수정</a>
				                 				 /
				                 				<a class="moveb" href='${clist.p_num }'> 삭제</a>
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
	var actionForm = $("#actionForm");
	
	$(function(){
		
		 $(".move").click(function(e){
	         e.preventDefault();
	         actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>"); 
	         actionForm.attr("action", "/pakage/P_get");
	         console.log(actionForm);
	         actionForm.submit();
	      });
		 
		 $(".movea").click(function(e){
	         e.preventDefault();
	         actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>"); 
	         actionForm.attr("action", "/pakage/P_cmodify");
	         console.log(actionForm);
	         actionForm.submit();
	      });
		 
		 $(".moveb").click(function(e){
	         e.preventDefault();

			 if(confirm("삭제하시겠습니까?")){
		         actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>"); 
		         actionForm.attr("action", "/pakage/P_cdelete");
		         console.log(actionForm);
		         actionForm.submit();
			 }else{
				 history.back();
			 }
	      });
	});
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>