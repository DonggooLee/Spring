<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 수정-삭제 화면</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글 수정-삭제 화면</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<form action="/board/modify" method="post">
					<div class="form-group">
						<label>글 번호</label>
						<input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>글 제목</label>
						<input class="form-control" name="title" value='<c:out value="${board.title }"/>'>
					</div>
					<div class="form-group">
						<label>글 내용</label>
						<textarea class="form-control" name="content" rows="3"><c:out value="${board.content }"/></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
					</div>
					<input type="hidden" class="form-control" name="regDate" value='<c:out value="${board.regdate }"/>' readonly="readonly">
					<input type="hidden" class="form-control" name="updateDate" value='<c:out value="${board.updatedate }"/>' readonly="readonly">
					<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
						<!-- 만일 로그인 되어 있다면 작성자와 로그인 한 사용자 비교-->
						<c:if test="${pinfo.username eq board.writer}">
							<button data-oper="modify" type="submit" class="btn btn-primary">글 수정</button>
							<button data-oper="remove" type="submit" class="btn btn-warning">글 삭제</button>
						</c:if>
					</sec:authorize>
					<button data-oper="list" type="submit" class="btn btn-warning">목록</button>
					<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount" value="${cri.amount }">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csfr.token }">
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<script type="text/javascript">

	$(function() {
		// form 태그 액션을 바꾸기 위해 객체를 가져오기
		var formObj = $("form");
		$("button").on("click", function(e){
			e.preventDefault();
			var operation = $(this).data("oper");
			if(operation == "remove"){
				// form 태그 action 속성을 /board/remove 로 변경
				formObj.attr("action", "/board/remove");	
			}else if(operation == "list"){
				// form 태그 action 속성을 /board/list 로 변경
				formObj.attr("action", "/board/list");	
				// get 방식으로 보내기 위해 보낼 데이터도 없음
				formObj.attr("method", "get");	
				// 해당요소를 복사
				var pageNum = $("input[name='pageNum']").clone();
				var amount = $("input[name='amount']").clone();
				// 불필요한 데이터가 넘어가는 것을 방지하기 위해 비우기
				formObj.empty();
				// 페이징 처리를 위해  pageNum, amount 붙여서  던지기				
				formObj.append(pageNum);
				formObj.append(amount);
			}
			formObj.submit();
		})
	})

</script>

<%@include file="../include/footer.jsp" %>