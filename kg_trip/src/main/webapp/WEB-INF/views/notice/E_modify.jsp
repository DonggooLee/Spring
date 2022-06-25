<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
				<form action="/notice/modify" method="post" role="form" enctype="multipart/form-data">
				
					<table>
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
								<td>파일</td>
								<td class="uploadDiv">
									<input type="file" name="uploadFile" multiple="multiple" style="float: left;" value="${notice.n_file }">
								</td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea rows="10" cols="80" name="n_content"> 
									<c:out value="${notice.n_content }"></c:out>
								</textarea></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">
									<button data-oper="modify" type="submit">글 수정</button>
									<input type="reset" value="새로쓰기.!!!">
									<input type="button" value="목록.!!!">
									<!-- <button data-oper="list" type="submit">글 수정</button>
										onclick="location.href = '/notice/list'"> -->
									<input type="hidden" id="n_num" name="n_num" value='<c:out value="${notice.n_num }"/>' />
									<input type="hidden" name="pageNum" value="${cri.pageNum }">
               						<input type="hidden" name="amount" value="${cri.amount}">
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
				formObj.attr("action", "/notice/modify"); //리스트로 보냄

				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();

			} else if (operation == 'list') {
				formObj.attr("action", "/notice/list"); //리스트로 보냄
				formObj.attr("method", "get"); 			//메소드를 get방식으로 변경

				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();

				formObj.empty(); //form 안에있는 모든 데이터들을 다 날려버림

				formObj.append(pageNumTag);
				formObj.append(amountTag);

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

		
	
