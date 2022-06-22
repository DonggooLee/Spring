<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<th>출발시간</th>
 				<th>도착시간</th>
				<th>출발공항</th>
				<th>도착공항</th>
				<th>티켓가격</th>
			</tr>
			<tr>
				<td>${getSchedule.date_idx }</td>
				<td>${getSchedule.flight_name }</td>
				<td>${getSchedule.start_date }</td>
				<td>${getSchedule.seat_grade }</td>
				<td>${getSchedule.depart_time }</td>
				<td>${getSchedule.arrive_time }</td>
				<td>${getSchedule.ap_name_s }</td>
				<td>${getSchedule.ap_name_d }</td>
				<td>${getSchedule.seat_price }</td>
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
					<input type="text" name="m_name">
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="text" name="m_gender">
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
					<input type="text" name="m_birth">
				</td>
			</tr>			
			<tr>
				<th>회원번호</th>
				<td>
					<input type="text" name="m_idx">
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="m_email">
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<input type="text" name="m_phone">
				</td>
			</tr>
		</table>
	</div>
	
	<hr>
	
	<h2>좌석 배정</h2>
	<div class="choiceSeat" style="border: 1px solid black; width: 800px; height: 200px; text-align: center;">
		<img name="seat" alt="좌석배정" src="/resources/images/airline_seat.png" style="margin-top: 90px;">
	</div>
	
	<form action="choiceSeat" method="post" id="myForm">
		<input type="hidden" name="date_idx" value="${getSchedule.date_idx }">
		<input type="hidden" name="seat_grade" value="${getSchedule.seat_grade }">
		<input type="hidden" name="flight_name" value="${getSchedule.flight_name }">
	</form>
	
</body>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 좌석 이미지 버튼 클릭 이벤트
		$(".choiceSeat").find("img[name='seat']").on("click", function() {
			
			$("#myForm").submit()
			
		}) // end : 좌석 이미지 버튼 클릭 이벤트 종료
		
	}) // end : onload
	
</script>
</html>