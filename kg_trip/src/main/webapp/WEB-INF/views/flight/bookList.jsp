<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont2">

	<div class="all" style="display: flex;">
		<jsp:include page="/WEB-INF/views/include/publicMenuBar.jsp"></jsp:include>
		<div class="content_section" style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
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
							<th>예약상태</th>
							<th>환불</th>
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
										<td>${alist.completion}</td>
										<td><a class="refundBtn" data-role="${alist.reservation_idx}">환불</a></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<h1>예약된 항공권이 존재하지 않습니다.</h1>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<!-- 항공권 환불을 위한 임시 저장소 -->
				<form action="kakaoPayCancel" method="post" id="refundForm"></form>
				<!-- 시간 값 수정을 위한 임시 저장소 -->
				<form action="#" id="tempForm">
					<input type="hidden" name="start_date" value="${alist.start_date}">
				</form>
			</div>
		</div>
	</div>
	
</section>

<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 시간값 변경을 위한 객체 생성
		var start_date = $("#tempForm").find("input[name='start_date']").val();
		console.log(start_date)
		 
		// 환불 버튼 클릭 이벤트
		$(".refundBtn").on("click", function() {
			var reservation_idx = $(this).attr('data-role')
			if(confirm("정말 환불하시겠습니까?")){
				$.ajax({
					type : 'get',
					url : '/flightManager/myReservation/' + reservation_idx,
					success : function(info) {
						console.log( "비동기 통신 결과 : "  + info)
						var str = '';
						str += "<input type='hidden' name='reservation_idx' value=" + reservation_idx + ">";
						str += "<input type='hidden' name='ticket_price' value=" + info.ticket_price + ">";
						str += "<input type='hidden' name='tid' value=" + info.tid + ">";
 						$("#refundForm").html(str);		
						$("#refundForm").submit();
					}
				})
			}else{
				return;
			}
		}) // end : 환불 버튼 클릭 이벤트
		
	}) // end : onload

</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />