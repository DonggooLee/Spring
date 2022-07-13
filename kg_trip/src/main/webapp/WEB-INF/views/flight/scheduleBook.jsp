<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

	<section class="cont">
	
		<div class="searchBox">
		
			<h1>예약 조회</h1><br>
			
			<input type="text" name="checkBook">
			
			<br><br>
			
			<button id="mainBtn">메인페이지</button>
			&nbsp;
			<button id="bookBtn">예약조회</button>
			
		</div>
		
		<br><br>
		
		<div><table class="bookInfo"></table></div>
		
		<br>
		
		<div class="refund"></div>
		
		<br>
		
		<!-- 항공권 환불을 위한 임시 저장소 -->
		<form action="kakaoPayCancel" method="post" id="refundForm"></form>
			
	</section>

<style>

	tr, th, td{ 
		padding: 10px;
	}
	
</style>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 티켓 가격에 천단위 구분을 위한 함수
		function AmountCommas(val){
		    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
		}
		
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
						if (info.reservation_idx == undefined && info.flight_name == undefined || info.completion == "환불완료") {
							alert("존재하지 않는 예약번호 입니다")
							$(".searchBox").find("input[name='checkBook']").val("");
						}else{
							// 비행시간 형변환 후 formatting
							var start_date = new Date(info.start_date);
							const formatDate = (start_date)=>{
								let formatted_date = start_date.getFullYear() + "-0" + (start_date.getMonth() + 1) + "-" + start_date.getDate();
								return formatted_date;
							}
							str += "<tr><th colspan='2'>예약 정보</th></tr>";
							str += "<tr><th>성 명</th><td>" + info.m_name + "</td></tr>";
							str += "<tr><th>성 별</th><td>" + info.m_gender + "</td></tr>";
							str += "<tr><th>항공편명</th><td>" + info.flight_name + "</td></tr>";
							str += "<tr><th>결제가격</th><td>" + AmountCommas(info.ticket_price) + "원</td></tr>";
							str += "<tr><th>비행일자</th><td>" + formatDate(start_date) + "</td></tr>";
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
									$.ajax({
										type : 'get',
										url : '/flightManager/myReservation/' + reservation_idx,
										success : function(info) {
											console.log("통신 결과 : " + info)
											var str = '';
											str += "<input type='hidden' name='reservation_idx' value=" + reservation_idx + ">";
											str += "<input type='hidden' name='ticket_price' value=" + info.ticket_price + ">";
											str += "<input type='hidden' name='tid' value=" + info.tid + ">";
					 						$("#refundForm").html(str);		
					 						var ticket_price = $("#refundForm").find("input[name='ticket_price']").val();
					 						var tid = $("#refundForm").find("input[name='tid']").val();
					 						var param = {ticket_price:ticket_price, tid:tid, reservation_idx:reservation_idx}
					 						if(info != undefined){
						 						$.ajax({
						 							type : 'post',
						 							url : 'kakaoPayCancel',
						 							data : JSON.stringify(param),
						 							contentType : 'application/json; charset=utf-8',
						 							success : function() {
						 								alert("환불이 정상적으로 완료되었습니다!")
														location.href = "${pageContext.request.contextPath}/KingTrip/main";
													}
						 						}) // end : ajax() => 환불 쿼리 실행 후 메인페이지 이동
					 						}else{
					 							return;
					 						}
										}
									}) // end : ajax() => 예약번호를 통한 환불정보 가져오기
								}else{
									return;
								}
							}) // end : 환불하기 버튼 클릭 이벤트
						}
					}
				}) // end : ajax() => 예약번호를 통한 정보 가져오기
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