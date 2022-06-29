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

	<h1>스케줄 조회 페이지 입니다</h1>
	
	<div class="getSchedule" style="border: 1px solid black; width: 300px;">
		<h1 style="text-align: center;">일정 조회</h1>
		<div>
			<div>비행일자</div>
			<div><input type="date" name="start_date"></div>
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
			<div>출발공항</div>
			<div>
				<select name="ap_name_d" class="selectAirport_d">
					<option>없음</option>
				</select>
			</div>
		</div>
		<div>
			<div>도착공항</div>
			<div>
				<select name="ap_name_a" class="selectAirport_a">
					<option>없음</option>
				</select>
			</div>
		</div>
		<div>
			<button id="getScheduleBtn">일정 조회</button>
		</div>
	</div>
	
	<hr>
	
	<div>
		<h1> 비행일정 </h1>
		<ul class="ul">
			<li>일정 없음</li>
		</ul>
	</div>
	
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	console.log("테스트 로그...")
	
	$(function() {
	
		// 일정 조회 버튼 객체
		var getScheduleBtn = $("#getScheduleBtn")

		// 일정 조회에 필요한 객체
		var getSchedule = $(".getSchedule");
		var start_date = getSchedule.find("input[name='start_date']");
		var seat_grade = getSchedule.find("select[name='seat_grade']");
		
		// 공항 조회에 필요한 객체
		var selectAirport_d = $(".selectAirport_d");
		var selectAirport_a = $(".selectAirport_a");
		var ap_name_d = getSchedule.find("select[name='ap_name_d']");
		var ap_name_a = getSchedule.find("select[name='ap_name_a']");
		
		// 공항 조회
		listAirport(function(listAp) {
			var str_1 = '';
			var str_2 = '';
			for(var i=0; i<listAp.length; i++){
				str_1 += "<option value=" + listAp[i].ap_name_d + ">" + listAp[i].ap_name_d + "</option>";
				str_2 += "<option value=" + listAp[i].ap_name_a + ">" + listAp[i].ap_name_a + "</option>";
			}
			// 출발 공항
			selectAirport_d.html(str_1)
			// 도착 공항
			selectAirport_a.html(str_2)
		})
		
		// 일정 조회 버튼 클릭 이벤트
		getScheduleBtn.on("click", function() {
			var str = '';
			if (seat_grade.val() == "FIRST") {
				listScheduleFir({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val() }, 
						function(listSch) {
							for(var i=0; i<listSch.length; i++){
								str += "<li> 비행일자 : " + displayTime(listSch[i].start_date) + "</li>";
								str += "<li> 항공편명 : " + listSch[i].flight_name + "</li>";
								str += "<li> 출발공항 : " + listSch[i].ap_name_d + "</li>";
								str += "<li> 도착공항 : " + listSch[i].ap_name_a + "</li>";
								str += "<li> 항공사명 : " + listSch[i].c_name + "</li>";
								str += "<li> 좌석가격 : " + listSch[i].firstseatprice + "</li>";
								str += "<li> 탑승시각 : " + listSch[i].boarding_time + "</li>";
								str += "<li> 출발시각 : " + listSch[i].depart_time + "</li>";
								str += "<li> 도착시각 : " + listSch[i].arrive_time + "</li>";
								str += "<button id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">일정 선택</button>";
								str += "<hr>"
							}
						$(".ul").html(str)
						// 일정 선택 버튼 클릭 이벤트
						$(".ul button").on("click", function() {
							// 일정번호
							var date_idx = $(this).data("idx");
							// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
							location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=FIRST";
							console.log(date_idx)
						})
				}) // end : 퍼스트 좌석 선택 일정
			} else if (seat_grade.val() == "BUSINESS") {
				listScheduleBis({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val() }, 
						function(listSch) {
							for(var i=0; i<listSch.length; i++){
								str += "<li> 비행일자 : " + displayTime(listSch[i].start_date) + "</li>";
								str += "<li> 항공편명 : " + listSch[i].flight_name + "</li>";
								str += "<li> 출발공항 : " + listSch[i].ap_name_d + "</li>";
								str += "<li> 도착공항 : " + listSch[i].ap_name_a + "</li>";
								str += "<li> 항공사명 : " + listSch[i].c_name + "</li>";
								str += "<li> 좌석가격 : " + listSch[i].businessseatprice + "</li>";
								str += "<li> 탑승시각 : " + listSch[i].boarding_time + "</li>";
								str += "<li> 출발시각 : " + listSch[i].depart_time + "</li>";
								str += "<li> 도착시각 : " + listSch[i].arrive_time + "</li>";
								str += "<button id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">일정 선택</button>";
								str += "<hr>"
							}
						$(".ul").html(str)
						// 일정 선택 버튼 클릭 이벤트
						$(".ul button").on("click", function() {
							// 일정번호
							var date_idx = $(this).data("idx");
							// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
							location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=BUSINESS";
							console.log(date_idx)
						})
				}) // end : 비즈니스 좌석 선택 일정
			} else{
				listScheduleEco({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val() }, 
						function(listSch) {
							for(var i=0; i<listSch.length; i++){
								str += "<li> 비행일자 : " + displayTime(listSch[i].start_date) + "</li>";
								str += "<li> 항공편명 : " + listSch[i].flight_name + "</li>";
								str += "<li> 출발공항 : " + listSch[i].ap_name_d + "</li>";
								str += "<li> 도착공항 : " + listSch[i].ap_name_a + "</li>";
								str += "<li> 항공사명 : " + listSch[i].c_name + "</li>";
								str += "<li> 좌석가격 : " + listSch[i].economyseatprice + "</li>";
								str += "<li> 탑승시각 : " + listSch[i].boarding_time + "</li>";
								str += "<li> 출발시각 : " + listSch[i].depart_time + "</li>";
								str += "<li> 도착시각 : " + listSch[i].arrive_time + "</li>";
								str += "<button id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">일정 선택</button>";
								str += "<hr>"
							}
						$(".ul").html(str)
						// 일정 선택 버튼 클릭 이벤트
						$(".ul button").on("click", function() {
							// 일정번호
							var date_idx = $(this).data("idx");
							// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
							location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=ECONOMY";;
							console.log(date_idx)
						})
				}) // end : 이코노미 좌석 선택 일정
			}
		}) // end : 일정 조회 버튼 클릭 이벤트 종료
		
	}) // end : onload
	
</script>
</body>
</html>