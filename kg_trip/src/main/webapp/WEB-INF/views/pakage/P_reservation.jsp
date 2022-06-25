<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<style type="text/css">
	.center-middle{
		width : 900px;
		background-color: white;
		height : auto;
	}

</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="cont">
			<div class="center">
				<form action="/pakage/P_preservation" method="post" role="form">
					<h1>결제하기</h1>
					<div class="center-middle">
						<img alt="이미지" src="/resources/images/${board.p_mainimg }" width="250px"><br>
						<c:out value="${board.p_name}"></c:out><br>
						<input type="hidden" name="p_name" value="${board.p_name}" >
						<input type="hidden" name="p_num" value="${board.p_num}" >
						여행일 : <input type="text" name="p_period" value="${board.p_period}" readonly="readonly"><br>
						금액 : <input type="text" name="p_fee" value="${board.p_fee}" readonly="readonly"> X <c:out value="${p_rpeople}"/>인<input type="hidden" name="p_rpeople" value="${p_rpeople}" ><br>
						총 금액 : <input type="text" name="p_totalfee" value="${p_totalfee}" readonly="readonly">원
					</div>
					<div class="center-middle">
						<h3>예약자 정보</h3>
						<input type="hidden" name="m_id" value="${loginPublicInfo.m_id}" >
						<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}" >
						예약자 이름<br>
						<input type="text" name="m_name" value="${loginPublicInfo.m_name}"><br>
						이메일주소<br>
						<input type="text" name="m_email" value="${loginPublicInfo.m_email}"><br>
						휴대전화번호<br>
						<input type="text" name="m_phone" value="${loginPublicInfo.m_phone}"><br>
					</div>
					<div class="center-middle">
							<h3>결제 방법</h3>
							<input type="radio" name="kakao" value="kakao">카카오페이<br>
							<h3>약관 및 안내</h3>
							<input type="checkbox" name="agree" value="1"> 전체 약관 동의<br>
							<input type="checkbox" name="agree" value="2"> 여행자 약관(필수)<br>
							<input type="checkbox" name="agree" value="3"> 개인정보 수집 및 이용 동의(필수)<br>
							<input type="checkbox" name="agree" value="4"> 개인정보 제공 동의(필수)<br>
							<br><br>
							<button data-oper="P_preservation" ><c:out value="${p_totalfee}"></c:out>원 결제하기</button>
					</div>
				</form>
			</div>
		</section>
		
<script type="text/javascript">


</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>