<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont">

	<div class="event">
		메인페이지!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	</div>
	
	<div>
		
		<!-- 보민님 영역 -->
		<h1><c:if test="${not empty loginPublicInfo }">${loginPublicInfo.m_id}</c:if> 마이페이지 </h1>
		<h1><c:if test="${empty loginPublicInfo }">개인회원 로그인 안함</c:if> 마이페이지 </h1>
		<h1><c:if test="${not empty loginCorpInfo }">${loginCorpInfo.c_id}</c:if> 마이페이지 </h1>
		<h1><c:if test="${empty loginCorpInfo }">기업회원 로그인 안함</c:if> 마이페이지 </h1>
		<h1><c:if test="${not empty loginAdminInfo }">${loginAdminInfo.a_id}</c:if> 마이페이지 </h1>
		<h1><c:if test="${empty loginAdminInfo }">관리자 로그인 안함</c:if> 마이페이지 </h1>
		
	</div>
	
	<ul class="user">
		<c:if test="${empty loginPublicInfo == empty loginCorpInfo == empty loginAdminInfo }">
			<li><button class="btn03" id="adminloginBtn">관리자 로그인</button></li>
		</c:if>
	</ul>
	<ul class="user">
		<c:if test="${not empty loginAdminInfo }">
			<li><button class="btn04" id="adminPageBtn">관리자페이지</button></li>
			<li>
				<button class="btn03" id="adminlogoutBtn">로그아웃</button>
			</li>
		</c:if>
	</ul>

</section>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />


