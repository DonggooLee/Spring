<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
	
	<section class="cont">
	
		<h1>예약이 완료되었습니다</h1>
		
		<br>
		
		<div>
			<h2 id="bookIdx"></h2>
			
			<br>
			
			<div class="bookInfo"></div>
		</div>
		
		<br>
		
		<div>
			<button id="mainBtn">메인페이지</button>
		</div>
		
		<br>
		
		<!-- 카카오 페이 결제 성공 시 예약확정을 위한 객체 -->
		<div id="Info">
			<input type="hidden" name="reservation_idx" value="${info.reservation_idx}">
			<input type="hidden" name="ticket_price" value="${info.ticket_price}">
			<input type="hidden" name="seat_name" value="${info.seat_name}">
			<input type="hidden" name="flight_name" value="${info.flight_name}">
			<input type="hidden" name="date_idx" value="${info.date_idx}">
			<input type="hidden" name="m_idx" value="${info.m_idx}">
			<input type="hidden" name="tid" value="${info.tid}">
		</div>
		
		<!-- 결제취소(환불)를 위한 객체 -->
		<form action="kakaoPayCancel" method="post" id="reservationCancelForm">
			<input type="hidden" name="reservation_idx" value="${info.reservation_idx}">
			<input type="hidden" name="ticket_price" value="${info.ticket_price}">
			<input type="hidden" name="tid" value="${info.tid}">
		</form>
		
	</section>

<style>

	tr, th, td{ 
		padding: 10px;
	}
	
</style>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">
	
	$(function() {
		
		// 예약을 위한 정보 저장
		var reservation_idx = $("#Info").find("input[name='reservation_idx']").val();
		var ticket_price = $("#Info").find("input[name='ticket_price']").val();
		var seat_name = $("#Info").find("input[name='seat_name']").val();
		var flight_name = $("#Info").find("input[name='flight_name']").val();
		var date_idx = $("#Info").find("input[name='date_idx']").val();
		var m_idx = $("#Info").find("input[name='m_idx']").val();
		var tid = $("#Info").find("input[name='tid']").val();
		
		console.log(ticket_price+"/"+seat_name+"/"+flight_name+"/"+date_idx+"/"+m_idx+"/"+tid+"/"+reservation_idx)
		
		var param = {ticket_price:ticket_price, seat_name:seat_name, flight_name:flight_name,
			date_idx:date_idx, m_idx:m_idx, tid:tid, reservation_idx:reservation_idx}
		
		// 티켓 가격에 천단위 구분을 위한 함수
		function AmountCommas(val){
		    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
		}
		
		// 항공권 예약확정
		$.ajax({
			type : 'post',
			url : '/flight/insertReservation',
			data : JSON.stringify(param), 
			contentType : 'application/json; charset=utf-8',
			success : function(result) {
				console.log("예약결과 : " + result);
				alert("예약이 정상적으로 완료되었습니다 :)")
				$.ajax({
					type : 'get',
					url : '/flightManager/myReservation/' + reservation_idx,
					success : function(info) {
						var start_date = new Date(info.start_date);
						const formatDate = (start_date)=>{
							let formatted_date = start_date.getFullYear() + "-0" + (start_date.getMonth() + 1) + "-" + start_date.getDate();
							return formatted_date;
						}
						var str = '';
						if(info != ""){ 	
							str += "<table style='padding: 20px; border: 1px solid black;'>";
							str += "<tr><th colspan='2'>예약 정보</th></tr>";
							str += "<tr><th>성 명</th><td>" + info.m_name + "</td></tr>";
							str += "<tr><th>성 별</th><td>" + info.m_gender + "</td></tr>";
							str += "<tr><th>예약정보</th><td>" + info.reservation_idx + "</td></tr>";
							str += "<tr><th>항공편명</th><td>" + info.flight_name + "</td></tr>";
							str += "<tr><th>결제가격</th><td>" + AmountCommas(ticket_price) + "원</td></tr>";
							str += "<tr><th>비행일자</th><td>" + formatDate(start_date) + "</td></tr>";
							str += "<tr><th>탑승시각</th><td>" + info.boarding_time + "</td></tr>";
							str += "<tr><th>출발시각</th><td>" + info.depart_time + "</td></tr>";
							str += "<tr><th>도착시각</th><td>" + info.arrive_time + "</td></tr>";
							str += "<tr><th>출발공항</th><td>" + info.ap_name_d + "</td></tr>";
							str += "<tr><th>도착공항</th><td>" + info.ap_name_a + "</td></tr>";
							str += "<tr><th>좌석번호</th><td>" + info.seat_name + "</td></tr>";
							str += "</table>";
							$(".bookInfo").html(str);
						}else{
							$(".bookInfo").html("<h1>정보가 존재하지 않습니다.</h1>");
						}
					}
				}) // end : 항공권 예약확정 시 예약번호를 통한 예약정보 출력
			}
		}) // end : 항공권 예약확정
		
		// 메인페이지 버튼 클릭 이벤트
		$("#mainBtn").on("click", function() {
			location.href = "${pageContext.request.contextPath}/KingTrip/main";
		}) // end : 메인페이지 버튼 클릭 이벤트
		
	}) // end : onload
	
</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>