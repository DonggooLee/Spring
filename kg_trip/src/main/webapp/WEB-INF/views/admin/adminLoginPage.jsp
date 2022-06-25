<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/loginform.css">

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont3">
	<form method="post" id="login_admin">
		<div>
			<fieldset>
				<legend>로그인</legend>
				<div class="input-box">
					<input id="a_id" type="text" name="a_id" placeholder="아이디">
					<label for="a_id">아이디</label>
				</div>

				<div class="input-box">
					<input id="a_pw" type="password" name="a_pw" placeholder="비밀번호">
					<label for="a_pw">비밀번호</label>
				</div>
				<div id="id_forgot">아이디 찾기</div>
				<div id="pw_forgot">비밀번호 찾기</div>
				<input type="button" value="로그인" id="adminloginSubBtn">
			</fieldset>
		</div>
	</form>

</section>
<script>
	$("#adminloginSubBtn").on("click", function() {

			$("#login_admin").attr("action", "/admin/login");
			$("#login_admin").submit();
	});
</script>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
