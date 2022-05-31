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
					<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'/>
					<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'/>
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
</script>
<script type="text/javascript">
</script>
<%@include file="../include/footer.jsp" %>