<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

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
					<button type="submit" class="btn btn-primary">글 수정</button>
					<button type="submit" class="btn btn-warning">글 삭제</button>
					<button type="submit" class="btn btn-warning">목록</button>
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
</script>


<%@include file="../include/footer.jsp" %>