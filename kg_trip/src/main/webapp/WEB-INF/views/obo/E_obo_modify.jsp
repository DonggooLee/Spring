<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont">
obo 수정 페이지여요.

	<form name="f" method="post" role="form" enctype="multipart/form-data">
	<div class="info">
		<table class="boardTbl" style="border: 1px solid pink; max-width: 800px">
			<thead>
				<tr>
					<th colspan="2" style="color: hotpink;">!! modify 화면임둥 !!</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>글번호</td>
					<td>${obo.o_num }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="o_title" value='${obo.o_title }' class="obo_"></td>
				</tr>
				<tr>
					<td>카테고리</td>
					<td>
						<select name="o_cat" class="obo_">
							<!-- if 처리해서 fq_cat 뺀 거만 뜨게 
							 = '기타'면 기타 안 뜨게 . (비동기 안하고 할 수 있는 방식. 아닐지도 모름. 일단 레쓰고.)
							-->								
							
							<option value="">선택해주세요~</option>
						     <c:forEach var="list" items="${catList}">
						     <c:choose>
						     	<c:when test="${list eq obo.o_cat }">
							     	<option value="${list}" selected="selected">${list}</option>
							     	<option value="${list}" selected="selected">${list}</option>
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
					<td>
						<textarea rows="10" cols="100" name="o_content" class="obo_">${obo.o_content }</textarea>
					</td>
				</tr>
				<tr >
					<td>파일</td>
					<td id="reloadLayer">
						<c:if test="${ not empty obo.o_file }">
						    ${ obo.o_file} <br>
							<a href="/obo/modify?o_num=${obo.o_num }&o_file=${obo.o_file }"> <br>
							<img src="/img/${obo.o_file }" name="${obo.o_file }" style="max-width: 800px; max-height: 500px;"></a>
						</c:if>
						<button id="removeImgBtn" >사진 삭제</button>
						<input type="file" name="uploadFile"  class="form-control" class="obo_">
					</td>
					
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<button	id="modifyBtn" >글 수정</button>
						<input type="hidden" id="o_num" name="o_num" value='<c:out value="${obo.o_num }"/>' />
						<input type="hidden" id="o_file" name="o_file" value='<c:out value="${obo.o_file }"/>' />
            			<input type="hidden" name="nowPage" value="${pageMaker.nowPage }"> 
						<input type="hidden" name="cntPage" value="${pageMaker.cntPage}">
						<input type="hidden" name="cntPerPage" value="${pageMaker.cntPerPage}">
					</td>
				</tr>
			</tfoot>
		</table>
		</div>
	</form>
	
	
</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<script type="text/javascript" src="/resources/js/E_obo.js"></script>
<script type="text/javascript">
	
	$(function() {
		
		var o_num =  $(".info").find("input[name='o_num']");
		var o_title =  $(".info").find("input[name='o_title']");
		var o_content =  $(".info").find("textarea[name='o_content']");
		var o_cat =  $(".info").find("select[name='o_cat']");
		var o_file =  $(".info").find("input[name='o_file']");
		var uploadFile =  $(".info").find("input[name='uploadFile']");

		// 여기서 val 왜 안되는지 ?
		// 바로 들고오면 .val() 쓸 수 있지만 !
		// 이벤트(ex.onclick, onchange)통해서 입력한 값 꺼내서 쓸 때는! 선언해놓은 그 변수에 ^이벤트 안에서^ val() 붙여서 입력한 값 꺼낼 수 있다.
		// -> "클릭할 때만 꺼내써야 한다!" (상황에 따라 다를 수 있음)
		
		console.log("o_num : " + o_num.val());
		console.log("o_title : " + o_title.val());
		console.log("o_content : " + o_content.val());
		console.log("o_cat : " + o_cat.val());
		console.log("o_file : " + o_file.val());
		console.log("uploadFile : " + uploadFile.val());		
		
		var formObj = $("form");
		
		$("#removeImgBtn").on("click", function(e) {
			e.preventDefault();
			
			alert("뜨는지?");
			
			console.log("버튼 누르면 이거 타는지?");
			var o_numValue = '<c:out value="${obo.o_num }"/>';
			alert(o_numValue);

			oboService.removeImg(o_numValue,function(result) {
				console.log("버튼 누르면 이거 타는지?222");
				console.log("result 값 ? >> " + result);
				
				$('#reloadLayer').load(location.href+' #reloadLayer');
				
			});	
		}); // end : removeImgBtn 이벤트 종료
		
		
		$("#modifyBtn").on("click", function(e) {
			e.preventDefault();
			
			console.log("o_num : " + o_num.val());
			console.log("o_title : " + o_title.val());
			console.log("o_content : " + o_content.val());
			console.log("o_cat : " + o_cat.val());
			console.log("o_file : " + o_file.val());
			console.log("uploadFile : " + uploadFile.val());
			
			var obbo = {
					o_num : o_num.val(),
					o_cat : o_cat.val(),
					o_title : o_title.val(),
					o_content : o_content.val(),
					o_file : o_file.val(),
					uploadFile : uploadFile.val()
			};
			
			oboService.update(obbo,function() {
				location.href = "/obo/list";
			});
			
		}); // end : modifyBtn 이벤트 종료
		
		
	});

</script>

<style>
	input{
		width: 200px;
	}
</style>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>