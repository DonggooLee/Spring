<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />


<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

	<div class="joinBox">
		<div class="publicJoin">
			개인회원
			<button id="joinBtnP">가입하기</button>
		</div>
		<div class="corpJoin">
			기업회원
			<button id="joinBtnC">가입하기</button>
		</div>
	</div>

	<script type="text/javascript">
	$(function () {
		$("#joinBtnP").click(function () {
			location.href = "/KingTrip/join/joinFormP";
		});
		$("#joinBtnC").click(function () {
			location.href = "/KingTrip/join/joinFormC";
		});
		
	});
	</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



