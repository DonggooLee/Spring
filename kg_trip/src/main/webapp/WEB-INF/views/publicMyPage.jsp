<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont">

	<h1><c:if test="${not empty loginPublicInfo }">${loginPublicInfo.m_id}</c:if> 마이페이지 </h1>
	<h1><c:if test="${empty loginPublicInfo }">실패했음</c:if> 마이페이지 </h1>
	
	<!-- 아현영역 -->
	<a class="move" href='/pakage/P_mlist'>개인회원 구매 패키지 리스트</a><br><br>
			
	<a class="move" href='/pakage/P_rinsert'>개인회원 후기 등록</a><br><br>
	
	<a class="move" href='/pakage/P_clist'>기업회원 패키지 리스트 </a><br><br>
	
	<a class="move" href='/pakage/P_cinsert'>기업회원 패키지 등록</a><br><br>

</section>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



