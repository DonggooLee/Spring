<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont">
			
			<div class="contents" >
				<form action="/notice/ntModify" method="post" role="form" enctype="multipart/form-data">
				
					<table class="boardTbl" style="border: 1px solid pink; max-width: 800px">
						<thead>
							<tr>
								<th colspan="2" style="color: hotpink;">!! modify 화면임둥 !!</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>글번호</td>
								<td>${notice.n_num }</td>
							</tr>
							<tr>
								<td>제목</td>
								<td><input type="text" name="n_title" value='<c:out value="${notice.n_title }"></c:out>'></td>
							</tr>
							
							<tr>
								<td>내용</td>
								<td><input type="text" name="n_content" value='<c:out value="${notice.n_content }"></c:out>'></td>
							</tr>
							<tr >
								<td>파일</td>
								<td>
									<c:if test="${ not empty notice.n_file }">
									    ${ notice.n_file} &nbsp;&nbsp;&nbsp;
										
										<a href="/notice/ntModify?n_num=${notice.n_num }&n_file=${notice.n_file }"> 
										<img src="/img/${notice.n_file }" style="max-width: 800px; max-height: 500px;"></a>
									</c:if>
									<!-- <form action="/freq/modify" method="post" role="form" enctype="multipart/form-data"> -->
									&nbsp;&nbsp;&nbsp; 
									&nbsp;&nbsp;&nbsp; 
									<!-- 파일삭제 선택  :  <input type="button" value="삭제" name="delFile" > &nbsp;&nbsp;&nbsp; 
									<button value="${freq.fq_file }" id="delFile">삭제</button> --> &nbsp;&nbsp;&nbsp;
									
									<input type="file" name="uploadFile"  class="form-control">
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">
									<button data-oper="modify" type="submit">글 수정</button>
									<input type="reset" value="새로쓰기.!!!">
									<input type="button" value="목록.!!!">
									
									<input type="hidden" id="n_num" name="n_num" value='<c:out value="${notice.n_num }"/>' />
               						<input type="hidden" name="nowPage" value="${pageMaker.nowPage }"> 
									<input type="hidden" name="cntPage" value="${pageMaker.cntPage}">
									<input type="hidden" name="cntPerPage" value="${pageMaker.cntPerPage}">
								</td>
							</tr>
						</tfoot>
					</table>
				</form>
			</div>
		
		</section>
<script type="text/javascript">

	$(function() {

		var formObj = $("form");
		$("button").on("click", function(e) {

			e.preventDefault();

			var operation = $(this).data("oper");

			if (operation == 'modify') {
				formObj.attr("action", "/notice/ntModify"); //리스트로 보냄

				var nowPageTag = $("input[name='nowPage']").clone();
				var cntPageTag = $("input[name='cntPage']").clone();

			} else if (operation == 'list') {
				formObj.attr("action", "/notice/ntList"); //리스트로 보냄
				formObj.attr("method", "get"); 			//메소드를 get방식으로 변경

				var nowPageTag = $("input[name='nowPage']").clone();
				var cntPageTag = $("input[name='cntPage']").clone();

				formObj.empty(); //form 안에있는 모든 데이터들을 다 날려버림

				formObj.append(nowPageTag);
				formObj.append(cntPageTag);

			}
			formObj.submit();
		});

	});

</script>

<style>
	input{
		width: 200px;
	}
	
</style>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
