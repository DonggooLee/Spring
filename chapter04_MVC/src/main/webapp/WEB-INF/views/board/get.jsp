<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 화면</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글 화면</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group">
					<label>글 번호</label>
					<input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>글 제목</label>
					<input class="form-control" name="title" value='<c:out value="${board.title }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>글 내용</label>
					<textarea class="form-control" name="content" rows="3" readonly="readonly"><c:out value="${board.content }"/></textarea>
				</div>
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>
				<button data-oper="modify" class="btn btn-primary">수정</button>
				<button data-oper="list" class="btn btn-warning">목록</button>
				
				<form action="/board/modify" method="get" id="operForm">
					<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'/>
					<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount" value="${cri.amount }">
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript" src="/resources/js/util.js"></script>
<script type="text/javascript">

	$(function() {
		
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").click(function() {
			operForm.attr("action","/board/modify").submit();
		});
		
		$("button[data-oper='list']").click(function() {
			// 리스트로 이동할 때는 bno 값이 필요 없기 때문에!
			operForm.find("#bno").remove();
			operForm.attr("action","/board/list").submit();
		});
		
	})

</script>
<script type="text/javascript">
	
	console.log("================");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';

	// add 함수를 호출하고 필요한 인자값 3개중 에러를 제외한 2개 던져준다
	replyService.add(
		{bno:bnoValue, reply:'JS TEST', replyer:'tester'},
		function(result) {
			// js 파일에서 성공한다면 콜백 함수가 실행되면서 result값이 넘어 오는것을 받는다
			alert("result : " + result);
		}
	);
	
</script>
<%@include file="../include/footer.jsp" %>