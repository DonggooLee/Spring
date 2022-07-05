<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont2">
	<div class="all" style="display: flex;">
		<jsp:include page="/WEB-INF/views/include/publicMenuBar.jsp"></jsp:include>
		<div class="content_section"
			style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
			<div class="content" style="margin: 10px; background-color: white;">
				<h2>${loginPublicInfo.m_name}님의 항공권 목록</h2>
				<div style="border: 1px solid black; padding: 10px; width: 60%;">
					<table style="background-color: white">
						<tr>
							<th>예약번호</th>
							<th>비행일자</th>
							<th>항공편명</th>
							<th>출발공항</th>
							<th>도착공항</th>
							<th>탑승시각</th>
							<th>출발시각</th>
							<th>도착시각</th>
							<th>좌석번호</th>
							<th>일정변경 / 환불</th>
						</tr>
						<c:choose>
							<c:when test="${not empty airBookList}">
								<c:forEach var="alist" items="${airBookList}">
									<tr>
										<td>${alist.reservation_idx}</td>
										<td>${alist.start_date}</td>
										<td>${alist.flight_name}</td>
										<td>${alist.ap_name_d}</td>
										<td>${alist.ap_name_a}</td>
										<td>${alist.boarding_time}</td>
										<td>${alist.depart_time}</td>
										<td>${alist.arrive_time}</td>
										<td>${alist.seat_name}</td>
										<td>
											<a class="t1" data-role="${alist.reservation_idx}">일정변경</a>
											/
											<a class="t2" data-role="${alist.reservation_idx}">환불</a>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<h2>예약된 항공권이 존재하지 않습니다.</h2>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">

	console.log("예약리스트 페이지 로그 테스트...")

	$(function() {
		 
		// 일정변경 버튼 클릭 이벤트
		$(".t1").on("click", function() {
			var a = $(this).attr('data-role')
			alert("일정변경 버튼 클릭 이벤트" + a)
		}) // end : 일정변경 버튼 클릭 이벤트
		
		// 환불 버튼 클릭 이벤트
		$(".t2").on("click", function() {
			var b = $(this).attr('data-role')
			alert("환불 버튼 클릭 이벤트" + b)
		}) // end : 환불 버튼 클릭 이벤트
		
	}) // end : onload

</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />