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
				</td>
			</tr>
		</table>
	</div>

	<div class="hidden">
		<!-- 좌석 등급 스크립트 처리하기 위함 -->
		<input type="hidden" name="seat_grade" value="${seat_grade}">
		<input type="hidden" name="date_idx" value="${getSchedule.date_idx}">
	</div>
	
	<hr>
	
	<h2>좌석 배정</h2>
	<div class="choiceSeat" style="border: 1px solid black; width: 800px; height: 200px; text-align: center;">
		테스트
	</div>
	
</body>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 좌석정보 얻기 위한 객체
		var seat_grade = $(".hidden").find("input[name='seat_grade']")
		var date_idx = $(".hidden").find("input[name='date_idx']")

		// 좌석정보 불러오기
		getSeatList({seat_grade:seat_grade.val(), date_idx:date_idx.val()},
				function(seat) {
			if(seat.businessseat == null){
				console.log("비즈니스 널 값")
			}
			if(seat.economyseat == null) {
				console.log("이코노미 널 값")
			}
			if(seat.firstseat == null){
				console.log("퍼스트 널 값")
			}
			console.log(seat)
			var test = seat.businessseat;
			console.log("^^^^^^변수에 담은 값 : " + test)
			var split_test = test.split(',')
			console.log("잘라버린값 : " + split_test[0])
			
		})
		
	}) // end : onload
	
</script>
</html>