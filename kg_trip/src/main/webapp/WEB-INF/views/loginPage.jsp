<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/loginform.css">

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->


<section class="cont3">
	<form method="post" id="login_all">
		<div>
			<div class="login_tab">
				<button type="button" id="publicBtn" class="login_tab_public">개인회원</button>
				<button type="button" id="corpBtn" class="login_tab_corp">기업회원</button>
			</div>
			<fieldset>
				<legend>로그인</legend>
				<div class="input-box">
					<input id="m_id" type="text" name="m_id" placeholder="아이디">
					<label for="m_id">아이디</label>
				</div>

				<div class="input-box">
					<input id="m_pw" type="password" name="m_pw" placeholder="비밀번호">
					<label for="m_pw">비밀번호</label>
				</div>
				<div id="id_forgot">아이디 찾기</div>
				<div id="pw_forgot">비밀번호 찾기</div>
				<input type="button" value="로그인" id="loginSubBtn">
			</fieldset>
		</div>
	</form>

</section>
<script>
	$(function() {
		//개인회원 버튼을 누르면 
		$("#publicBtn").on("click", function() {
			$("input[name=c_id]").attr("name", "m_id");
			$("input[name=c_pw]").attr("name", "m_pw");
		});
		//기업회원 버튼을 누르면 
		$("#corpBtn").on("click", function() {
			$("input[name=m_id]").attr("name", "c_id");
			$("input[name=m_pw]").attr("name", "c_pw");
		});
	});
	$("#loginSubBtn").on("click", function() {
		var m_id = $("input[name=m_id]").val();
		if (typeof m_id == "undefined") {
			$("#login_all").attr("action", "/userC/login");
			$("#login_all").submit();
		} else {
			$("#login_all").attr("action", "/userP/login");
			$("#login_all").submit();
		}
	});
</script>



<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



