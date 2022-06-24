<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont">

	<div class="event">
		메인페이지!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</div>
		
	<div class="btnWrap"
		style="width: calc(100% - 20px); margin: 20px 0; padding: 0 20px 0 0; padding-right: 20px; text-align: right;">
		<button class="btn01">회원가입</button>
	</div>
	<h1><c:if test="${not empty loginPublicInfo }">${loginPublicInfo.m_id}</c:if> 마이페이지 </h1>
	<h1><c:if test="${empty loginPublicInfo }">실패했음</c:if> 마이페이지 </h1>

	<div class="contents">하이</div>

</section>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />


