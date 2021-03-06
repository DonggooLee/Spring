<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 등록</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글 등록</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<form action="/board/register" method="post" role="form">
					<div class="form-group">
						<label>제목</label>
						<input class="form-control" name="title">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="3" name="content"></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label>
						<!-- <input class="form-control" name="writer"> -->
						<input class="form-control" name="writer" value='<sec:authentication property="principal.username"/>' readonly="readonly">
					</div>
					<button data-oper="register" type="submit" class="btn btn-primary">등록</button>
					<button data-oper="list" type="button" onclick="location.href='/board/list'" class="btn btn-danger">목록</button>
 					<button type="reset" class="btn btn-warning">취소</button>
 					<!-- 시큐리티 이용할 때  포스트 방식으로 던질 때 필요! -->
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

<%@include file="../include/footer.jsp" %>