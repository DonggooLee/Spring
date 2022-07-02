<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

	<div style="border: 1px solid black; width: 500px;" class="searchBox">
		<h3>예약조회</h3>
		<b>예매번호 =></b> <input type="text" name="checkBook"><br><br>
		<button id="bookBtn">예약조회</button>&nbsp;&nbsp;&nbsp;
		<button id="mainBtn">메인페이지</button>
	</div>
	
	<div>
		<table class="bookInfo"></table>
	</div>
	
</body>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		var bookInfo = $(".bookInfo")
		
		// 예약 조회 버튼 클릭 이벤트
		$("#bookBtn").on("click", function() {
			var reservation_idx = $(".searchBox").find("input[name='checkBook']").val()
			if(reservation_idx == ""){
				alert("예매번호를 입력하세요")
			}else{
				$.ajax({
					type : 'get',
					url : '/flightManager/myReservation/' + reservation_idx,
					success : function(result) {
						var str = '';
						str += "<h3> 예 약 정 보 </h3>";
						str += "<tr><th>예약번호</th><td>" + result.reservation_idx + "</td></tr>";
						str += "<tr><th>성명</th><td>" + result.m_name + "</td></tr>";
						str += "<tr><th>성별</th><td>" + result.m_gender + "</td></tr>";
						str += "<tr><th>항공편명</th><td>" + result.flight_name + "</td></tr>";
						str += "<tr><th>비행일자</th><td>" + displayTime(result.start_date) + "</td></tr>";
						str += "<tr><th>탑승시각</th><td>" + result.boarding_time + "</td></tr>";
						str += "<tr><th>출발시각</th><td>" + result.depart_time + "</td></tr>";
						str += "<tr><th>도착시각</th><td>" + result.arrive_time + "</td></tr>";
						str += "<tr><th>출발공항</th><td>" + result.ap_name_d + "</td></tr>";
						str += "<tr><th>도착공항</th><td>" + result.ap_name_a + "</td></tr>";
						str += "<tr><th>좌석번호</th><td>" + result.seat_name + "</td></tr>";
						$(".bookInfo").html(str)
					}
				})
			}
		}) // end : 예약 조회 버튼 클릭 이벤트
		
		// 메인페이지 버튼 클릭 이벤트
		$("#mainBtn").on("click", function() {
			
			location.href = "/KingTrip/main";
			
		}) // end : 메인페이지 버튼 클릭 이벤트
		
	}) // end : onload
	
</script>
</html>