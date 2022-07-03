<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<div class="menu_section" style="border: 1px solid black; width: 15%;">
	<ul style="list-style-type: none;">
		<li></li>
		<li>대시보드</li>
		<li>계정관리</li>
		<c:if test="${loginCorpInfo.c_type == 100 }">
			<li>상품 관리</li>
			<ul>
				<li>상품 관리</li>
				<li class="test"><a href="${pageContext.request.contextPath}/flight/scheduleManagerPage">일정 관리</a></li>
			</ul>
		</c:if>
		<c:if test="${loginCorpInfo.c_type == 200 }">
			<li>상품 관리</li>
			<ul>
				<li>상품 등록</li>
				<li>상품 목록</li>
			</ul>
		</c:if>
		<li>공지사항</li>
		<li>문의사항</li>
		<li></li>
	</ul>
</div>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->


