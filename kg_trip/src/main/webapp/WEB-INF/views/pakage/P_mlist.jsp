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
					             			<td colspan="2">패키지 번호</td>
					             			
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
			         						    <a class="move" href='${mlist.p_num }'>
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
				                 				<a class="movea" href='${mlist.p_num }'>결제취소하기</a>
				                 				/
				                 				<a class="moveb" href='${mlist.p_num }'>후기작성</a>
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