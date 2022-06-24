<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont">

	<h1><c:if test="${not empty loginPublicInfo }">${loginPublicInfo.m_id}</c:if> 마이페이지 </h1>
	<h1><c:if test="${empty loginPublicInfo }">실패했음</c:if> 마이페이지 </h1>
	

</section>

<script type="text/javascript">

</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



