<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

	<section class="cont">
	일대일문의페이지여요.
	
	<div class="contents" style="display: flex; justify-content: center;">
			<form action="list" method="get" id="actionForm">
			 
				<h3 style="float: left;">총 글수  ${total } </h3> 
				<div style="float: right;"> <!-- 옵션 선택 -->
				<select id="cntPerPage" name="sel" onchange="selChange()">
					<option value="5"
						<c:if test="${pageMaker.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
					<option value="10"
						<c:if test="${pageMaker.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
					<option value="15"
						<c:if test="${pageMaker.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
					<option value="20"
						<c:if test="${pageMaker.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
					</select>
				</div> <!-- 옵션선택 끝 -->
				<br><br>
	
				<input type="button" id="regBtn" value="새 게시물 등록"><br><br>
	
				<table class="boardTbl">
					<thead>
					  <tr>
					    <th>글번호</th>
					    <th>카테고리</th>
					    <th>제목</th>
					    <th>등록일</th>
					  </tr>
					</thead>
					<tbody>
						<c:forEach var="obo" items="${list }">
						  <tr>
							<td><c:out value="${obo.o_num }"></c:out></td>
							<td><c:out value="${obo.o_cat }"></c:out></td>
							<td><a class="move" href="${obo.o_num }">
								<c:out value="${obo.o_title }"></c:out></a></td>
							<td><fmt:formatDate value="${obo.o_regDate}"
												pattern="yyyy년 MM월 dd일" /></td>				
						  </tr>
					  	</c:forEach>
					</tbody>
				</table>
			<br>
	
			<div style="display: block; text-align: center;">	
				<c:choose>
					<c:when test="${pageMaker.startPage != 1 && pageMaker.searchType eq ''}">
						<a href="list?nowPage=${pageMaker.startPage - 1 }&cntPerPage=${pageMaker.cntPerPage}" >&lt;</a>
					</c:when>	
					<c:when test="${pageMaker.startPage != 1 && pageMaker.searchType ne ''  }">
						<a href="list?nowPage=${pageMaker.startPage - 1 }&cntPerPage=${pageMaker.cntPerPage}
						&searchType=${pageMaker.searchType}&searchName=${pageMaker.searchName}" >&lt;</a>
					</c:when>
				</c:choose>
				
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="p">
					<c:choose>
						<c:when test="${p == pageMaker.nowPage }">
							<b>${p }</b>
						</c:when>
						
						<c:when test="${p != pageMaker.nowPage && pageMaker.searchType ne '' }">
							<a href="list?nowPage=${p }&cntPerPage=${pageMaker.cntPerPage}&searchType=${pageMaker.searchType}&searchName=${pageMaker.searchName}">
							${p }</a>
						</c:when>
					
						<c:when test="${p != pageMaker.nowPage && pageMaker.searchType eq '' }">
							<a href="list?nowPage=${p }&cntPerPage=${pageMaker.cntPerPage}">${p }</a>
						</c:when>
					</c:choose>
				</c:forEach>
				
				
				<c:choose>
					<c:when test="${pageMaker.endPage != pageMaker.lastPage && pageMaker.searchType eq '' }">
						<a href="list?nowPage=${pageMaker.endPage+1 }&cntPerPage=${pageMaker.cntPerPage}" >&gt;</a>
					</c:when>
					<c:when test="${pageMaker.endPage != pageMaker.lastPage && pageMaker.searchType ne '' }">
						<a href="list?nowPage=${pageMaker.endPage+1 }&cntPerPage=${pageMaker.cntPerPage}
						&searchType=${pageMaker.searchType}&searchName=${pageMaker.searchName}" >&gt;</a>
					</c:when>
				</c:choose>
			</div>	<!-- div paging end -->

			<input type="hidden" name="nowPage" value="${pageMaker.nowPage }"> 
			<input type="hidden" name="cntPage" value="${pageMaker.cntPage}">
			<input type="hidden" name="cntPerPage" value="${pageMaker.cntPerPage}">
			
		</form>
	</div>	<!-- div contents end -->
	
	</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<!-- 스크립트 -->
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		// location.href = "list?&nowPage=${pageMaker.nowPage}&cntPerPage="+sel; // 원래꺼 (~22/7/7)
		location.href = "list?&nowPage=1&cntPerPage="+sel;	// 7/8 cntPerPage 옵션 선택시 무조건 1페이지로 가기.
	}

	// 카테고리 선택시 해당 카테고리별 글 볼 수 있게
	function catChange() {
		/* var cat = document.getElementById('fq_cat').value;
		location.href = "list?&cat=" + cat ; */
	}
	
	$(function() {
		
		$("#regBtn").click(function() {
			location.href = '/obo/register';
		});
	
		var actionForm = $("#actionForm");
		
		// 조회시 이동
		$(".move").click(function(e) {
			// <a> 클릭 시 페이지 이동이 이루어지지 않게 하기 위해
			// e.preventDefault()를 이용.
			e.preventDefault();		 
			actionForm.append("<input type='hidden' name='o_num' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action","/obo/view");
			actionForm.submit();
		});
	})
</script>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
