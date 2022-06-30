<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	
	<h2>여정 정보</h2>
	<div class="scheduleInfo" style="border: 1px solid black; width: 800px; height: 80px;">
		<table>
			<tr>
				<th>일정번호</th>
				<th>항공편명</th>
				<th>비행일자</th>
				<th>좌석등급</th>
				<th>탑승시각</th>
				<th>출발시간</th>
 				<th>도착시간</th>
				<th>출발공항</th>
				<th>도착공항</th>
			</tr>
			<tr>
				<td>${getSchedule.date_idx }</td>
				<td>${getSchedule.flight_name }</td>
				<td>${getSchedule.start_date }</td>
				<td>${seat_grade }</td>
				<td>${getSchedule.boarding_time }</td>
				<td>${getSchedule.depart_time }</td>
				<td>${getSchedule.arrive_time }</td>
				<td>${getSchedule.ap_name_d }</td>
				<td>${getSchedule.ap_name_a }</td>
				<input type="hidden" name="date_idx" value="${loginPublicInfo.m_idx}">
				<input type="hidden" name="flight_name" value="${loginPublicInfo.m_idx}">
				<input type="hidden" name="ticket_price" value="${loginSpecial.m}">
				<input type="hidden" name="passport_num" value="${loginPublicInfo.m_idx}">
			</tr>
		</table>
	</div>
	
	<hr>
	
	<h2>승객 정보</h2>
	<div class="memberInfo">
		<table>
			<tr>
				<th>승객이름</th>
				<td>
					<input type="text" name="m_name" value="${loginPublicInfo.m_name}">
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="text" name="m_gender" value="${loginPublicInfo.m_gender}">
				</td>
			</tr>
			<tr>
				<th>국적</th>
				<td>
					<input type="text" name="m_gender">
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="text" name="m_birth" value="${loginPublicInfo.m_birth}">
				</td>
			</tr>			
			<tr>
				<th>회원번호</th>
				<td>
					<input type="text" name="m_idx" value="${loginPublicInfo.m_id}">
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="m_email" value="${loginPublicInfo.m_email}">
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<input type="text" name="m_phone" value="${loginPublicInfo.m_phone}">
				</td>
			</tr>
			<tr>
				<th>여권번호</th>
				<td>
					<input type="text" name="passport_num">
					<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}">
					
				</td>
			</tr>
		</table>
	</div>

	<hr>
	
	<h2>좌석 배정</h2>
	<div class="choiceSeat" style="border: 1px solid black; width: 800px; height: 500px; text-align: center;"></div>
	
	<br>
	
	<div class="reservation">
		<button>예약하기</button>
	</div>
	
	<div class="hidden">
		<!-- 좌석 등급 스크립트 처리하기 위함 -->
		<input type="hidden" name="seat_grade" value="${seat_grade}">
		<input type="hidden" name="date_idx" value="${getSchedule.date_idx}">
	</div>
	
</body>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 항공권 예매를 위한 객체
		var memberInfo = $(".memberInfo")
		
		// 좌석정보 얻기 위한 객체
		var seat_grade = $(".hidden").find("input[name='seat_grade']")
		var date_idx = $(".hidden").find("input[name='date_idx']")
		var div = $(".choiceSeat")

		// 해당 항공편의 좌석정보 출력
		getSeatList({seat_grade:seat_grade.val(), date_idx:date_idx.val()},
				function(seat) {
			if(seat.economyseat != null) {
				var es = seat.economyseat
				var split_es = es.split(',')
				var str = '';
				for(var i=0; i<split_es.length; i++){
					str += "<button style='padding: 15px; background-color: white; margin: 5px;' id=seat_es data-idx="+split_es[i]+">" + split_es[i] + "</button>"
				}
				div.html(str)
				$(".choiceSeat button").on("click", function() {
					var seat_es = $(this).data("idx")
					alert(seat_es)
					console.log(seat_es)
				})
			}
			if(seat.businessseat != null){
				var bs = seat.businessseat
				var split_bs = bs.split(',')
				var str = '';
				for(var i=0; i<split_bs.length; i++){
					str += "<button style='padding: 15px; background-color: white; margin: 5px;' id=seat_es data-idx="+split_bs[i]+">" + split_bs[i] + "</button>"
				}
				div.html(str)
				$(".choiceSeat button").on("click", function() {
					var seat_bs = $(this).data("idx")
					alert(seat_bs)
					console.log(seat_bs)
				})
			}
			if(seat.firstseat != null){
				var fs = seat.firstseat
				var split_fs = fs.split(',')
				var str = '';
				for(var i=0; i<split_fs.length; i++){
					str += "<button style='padding: 15px; background-color: white; margin: 5px;' id=seat_es data-idx="+split_fs[i]+">" + split_fs[i] + "</button>"
				}
				div.html(str)
				$(".choiceSeat button").on("click", function() {
					var seat_fs = $(this).data("idx")
					alert(seat_fs)
					console.log(seat_fs)
				})
			}
		}) // end : 좌석정보 출력
		
		// 예약하기 버튼 클릭
		$(".reservation button").on("click", function() {
			
			alert("버튼 클릭 테스트 !")
			
		}) // end : 예약하기 버튼
		
	}) // end : onload
	
</script>
</html>