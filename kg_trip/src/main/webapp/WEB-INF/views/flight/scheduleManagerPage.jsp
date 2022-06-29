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
			<div>${loginCorpInfo.c_name}</div>
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
				<select name="ap_idx_d" class="selectAirport_d">
					<option>없음</option>
				</select>
			</div>
		</div>
		<div>
			<div>도착공항</div>
			<div>
				<select name="ap_idx_a" class="selectAirport_a">
					<option>없음</option>
				</select>
			</div>
		</div>
		<div>
			<button id="scheduleInsertBtn" type="button">일정 추가</button>
		</div>
		<input type="hidden" name="c_aircode" value="${loginCorpInfo.c_aircode}">
	</div>
	
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	console.log("테스트 로그...")

	$(function() {
		
		// 항공편 조회에 필요한 객체
		var c_aircode = $(".scheduleInsert").find("input[name='c_aircode']").val();
		var selectFlight = $(".selectFlight");
		
		// 공항 조회에 필요한 객체
		var selectAirport_d = $(".selectAirport_d");
		var selectAirport_a = $(".selectAirport_a");
		
		// 항공편 조회 (관리자 계정의 항공사 코드와 일치하는 항공편만 출력)
		listFlight(c_aircode, function(listFlight) {
			console.log(listFlight)
			var str = '';
			if(listFlight.length != 0){
				for(var i=0; i<listFlight.length; i++){
					str += "<option value=" + listFlight[i].flight_name + ">" + listFlight[i].flight_name + "</option>";
				}
				selectFlight.html(str)
			}else{
				selectFlight.html("<option>없음</option>")
			}
		})
		
		// 공항 조회
		listAirport(function(listAp) {
			var str = '';
			for(var i=0; i<listAp.length; i++){
				str += "<option value=" + listAp[i].ap_idx + ">" + listAp[i].ap_name_d + "</option>";
			}
			// 출발 공항
			selectAirport_d.html(str)
			// 도착 공항
			selectAirport_a.html(str)
		})
		
		// 일정 추가 버튼 객체
		var scheduleInsertBtn = $("#scheduleInsertBtn")
		
		// 일정 추가에 필요한 객체
		var schedule = $(".scheduleInsert")
		var flight_name = schedule.find("select[name='flight_name']");
		var start_date = schedule.find("input[name='start_date']"); 
		var depart_time = schedule.find("input[name='depart_time']"); 
		var arrive_time = schedule.find("input[name='arrive_time']"); 
		var boarding_time = schedule.find("input[name='boarding_time']"); 
		var ap_idx_d = schedule.find("select[name='ap_idx_d']");
		var ap_idx_a = schedule.find("select[name='ap_idx_a']");

		// 일정 추가 버튼 클릭 이벤트
		scheduleInsertBtn.on("click", function() {
			insertSchedule({flight_name:flight_name.val(), start_date:start_date.val(), boarding_time:boarding_time.val(),
				depart_time:depart_time.val(), arrive_time:arrive_time.val(), ap_idx_d:ap_idx_d.val(), ap_idx_a:ap_idx_a.val()}, 
				function(result) {
					alert("일정 추가 결과 : " + result)
			})
		}) // end : 일정 추가 버튼 클릭 이벤트 종료
		
	}) // end : onload

</script>
</body>
</html>