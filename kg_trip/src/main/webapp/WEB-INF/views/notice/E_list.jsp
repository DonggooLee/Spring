<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

	<section class="cont">
		<div class="event">
			안녕
		</div>
		<div class="btnWrap" style="width:calc(100% - 20px); margin:20px 0; padding:0 20px 0 0; padding-right:20px; text-align: right;">
			<button class="btn01">회원가입</button>
		</div>
		
		<div class="contents">
	
		<div id = "outer">	<!-- 옵션 선택 -->
		
		<h3 style="float: left;">총 글수  ${total } </h3> 
		<div style="float: right;">
			<select id="cntPerPage" name ="sel" onchange="selChange()">
				<option value="5"
					<c:if test="${paging.cntPerPage == 5 }">selected</c:if>>5줄 보기</option>
				<option value="10"
					<c:if test="${paging.cntPerPage == 10 }">selected</c:if>>10줄 보기</option>
				<option value="15"
					<c:if test="${paging.cntPerPage == 15 }">selected</c:if>>15줄 보기</option>
				<option value="20"
					<c:if test="${paging.cntPerPage == 20 }">selected</c:if>>20줄 보기</option>
			</select>
		</div>	<!-- 옵션 선택 끝 -->
		
		<br><br>
		
		<!-- <button id="regBtn" type="button">새 게시글 등록</button> -->
		<input type="button" id="regBtn" value="새 게시물 등록">
					
		<table class="boardTbl" style="border: 1px solid pink">
			<thead>
			  <tr>
			    <th>글번호</th>
			    <th>제목</th>
			    <th>등록일</th>
			  </tr>
			</thead>
			<tbody>
				<c:forEach var="notice" items="${list }">
				  <tr>
					<td><c:out value="${notice.n_num }"></c:out></td>
					<td><a class="move" href="${notice.n_num }">
						<c:out value="${notice.n_title }"></c:out></a></td>
					<td><fmt:formatDate value="${notice.n_regDate}"
										pattern="yyyy년 MM월 dd일" /></td>				
				  </tr>
			  	</c:forEach>
			</tbody>
		</table>
		
		<br>

		<div class="pull-right">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage-1 }">&lt;</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }" step="1">
					<li	class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':''}">
						<a href="${num }">${num }</a>&nbsp; &nbsp;
					</li> 
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button"><a
						href="${pageMaker.endPage+1 }">&gt;</a></li>
				</c:if>
			</ul>
		</div>
		<form action="/notice/list" method="get" id="actionForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		</form>
	</div>
	
</section>
<script>
/* function selChange() {
	var sel = document.getElementById('cntPerPage').value;
	location.href="notice/E_list?nowPage=${paging.nowPage}&cntPerPage="+sel;
} */
$(function() {
	
	$("#regBtn").click(function() {
		location.href = '/notice/register';
	});

	var actionForm = $("#actionForm");
	$(".paginate_button a").click(function(e) {
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		// 액션폼이라는 폼태그에서 찾을거야(find). 인풋을. 페이지넘이라는 이름의 객체를. 그 요소의 값(value)을 넣어줄 거야.
		// 어떤 값을 넣을 거야? 내가 누른 a태그의 href 속성을 갖고 와서 넣을 것. 
		actionForm.submit();
	});
	
	// 조회시 이동
	$(".move").click(function(e) {
		// <a> 클릭 시 페이지 이동이 이루어지지 않게 하기 위해
		// e.preventDefault()를 이용.
		e.preventDefault();		 
		actionForm.append("<input type='hidden' name='n_num' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action","/notice/view");
		actionForm.submit();
	});

})
</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>