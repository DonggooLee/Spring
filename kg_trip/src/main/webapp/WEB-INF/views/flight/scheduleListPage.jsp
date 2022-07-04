<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
	
	<section class="cont">

		<div class="getSchedule" style="border: 1px solid black; width: 300px; padding: 25px;">
			<h1 style="text-align: center;">일정 조회</h1>
			<br>
			<div>
				<div>
					<b>비행일자</b>&nbsp;&nbsp;
					<input type="date" name="start_date">
				</div>
			</div>
			<br>
			<div>
				<div>
					<b>좌석등급</b>&nbsp;&nbsp;
					<select name="seat_grade">
						<option value="FIRST">FIRST</option>
						<option value="BUSINESS">BUSINESS</option>
						<option value="ECONOMY">ECONOMY</option>
					</select>
				</div>
			</div>
			<br>
			<div>
				<div>
					<b>출발공항</b>&nbsp;&nbsp;
					<select name="ap_name_d" class="selectAirport_d">
						<option>없음</option>
					</select>
				</div>
			</div>
			<br>
			<div>
				<div>
					<b>도착공항</b>&nbsp;&nbsp;
					<select name="ap_name_a" class="selectAirport_a">
						<option>없음</option>
					</select>
				</div>
			</div>
			<br>
			<div>
				<button id="getScheduleBtn">일정조회</button>
			</div>
		</div>
		
		<br><br>
		
		<div class="schedule"></div>
	
	</section>
	
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

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
			if(start_date.val() == ""){
				alert("비행일자를 선택해 주세요")
			} else if (ap_name_d.val() == ap_name_a.val()) {
				alert("출발공항과 도착공항을 다르게 입력해 주세요")
			} else {
				if (seat_grade.val() == "FIRST") {
					listScheduleFir({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val() }, 
							function(listSch) {
								if(listSch.length == 0){
									alert("일정이 존재하지 않습니다")
								}else{
									str += "<ul>";
									str += "<h2>비행일정</h2>";
									for(var i=0; i<listSch.length; i++){
										str += "<li> 항공편명 : " + listSch[i].flight_name + "</li>";
										str += "<li> 출발공항 : " + listSch[i].ap_name_d + "</li>";
										str += "<li> 도착공항 : " + listSch[i].ap_name_a + "</li>";
										str += "<li> 항공사명 : " + listSch[i].c_name + "</li>";
										str += "<li> 티켓가격 : " + listSch[i].firstseatprice + "</li>";
										str += "<li> 탑승시각 : " + listSch[i].boarding_time + "</li>";
										str += "<li> 출발시각 : " + listSch[i].depart_time + "</li>";
										str += "<li> 도착시각 : " + listSch[i].arrive_time + "</li>";
										str += "<button id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">일정 선택</button><br>";
										str += "<br><hr><br>";
									}
									str += "</ul>";
									console.log()
								}
							$(".schedule").html(str)
							// 일정 선택 버튼 클릭 이벤트
							$(".schedule button").on("click", function() {
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
								if(listSch.length == 0){
									alert("일정이 존재하지 않습니다")
								}else{
									str += "<ul>";
									str += "<h2>비행일정</h2>";
									for(var i=0; i<listSch.length; i++){
										str += "<li> 항공편명 : " + listSch[i].flight_name + "</li>";
										str += "<li> 출발공항 : " + listSch[i].ap_name_d + "</li>";
										str += "<li> 도착공항 : " + listSch[i].ap_name_a + "</li>";
										str += "<li> 항공사명 : " + listSch[i].c_name + "</li>";
										str += "<li> 좌석가격 : " + listSch[i].businessseatprice + "</li>";
										str += "<li> 탑승시각 : " + listSch[i].boarding_time + "</li>";
										str += "<li> 출발시각 : " + listSch[i].depart_time + "</li>";
										str += "<li> 도착시각 : " + listSch[i].arrive_time + "</li>";
										str += "<button id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">일정 선택</button><br>";
										str += "<br><hr><br>";
									}
									str += "</ul>";
								}
							$(".schedule").html(str)
							// 일정 선택 버튼 클릭 이벤트
							$(".schedule button").on("click", function() {
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
								if(listSch.length == 0){
									alert("일정이 존재하지 않습니다")
								}else{
									str += "<ul>";
									str += "<h2>비행일정</h2>";
									for(var i=0; i<listSch.length; i++){
										str += "<li> 항공편명 : " + listSch[i].flight_name + "</li>";
										str += "<li> 출발공항 : " + listSch[i].ap_name_d + "</li>";
										str += "<li> 도착공항 : " + listSch[i].ap_name_a + "</li>";
										str += "<li> 항공사명 : " + listSch[i].c_name + "</li>";
										str += "<li> 좌석가격 : " + listSch[i].economyseatprice + "</li>";
										str += "<li> 탑승시각 : " + listSch[i].boarding_time + "</li>";
										str += "<li> 출발시각 : " + listSch[i].depart_time + "</li>";
										str += "<li> 도착시각 : " + listSch[i].arrive_time + "</li>";
										str += "<button id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">일정 선택</button><br>";
										str += "<br><hr><br>";
									}
									str += "</ul>";
								}
							$(".schedule").html(str)
							// 일정 선택 버튼 클릭 이벤트
							$(".schedule button").on("click", function() {
								// 일정번호
								var date_idx = $(this).data("idx");
								// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
								location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=ECONOMY";
								console.log(date_idx)
							})
					}) // end : 이코노미 좌석 선택 일정
				} // end : 좌석 구분 else
			} // end : 예외처리 else
			
		}) // end : 일정 조회 버튼 클릭 이벤트 종료
		
	}) // end : onload
	
</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

