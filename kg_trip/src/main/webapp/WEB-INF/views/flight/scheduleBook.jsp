<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

	<section class="cont">
	
		<div class="searchBox">
			<h1>예약 조회</h1><br>
			<input type="text" name="checkBook" value="20220703P456789"><br><br>
			<button id="mainBtn">메인페이지</button>
			&nbsp;
			<button id="bookBtn">예약조회</button>
		</div>
		
		<br><br>
		
		<div><table class="bookInfo"></table></div>
		<br>
		<div class="refund"></div>
			
	</section>
	
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		var bookInfo = $(".bookInfo");
		
		// 예약 조회 버튼 클릭 이벤트
		$("#bookBtn").on("click", function() {
			var reservation_idx = $(".searchBox").find("input[name='checkBook']").val();
			// 예약번호 유무에 따른 예외처리
			if(reservation_idx == ""){
				alert("예약번호를 입력해 주세요");
			}else{
				$.ajax({
					type : 'get',
					url : '/flightManager/myReservation/' + reservation_idx,
					success : function(info) {
						var str = '';
						if (info.reservation_idx == undefined && info.flight_name == undefined) {
							alert("존재하지 않는 예약번호 입니다")
							$(".searchBox").find("input[name='checkBook']").val("");
						}else{
							str += "<tr><th colspan='2'>예약 정보</th></tr>";
							str += "<tr><th>성 명</th><td>" + info.m_name + "</td></tr>";
							str += "<tr><th>성 별</th><td>" + info.m_gender + "</td></tr>";
							str += "<tr><th>항공편명</th><td>" + info.flight_name + "</td></tr>";
							str += "<tr><th>비행일자</th><td>" + displayTime(info.start_date) + "</td></tr>";
							str += "<tr><th>탑승시각</th><td>" + info.boarding_time + "</td></tr>";
							str += "<tr><th>출발시각</th><td>" + info.depart_time + "</td></tr>";
							str += "<tr><th>도착시각</th><td>" + info.arrive_time + "</td></tr>";
							str += "<tr><th>출발공항</th><td>" + info.ap_name_d + "</td></tr>";
							str += "<tr><th>도착공항</th><td>" + info.ap_name_a + "</td></tr>";
							str += "<tr><th>좌석번호</th><td>" + info.seat_name + "</td></tr>";
							$(".bookInfo").html(str)
							$(".refund").html("<button id='refundBtn'>항공권 환불</button>")
							// 환불하기 버튼 클릭 이벤트
							$("#refundBtn").on("click", function() {
								if(confirm("정말 환불하시겠습니까?")){
									// 확인 클릭 시 : 항공권 환불
									refundReservation(reservation_idx, function(result) {
										if(result == "success"){
											alert("환불이 정상적으로 완료됐습니다.")
											location.href = "/KingTrip/main";
										}else{
											alert("삭제에 실패 하였습니다.")
											return;
										}
									})
								}else{
									// 취소 클릭 시
									return;
								}
							}) // end : 환불하기 버튼 클릭 이벤트
						}
					}
				}) // end : ajax()
			}
		}) // end : 예약 조회 버튼 클릭 이벤트
		
		// 메인페이지 버튼 클릭 이벤트
		$("#mainBtn").on("click", function() {
			location.href = "/KingTrip/main";
		}) // end : 메인페이지 버튼 클릭 이벤트
		
	}) // end : onload
	
</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>