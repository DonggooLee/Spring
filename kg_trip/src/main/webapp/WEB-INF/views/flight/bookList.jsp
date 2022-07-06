<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
											<a class="changeBtn" data-role="${alist.reservation_idx}">일정변경</a>
											/
											<a class="refundBtn" data-role="${alist.reservation_idx}">환불</a>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<h1>예약된 항공권이 존재하지 않습니다.</h1>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
			</div>
		</div>
	</div>
</section>

<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	console.log("예약리스트 페이지 로그 테스트...")

	$(function() {
		 
		// 일정변경 버튼 클릭 이벤트
		$(".changeBtn").on("click", function() {
			var reservation_idx = $(this).attr('data-role')
			alert("일정변경 버튼 클릭 이벤트 : " + reservation_idx)
		}) // end : 일정변경 버튼 클릭 이벤트
		
		// 환불 버튼 클릭 이벤트
		$(".refundBtn").on("click", function() {
			var reservation_idx = $(this).attr('data-role')
			if(confirm("정말 환불하시겠습니까?")){
				// 확인 클릭 시 : 항공권 환불
				refundReservation(reservation_idx, function(result) {
					if(result == "success"){
						alert("환불이 정상적으로 처리되었습니다.")
						location.href = "${pageContext.request.contextPath}/flight/bookList"
					}else{
						alert("환불에 실패했습니다.")
						return;
					}
				}) // end : 항공권 환불
			}else{
				// 취소 클릭 시
				return;
			}
		}) // end : 환불 버튼 클릭 이벤트
		
	}) // end : onload

</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />