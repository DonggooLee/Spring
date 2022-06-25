<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 


<jsp:include page="/WEB-INF/views/include/header.jsp" />

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont">

	<div class="event">안녕</div>
	<div class="btnWrap"
		style="width: calc(100% - 20px); margin: 20px 0; padding: 0 20px 0 0; padding-right: 20px; text-align: right;">
		<button class="btn01">회원가입</button>
	</div>

	<div class="contents">
		<form method="get">
			<table>
				<tbody>
					<tr>
						<td class="wider">글번호</td>
						<td><c:out value="${notice.n_num }" /></td>
					</tr>
					<tr>
						<td class="wider">작성자</td>
						<!-- 나중에 a_idx 통해서 작성자 이름/닉네임 가져올 예정 -->
						<td><c:out value="${notice.a_idx }" /></td>
					</tr>
					<tr>
						<td class="wider">제목</td>
						<td><c:out value="${notice.n_title }" /></td>
					</tr>
					<tr>
						<td class="wider">내용</td>
						<td><c:out value="${notice.n_content }" /></td>
					</tr>
					<tr>
						<td class="wider">글등록일</td>
						<td><fmt:formatDate value="${notice.n_regDate}"
										pattern="yyyy년 MM월 dd일" />
						</td>
					</tr>
					<tr>
						<td>
							<c:out value="${notice.n_file }" />	<!-- 경로 띄우기 -->
							<%-- <img alt="이미지" src="<spring:url value='\image\${notice.n_file }'/>"> --%>
							<img alt="이미지" src="/resources/images/${notice.n_file }" width="800px">
													<%-- <img alt="이미지!" src="/register?name=${notice.n_file }"> --%>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" class="center">
							<button data-oper="modify" >글 수정</button>
							<button data-oper="remove" >글 삭제</button> 
							<button data-oper="list" >목록</button> 
									<!-- <input type="button" name="modify" value="수정" onclick="go_modify(this.form)">
									<input type="button" name="remove" value="삭제" onclick="go_remove(this.form)"> -->
							<input type="hidden" id="n_num" name="n_num" value='<c:out value="${notice.n_num }"/>' />
							<input type="hidden" name="pageNum" value="${cri.pageNum }">
							<input type="hidden" name="amount" value="${cri.amount}">
						</td>
					</tr>
					<tr>
						<td colspan="2" class="center">도움이 더 필요하십니까?
							<input type="button" value="문의하기"> 
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
</section>

<style>
	.wider {
		width: 100px;
	}
	
	.td {
		style: 1px solid pink;
	}
	
	.center {
		text-align: center;
	}
</style>
<script type="text/javascript">
$(function() {

	var formObj = $("form");
	$("button").on("click", function(e) {

		e.preventDefault();

		var operation = $(this).data("oper");

		if (operation == 'modify') {
			formObj.attr("action", "/notice/modify"); 

			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();

		}else if(operation == 'remove'){
			formObj.attr("action", "/notice/remove"); 
			formObj.attr("method", "post"); 		//메소드를 get방식으로 변경
			
		}else if (operation == 'list') {
			formObj.attr("action", "/notice/list"); //리스트로 보냄

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

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />