<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

	<section class="cont">
	freq 수정 페이지여요.
		<form action="/freq/modify" name="f" method="post" role="form" enctype="multipart/form-data">
			<table class="boardTbl" style="border: 1px solid pink; max-width: 800px">
				<thead>
					<tr>
						<th colspan="2" style="color: hotpink;">!! modify 화면임둥 !!</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>글번호</td>
						<td>${freq.fq_num }</td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="fq_title" value='${freq.fq_title }' class=""></td>
					</tr>
					<tr>
						<td>카테고리</td>
						<td>
							<select name="fq_cat">
								<!-- if 처리해서 fq_cat 뺀 거만 뜨게 
								 = '기타'면 기타 안 뜨게 . (비동기 안하고 할 수 있는 방식. 아닐지도 모름. 일단 레쓰고.)
								-->								
								
								<option value="">선택해주세요~</option>
							     <c:forEach var="list" items="${catList}">
							     <c:choose>
							     	<c:when test="${list eq freq.fq_cat }">
								     	<option value="${list}" selected="selected">${list}</option>
								     	<%-- <option value="${list}" selected="selected">${list}</option> --%>
								     </c:when>
								     <c:otherwise>
								     	<option value="${list}">${list}</option>
								     </c:otherwise>
							     </c:choose>
							    </c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<%-- <td><input type="text" name="fq_content" value='<c:out value="${freq.fq_content }"></c:out>'></td> --%>
						<td>
							<textarea rows="10" cols="100" name="fq_content">${freq.fq_content }</textarea>
						</td>
					</tr>
					<tr >
						<td>파일</td>
						<td>
							<c:if test="${ not empty freq.fq_file }">
							    ${ freq.fq_file} &nbsp;&nbsp;&nbsp;
								
								<a href="/freq/modify?fq_num=${freq.fq_num }&fq_file=${freq.fq_file }"> 
								<img src="/img/${freq.fq_file }" style="max-width: 800px; max-height: 500px;"></a>
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
							
							<input type="hidden" id="fq_num" name="fq_num" value='<c:out value="${freq.fq_num }"/>' />
							<input type="hidden" id="fq_file" name="fq_file" value='<c:out value="${freq.fq_file }"/>' />
             				<input type="hidden" name="nowPage" value="${pageMaker.nowPage }"> 
							<input type="hidden" name="cntPage" value="${pageMaker.cntPage}">
							<input type="hidden" name="cntPerPage" value="${pageMaker.cntPerPage}">
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->


<script type="text/javascript">

	/* 
    function deleteFile(obj) {
        obj.parent().remove();
    }
	*/
	$(function() {
		/* $("#delFile").on("click", function(e) {
			alert("$(this).fq_file은? " + $(this).attr("value"));
		    //deleteFile($(this).attr("value"));
			$(this).fq_file.remove();
        });
		 */
		 
		 /* 
		$("#delFile").click(function(){
			if(confirm("한번 삭제하면 복구할 수 없습니다.\n정말로 삭제하시겠습니까?")==true){
				
				$.ajax({
					type:"POST",
					url:"/freq/modifyImg",
					dataType:'json',
					data: param, //json형태로 데이터를 날려줍니다.
					success: function(data){ 
						alert("이미지 삭제 성공 !"); 
					},
						//이미지를 지웠으면 blank이미지로 교체 해준다.
					error: function(){ 
						alert("사진을 삭제하지 못했습니다."); 
					}
				});
			}
		});
		 */
		
		
		var formObj = $("form");
		$("button").on("click", function(e) {

			e.preventDefault();

			var operation = $(this).data("oper");

			if (operation == 'modify') {
				formObj.attr("action", "/freq/modify"); //리스트로 보냄

				var nowPageTag = $("input[name='nowPage']").clone();
				var cntPageTag = $("input[name='cntPage']").clone();

			} else if (operation == 'list') {
				formObj.attr("action", "/freq/list"); //리스트로 보냄
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

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
