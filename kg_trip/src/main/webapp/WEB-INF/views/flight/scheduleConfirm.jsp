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
				<th>티켓가격</th>
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
				<td id="ticketPrice"></td>
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

	<hr>
	
	<h2>좌석 배정</h2>
	<div class="choiceSeat" style="border: 1px solid black; width: 800px; height: 500px; text-align: center;"></div>
	
	<br>
	
	<div class="reservation">
		<button>예약하기</button>
	</div>
	
	<div class="hidden">
		<!-- 선택한 등급에 따른 좌석을 보여주기 위함 -->
		<input type="hidden" name="seat_grade" value="${seat_grade}">
		<input type="hidden" name="date_idx" value="${getSchedule.date_idx}">
	</div>
	
	<form action="reservation" method="post" id="myForm">
		<input type="hidden" name="date_idx" value="${getSchedule.date_idx}">
		<input type="hidden" name="flight_name" value="${getSchedule.flight_name}">
		<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}">
	</form>
	
</body>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		
		// 좌석정보 얻기 위한 객체
		var seat_grade = $(".hidden").find("input[name='seat_grade']")
		var date_idx = $(".hidden").find("input[name='date_idx']")
		var div = $(".choiceSeat")
		
		// 항공권 예매를 위한 객체
		var bookInfo_ = '';
		var bookInfo = {};
		var m_idx = $("#myForm").find("input[name='m_idx']")
		var flight_name = $("#myForm").find("input[name='flight_name']")
		var passport_num = $(".memberInfo").find("input[name='passport_num']")
		
		
		// 해당 항공편의 좌석정보 출력
		getSeatList({seat_grade:seat_grade.val(), date_idx:date_idx.val()},
				function(seat) {
			
			// 이미 선택된 좌석정보
			getReservationSeatList({flight_name:flight_name.val(), date_idx:date_idx.val()}, 
					function(seatList) {
				
				// 이코노미석 선택할 시
				if(seat.economyseat != null) {
					var pEs = seat.economyseatprice
					$("#ticketPrice").html(pEs)
					var es = seat.economyseat
					var split_es = es.split(',')
					var str = '';
					for(var i=0; i<split_es.length; i++){
						console.log("기본값 : " + split_es[i])
						console.log("기본값 : " + seatList[i].seat_name)
						for (var j=0; j<seatList.length; i++) {
							if(split_es[i] == seatList[j].seat_name ) {
								console.log("중복값 : " + split_es[i])
							}else{
								console.log("중복아닌 값 : " + split_es[i])													
							}
						}
						//console.log("항공기 좌석 리스트 : " + split_es[i])
						//console.log("이미 예약된 좌석 리스트 : " + seatList[i].seat_name)
						//str += "<button style='padding: 15px; background-color: white; margin: 5px;' id=seat_es data-idx="+split_es[i]+">" + split_es[i] + "</button>"
					}
					div.html(str)
					$(".choiceSeat button").on("click", function() {
						var seat_es = $(this).data("idx")
						alert("선택한 좌석 번호 : " + seat_es)
						bookInfo_ += "<input type='text' name='ticket_price' value=" + pEs + ">"
						bookInfo_ += "<input type='text' name='seat_name' value=" + seat_es + ">"
						bookInfo_ += "<input type='text' name='passport_num' value=" + passport_num.val() + ">"
						$("#myForm").append(bookInfo_)
						/* 
						테스트 데이터! 
						bookInfo = {date_idx:date_idx.val(), flight_name:flight_name.val(), m_idx:m_idx.val(), 
							ticket_price:pEs, seat_name:seat_es, passport_num:passport_num.val()}
						console.log(bookInfo.date_idx)
						console.log(bookInfo.flight_name)
						console.log(bookInfo.m_idx)
						console.log(bookInfo.ticket_price)
						console.log(bookInfo.seat_name)
						console.log(bookInfo.passport_num)
						*/
					})
				}
			
			}) // end : 이미 선택된 좌석정보
			
			
			// 비즈니스석 선택할 시
			if(seat.businessseat != null){
				var pBs = seat.businessseatprice
				$("#ticketPrice").html(pBs)
				var bs = seat.businessseat
				var split_bs = bs.split(',')
				var str = '';
				for(var i=0; i<split_bs.length; i++){
					str += "<button style='padding: 15px; background-color: white; margin: 5px;' id=seat_es data-idx="+split_bs[i]+">" + split_bs[i] + "</button>"
				}
				div.html(str)
				$(".choiceSeat button").on("click", function() {
					var seat_bs = $(this).data("idx")
					alert("선택한 좌석 번호 : " + seat_bs)
					bookInfo_ += "<input type='text' name='ticket_price' value=" + pBs + ">"
					bookInfo_ += "<input type='text' name='seat_name' value=" + seat_bs + ">"
					bookInfo_ += "<input type='text' name='passport_num' value=" + passport_num.val() + ">"
					$("#myForm").append(bookInfo_)
					/* 테스트 데이터! */
					bookInfo = {date_idx:date_idx.val(), flight_name:flight_name.val(), m_idx:m_idx.val(), 
						ticket_price:pBs, seat_name:seat_bs, passport_num:passport_num.val()}
					console.log(bookInfo.date_idx)
					console.log(bookInfo.flight_name)
					console.log(bookInfo.m_idx)
					console.log(bookInfo.ticket_price)
					console.log(bookInfo.seat_name)
					console.log(bookInfo.passport_num)
				})
			}
			// 퍼스트석 선택할 시
			if(seat.firstseat != null){
				var pFs = seat.firstseatprice
				$("#ticketPrice").html(pFs)
				var fs = seat.firstseat
				var split_fs = fs.split(',')
				var str = '';
				for(var i=0; i<split_fs.length; i++){
					str += "<button style='padding: 15px; background-color: white; margin: 5px;' id=seat_es data-idx="+split_fs[i]+">" + split_fs[i] + "</button>"
				}
				div.html(str)
				$(".choiceSeat button").on("click", function() {
					var seat_fs = $(this).data("idx")
					alert("선택한 좌석 번호 : " + seat_fs)
					bookInfo_ += "<input type='text' name='ticket_price' value=" + pFs + ">"
					bookInfo_ += "<input type='text' name='seat_name' value=" + seat_fs + ">"
					bookInfo_ += "<input type='text' name='passport_num' value=" + passport_num.val() + ">"
					$("#myForm").append(bookInfo_)
					/* 테스트 데이터! */
					bookInfo = {date_idx:date_idx.val(), flight_name:flight_name.val(), m_idx:m_idx.val(), 
						ticket_price:pFs, seat_name:seat_fs, passport_num:passport_num.val()}
					console.log(bookInfo.date_idx)
					console.log(bookInfo.flight_name)
					console.log(bookInfo.m_idx)
					console.log(bookInfo.ticket_price)
					console.log(bookInfo.seat_name)
					console.log(bookInfo.passport_num)
				})
			}
		}) // end : 해당 항공편의 좌석정보 출력
		
		
		// 예약하기 버튼 클릭
		$(".reservation button").on("click", function() {
			
			// 각 종 정보들이 있는지 없는 예외 처리 하기
			$("#myForm").submit()
			
		}) // end : 예약하기 버튼
		
		
	}) // end : onload
	
</script>
</html>