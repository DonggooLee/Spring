<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	
	<div class="airlineInsert" style="border: 1px solid black; width: 300px;">
		<h1 style="text-align: center;">항공사 DB</h1>
		<div>
			<div>항공사 코드</div>
			<div><input type="text" name="air_code"></div>
		</div>
		<div>
			<div>항공사명</div>
			<div><input type="text" name="air_name"></div>
		</div>
		<div>
			<button id="airlineInsertBtn" type="button">항공사 추가</button>
		</div>
	</div>
	
	<hr>
	
	<div class="flightInsert" style="border: 1px solid black; width: 300px;">
		<h1 style="text-align: center;">비행기(항공편) DB</h1>
		<div>
			<div>항공편명</div>
			<div><input type="text" name="flight_name"></div>
		</div>
		<div>
			<div>탑승인원</div>
			<div><input type="text" name="flight_people"></div>
		</div>
		<div>
			<button id="flightInsertBtn" type="button">항공편 추가</button>
		</div>
	</div>
	
	<hr>
	
	<div class="seatInsert" style="border: 1px solid black; width: 300px;">
		<h1 style="text-align: center;">좌석 DB</h1>
		<div>
			<div>항공편명</div>
			<div>
				<select name="flight_name" class="selectFlight">
					<option>없음</option>
				</select>
			</div>
		</div>
		<div>
			<div>좌석등급</div>
			<div>
				<select name="seat_grade">
					<option value="FIRST">FIRST</option>
					<option value="BUSINESS">BUSINESS</option>
					<option value="ECONOMY">ECONOMY</option>
				</select>
			</div>
		</div>
		<div>
			<div>좌석이름</div>
			<div><input type="text" name="seat_name" placeholder="ex) 01"></div>
		</div>
		<div>
			<div>좌석가격</div>
			<div><input type="text" name="seat_price"></div>
		</div>
		<div><button id="seatInsertBtn" type="button">좌석추가</button></div>
	</div>
	
	<hr>
	
	<div class="scheduleInsert" style="border: 1px solid black; width: 300px;">
		<h1 style="text-align: center;">일정 DB</h1>
		<div>
			<div>항공편명</div>
			<div>
				<select name="flight_name" class="selectFlight">
					<option>없음</option>
				</select>
			</div>
		</div>
		<div>
			<div>항공사</div>
			<div>
				<select name="air_idx" class="selectAirline">
					<option>없음</option>
				</select>
			</div>
		</div>
		<div>
			<div>비행일자</div>
			<div><input type="date" name="start_date"></div>
		</div>
		<div>
			<div>탑승시각</div>
			<div><input type="time" name="boarding_time"></div>
		</div>
		<div>
			<div>출발시각</div>
			<div><input type="time" name="depart_time"></div>
		</div>
		<div>
			<div>도착시각</div>
			<div><input type="time" name="arrive_time"></div>
		</div>
		<div>
			<div>출발공항</div>
			<div>
				<select name="ap_idx_s" class="selectAirport_s">
					<option>없음</option>
				</select>
			</div>
		</div>
		<div>
			<div>도착공항</div>
			<div>
				<select name="ap_idx_d" class="selectAirport_d">
					<option>없음</option>
				</select>
			</div>
		</div>
		<div>
			<button id="scheduleInsertBtn" type="button">일정 추가</button>
		</div>
	</div>
	
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	console.log("테스트 로그...")

	$(function() {
		
		var select = $(".selectFlight");
		var selectAirline = $(".selectAirline");
		var selectAirport_s = $(".selectAirport_s");
		var selectAirport_d = $(".selectAirport_d");
		
		// 항공편 조회
		listFlight(function(list) {
			var str = '';
			if(list == null || list.length == 0){
				return;
			}else{
				for(var i=0; i<list.length; i++){
					str += "<option value=" + list[i].flight_name + ">" + list[i].flight_name + "</option>";
				}
				select.html(str)
			}
		})
		
		// 공항 조회
		listAirport(function(listAp) {
			var str = '';
			for(var i=0; i<listAp.length; i++){
				str += "<option value=" + listAp[i].ap_idx + ">" + listAp[i].ap_name_s + "</option>";
			}
			// 출발 공항
			selectAirport_s.html(str)
			// 도착 공항
			selectAirport_d.html(str)
		})
		
		// 항공사 조회
		listAirline(function(listAir) {
			var str = '';
			for(var i=0; i<listAir.length; i++){
				str += "<option value=" + listAir[i].air_idx + ">" + listAir[i].air_name + "</option>";
			}
			selectAirline.html(str)
		})
		
		// 항공사 추가 버튼 객체
		var airlineInsertBtn = $("#airlineInsertBtn")
		// 항공편 추가 버튼 객체
		var flightInsertBtn = $("#flightInsertBtn")
		// 좌석 추가 버튼 객체
		var seatInsertBtn = $("#seatInsertBtn")
		// 일정 추가 버튼 객체
		var scheduleInsertBtn = $("#scheduleInsertBtn")
		
		// 항공사 추가에 필요한 객체		
		var airline = $(".airlineInsert")
		var air_code = airline.find("input[name='air_code']");
		var air_name = airline.find("input[name='air_name']");
		
		// 항공편 추가에 필요한 객체
		var flight = $(".flightInsert")
		var flight_name_1 = flight.find("input[name='flight_name']");
		var flight_people = flight.find("input[name='flight_people']");
		
		// 좌석 추가에 필요한 객체
		var seat = $(".seatInsert")
		var flight_name_2 = seat.find("select[name='flight_name']");
		var seat_grade = seat.find("select[name='seat_grade']");
		var seat_name = seat.find("input[name='seat_name']");
		var seat_price = seat.find("input[name='seat_price']");
		
		// 일정 추가에 필요한 객체
		var schedule = $(".scheduleInsert")
		var flight_name_3 = schedule.find("select[name='flight_name']");
		var ap_idx_s = schedule.find("select[name='ap_idx_s']");
		var ap_idx_d = schedule.find("select[name='ap_idx_d']");
		var air_idx = schedule.find("select[name='air_idx']");
		var start_date = schedule.find("input[name='start_date']"); 
		var arrive_time = schedule.find("input[name='arrive_time']"); 
		var depart_time = schedule.find("input[name='depart_time']"); 
		var boarding_time = schedule.find("input[name='boarding_time']"); 
		
		// 항공사 추가 버튼 클릭 이벤트
		airlineInsertBtn.on("click", function() {
			airlineAdd({air_code:air_code.val(), air_name:air_name.val()},
					function(result) {
				alert("항공사 추가 결과 : " + result);
			})
		}) // end : 항공사 추가 버튼 클릭 이벤트 종료
		
		// 항공편 추가 버튼 클릭 이벤트	
		flightInsertBtn.on("click", function() {
			flightAdd({flight_name:flight_name_1.val(), flight_people:flight_people.val()},
					function(result) {
				alert("항공편 추가 결과 : " + result);		
			});
		}) // end : 항공편 추가 버튼 클릭 이벤트 종료
		
		// 좌석 추가 버튼 클릭 이벤트
		seatInsertBtn.on("click", function() {
			seatAdd({flight_name:flight_name_2.val(), seat_grade:seat_grade.val(), 
				seat_name:seat_name.val(), seat_price:seat_price.val(), seat_price:seat_price.val()},
					function(result) {
				alert("좌석 추가 결과 : " + result);		
			})
		}) // end : 좌석 추가 버튼 클릭 이벤트 종료
		
		// 일정 추가 버튼 클릭 이벤트
		scheduleInsertBtn.on("click", function() {
			schduleAdd({flight_name:flight_name_3.val() ,air_idx:air_idx.val(), start_date:start_date.val(), 
				ap_idx_s:ap_idx_s.val(), ap_idx_d:ap_idx_d.val(), depart_time:depart_time.val(), 
				boarding_time:boarding_time.val(), arrive_time: arrive_time.val()}, 
					function(result) {
				alert("일정 추가 결과 : " + result)
			})
		}) // end : 일정 추가 버튼 클릭 이벤트 종료
		
	}) // end : onload

</script>
</body>
</html>