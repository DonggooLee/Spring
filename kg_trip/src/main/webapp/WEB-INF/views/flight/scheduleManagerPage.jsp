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
	
	<br>
	
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
	
	<br>
	
	<div class="seatInsert" style="border: 1px solid black; width: 300px;">
		<h1 style="text-align: center;">좌석 DB</h1>
		<div>
			<div>항공편명</div>
			<div><input type="text" name="flight_name"></div>
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
	
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	console.log("로그테스트...")

	$(function() {
		
		// 항공사 추가 버튼 객체
		var airlineInsertBtn = $("#airlineInsertBtn")
		// 항공편 추가 버튼 객체
		var flightInsertBtn = $("#flightInsertBtn")
		// 좌석 추가 버튼 객체
		var seatInsertBtn = $("#seatInsertBtn")
		
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
		var flight_name_2 = seat.find("input[name='flight_name']");
		var seat_grade = seat.find("select[name='seat_grade']");
		var seat_name = seat.find("input[name='seat_name']");
		var seat_price = seat.find("input[name='seat_price']"); 
		
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
			})
		}) // end : 항공편 추가 버튼 클릭 이벤트 종료
		
		
		// 좌석 추가 버튼 클릭 이벤트
		seatInsertBtn.on("click", function() {
			seatAdd({flight_name:flight_name_2.val(), seat_grade:seat_grade.val(), 
				seat_name:seat_name.val(), seat_price:seat_price.val(), seat_price:seat_price.val()},
					function(result) {
				alert("좌석 추가 결과 : " + result);		
			})
		}) // end : 좌석 추가 버튼 클릭 이벤트 종료
		
	}) // end : onload

</script>
</body>
</html>