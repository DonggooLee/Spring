<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
	
	<section class="conted">

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
				&nbsp;
				<button id="lowPriceleBtn">낮은가격순</button>
			</div>
		</div>
		
		<br><br>
		
		<div class="schedule"></div>
		
		<br><hr><br>
		
		<div class="flightContainer" style="padding: 10px;">
			<div class="infoFlightImg">
				<img src="/img/asiana.jpg" style="width: 90px; height: 90px;">
			</div>
			<div class="infoFlight">
				<div><b>아시아나</b></div>
				<br>
				<div><b>AA987</b></div>
			</div>
			<div class="infoDepart">
				<div><b>17:05</b></div>
				<br>
				<div><b>제주(CJU)</b></div>
			</div>
			<div class="infoDepart">
				<img src="/img/right-arrow.png" style="width: 80px; height: 30px;">
			</div>
			<div class="infoArrive">
				<div><b>18:15</b></div>
				<br>
				<div><b>인천(ICN)</b></div>
			</div>
			<div class="infoPrice">
				<div><b>85,000원</b></div>
			</div>
			<div class="infoPrice">
				<button style="padding: 15px;">선택</button>
			</div>
		</div>
		
	</section>
	
<style>

	.conted{
		width: 100%;
		max-width: 1200px;
		margin: 0 auto;
		height: 1200px;
		background-color: #F0FFFF;
		height: 3000px;
		border: 2px solid pink;
		padding: 20px;
	}
	
	.flightContainer{
		border: 1px solid black;
		width: 800px; height: 100px;
		display: flex;
		align-items: center;
		justify-content: space-between;
	}

</style>
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
		
		// 티켓 가격에 천단위 구분을 위한 함수
		function AmountCommas(val){
		    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
		}
		
		// 일정 조회 버튼 클릭 이벤트
		getScheduleBtn.on("click", function() {
			var str = '';
			if(start_date.val() == ""){
				alert("비행일자를 선택해 주세요")
			} else if (ap_name_d.val() == ap_name_a.val()) {
				alert("출발공항과 도착공항을 다르게 입력해 주세요")
			} else {
				if (seat_grade.val() == "FIRST") {
					listScheduleFir({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val(), orderby:"date"}, 
							function(listSch) {
								if(listSch.length == 0){
									alert("일정이 존재하지 않습니다")
								}else{
									for(var i=0; i<listSch.length; i++){
										str += "<div class='flightContainer' style='padding: 20px;'>";
										if(listSch[i].c_name == "대한항공"){
											str += "<div class='infoFlightImg'><img src='/img/koreanAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "아시아나"){
											str += "<div class='infoFlightImg'><img src='/img/Asiana.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "제주에어"){
											str += "<div class='infoFlightImg'><img src='/img/JejuAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어부산"){
											str += "<div class='infoFlightImg'><img src='/img/airBusan.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어서울"){
											str += "<div class='infoFlightImg'><img src='/img/airSeoul.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "진에어"){
											str += "<div class='infoFlightImg'><img src='/img/jinAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "티웨이"){
											str += "<div class='infoFlightImg'><img src='/img/twayAir.png' style='width: 110px; height: 90px;'></div>";
										}
										str += "<div class='infoFlight'><div><b>"+listSch[i].c_name+"</b></div><br><div><b>"+listSch[i].flight_name+"</b></div></div>";
										str += "<div class='infoDepart'><div><b>"+listSch[i].ap_name_d+"</b></div><br><div><b>"+listSch[i].depart_time+"</b></div></div>";
										str += "<div class='infoArrow'><img src='/img/right-arrow.png' style='width: 80px; height: 30px;'></div>";
										str += "<div class='infoArrive'><div><b>"+listSch[i].ap_name_a+"</b></div><br><div><b>"+listSch[i].arrive_time+"</b></div></div>";
										str += "<div class='infoPrice'><div><b>"+AmountCommas(listSch[i].firstseatprice)+"원</b></div></div>";
										str += "<div class='infoButton'><button style='padding: 15px;' id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">선택</button></div></div>";
										str += "</div><br><br>";
									}
								}
							$(".schedule").html(str)
							// 일정 선택 버튼 클릭 이벤트
							$(".schedule button").on("click", function() {
								// 일정번호
								var date_idx = $(this).data("idx");
								// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
								location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=FIRST";
							})
					}) // end : 퍼스트 좌석 선택 일정
				} else if (seat_grade.val() == "BUSINESS") {
					listScheduleBis({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val(), orderby:"date"}, 
							function(listSch) {
								if(listSch.length == 0){
									alert("일정이 존재하지 않습니다")
								}else{
									for(var i=0; i<listSch.length; i++){
										str += "<div class='flightContainer' style='padding: 20px;'>";
										if(listSch[i].c_name == "대한항공"){
											str += "<div class='infoFlightImg'><img src='/img/koreanAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "아시아나"){
											str += "<div class='infoFlightImg'><img src='/img/Asiana.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "제주에어"){
											str += "<div class='infoFlightImg'><img src='/img/JejuAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어부산"){
											str += "<div class='infoFlightImg'><img src='/img/airBusan.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어서울"){
											str += "<div class='infoFlightImg'><img src='/img/airSeoul.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "진에어"){
											str += "<div class='infoFlightImg'><img src='/img/jinAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "티웨이"){
											str += "<div class='infoFlightImg'><img src='/img/twayAir.png' style='width: 110px; height: 90px;'></div>";
										}
										str += "<div class='infoFlight'><div><b>"+listSch[i].c_name+"</b></div><br><div><b>"+listSch[i].flight_name+"</b></div></div>";
										str += "<div class='infoDepart'><div><b>"+listSch[i].ap_name_d+"</b></div><br><div><b>"+listSch[i].depart_time+"</b></div></div>";
										str += "<div class='infoArrow'><img src='/img/right-arrow.png' style='width: 80px; height: 30px;'></div>";
										str += "<div class='infoArrive'><div><b>"+listSch[i].ap_name_a+"</b></div><br><div><b>"+listSch[i].arrive_time+"</b></div></div>";
										str += "<div class='infoPrice'><div><b>"+AmountCommas(listSch[i].businessseatprice)+"원</b></div></div>";
										str += "<div class='infoButton'><button style='padding: 15px;' id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">선택</button></div></div>";
										str += "</div><br><br>";
									}
								}
							$(".schedule").html(str)
							// 일정 선택 버튼 클릭 이벤트
							$(".schedule button").on("click", function() {
								// 일정번호
								var date_idx = $(this).data("idx");
								// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
								location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=BUSINESS";
							})
					}) // end : 비즈니스 좌석 선택 일정
				} else{
					listScheduleEco({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val(), orderby:"date"}, 
							function(listSch) {
								if(listSch.length == 0){
									alert("일정이 존재하지 않습니다")
								}else{
									for(var i=0; i<listSch.length; i++){
										str += "<div class='flightContainer' style='padding: 20px;'>";
										if(listSch[i].c_name == "대한항공"){
											str += "<div class='infoFlightImg'><img src='/img/koreanAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "아시아나"){
											str += "<div class='infoFlightImg'><img src='/img/Asiana.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "제주에어"){
											str += "<div class='infoFlightImg'><img src='/img/JejuAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어부산"){
											str += "<div class='infoFlightImg'><img src='/img/airBusan.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어서울"){
											str += "<div class='infoFlightImg'><img src='/img/airSeoul.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "진에어"){
											str += "<div class='infoFlightImg'><img src='/img/jinAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "티웨이"){
											str += "<div class='infoFlightImg'><img src='/img/twayAir.png' style='width: 110px; height: 90px;'></div>";
										}
										str += "<div class='infoFlight'><div><b>"+listSch[i].c_name+"</b></div><br><div><b>"+listSch[i].flight_name+"</b></div></div>";
										str += "<div class='infoDepart'><div><b>"+listSch[i].ap_name_d+"</b></div><br><div><b>"+listSch[i].depart_time+"</b></div></div>";
										str += "<div class='infoArrow'><img src='/img/right-arrow.png' style='width: 80px; height: 30px;'></div>";
										str += "<div class='infoArrive'><div><b>"+listSch[i].ap_name_a+"</b></div><br><div><b>"+listSch[i].arrive_time+"</b></div></div>";
										str += "<div class='infoPrice'><div><b>"+AmountCommas(listSch[i].economyseatprice)+"원</b></div></div>";
										str += "<div class='infoButton'><button style='padding: 15px;' id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">선택</button></div></div>";
										str += "</div><br><br>";
									}
								}
							$(".schedule").html(str)
							// 일정 선택 버튼 클릭 이벤트
							$(".schedule button").on("click", function() {
								// 일정번호
								var date_idx = $(this).data("idx");
								// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
								location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=ECONOMY";
							})
					}) // end : 이코노미 좌석 선택 일정
				} // end : 좌석 구분 else
			} // end : 예외처리 else
		}) // end : 일정 조회 버튼 클릭 이벤트 종료
		
		// 낮은가격순 버튼 클릭 이벤트
		$("#lowPriceleBtn").on("click", function() {
			var str = '';
			if(start_date.val() == ""){
				alert("비행일자를 선택해 주세요")
			} else if (ap_name_d.val() == ap_name_a.val()) {
				alert("출발공항과 도착공항을 다르게 입력해 주세요")
			} else {
				if (seat_grade.val() == "FIRST") {
					listScheduleFir({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val(), orderby:"lowPrice"}, 
							function(listSch) {
								if(listSch.length == 0){
									alert("일정이 존재하지 않습니다")
								}else{
									for(var i=0; i<listSch.length; i++){
										str += "<div class='flightContainer' style='padding: 20px;'>";
										if(listSch[i].c_name == "대한항공"){
											str += "<div class='infoFlightImg'><img src='/img/koreanAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "아시아나"){
											str += "<div class='infoFlightImg'><img src='/img/Asiana.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "제주에어"){
											str += "<div class='infoFlightImg'><img src='/img/JejuAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어부산"){
											str += "<div class='infoFlightImg'><img src='/img/airBusan.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어서울"){
											str += "<div class='infoFlightImg'><img src='/img/airSeoul.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "진에어"){
											str += "<div class='infoFlightImg'><img src='/img/jinAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "티웨이"){
											str += "<div class='infoFlightImg'><img src='/img/twayAir.png' style='width: 110px; height: 90px;'></div>";
										}
										str += "<div class='infoFlight'><div><b>"+listSch[i].c_name+"</b></div><br><div><b>"+listSch[i].flight_name+"</b></div></div>";
										str += "<div class='infoDepart'><div><b>"+listSch[i].ap_name_d+"</b></div><br><div><b>"+listSch[i].depart_time+"</b></div></div>";
										str += "<div class='infoArrow'><img src='/img/right-arrow.png' style='width: 80px; height: 30px;'></div>";
										str += "<div class='infoArrive'><div><b>"+listSch[i].ap_name_a+"</b></div><br><div><b>"+listSch[i].arrive_time+"</b></div></div>";
										str += "<div class='infoPrice'><div><b>"+AmountCommas(listSch[i].firstseatprice)+"원</b></div></div>";
										str += "<div class='infoButton'><button style='padding: 15px;' id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">선택</button></div></div>";
										str += "</div><br><br>";
									}
								}
							$(".schedule").html(str)
							// 일정 선택 버튼 클릭 이벤트
							$(".schedule button").on("click", function() {
								// 일정번호
								var date_idx = $(this).data("idx");
								// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
								location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=FIRST";
							})
					}) // end : 퍼스트 좌석 선택 일정
				} else if (seat_grade.val() == "BUSINESS") {
					listScheduleBis({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val(), orderby:"lowPrice"}, 
							function(listSch) {
								if(listSch.length == 0){
									alert("일정이 존재하지 않습니다")
								}else{
									for(var i=0; i<listSch.length; i++){
										str += "<div class='flightContainer' style='padding: 20px;'>";
										if(listSch[i].c_name == "대한항공"){
											str += "<div class='infoFlightImg'><img src='/img/koreanAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "아시아나"){
											str += "<div class='infoFlightImg'><img src='/img/Asiana.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "제주에어"){
											str += "<div class='infoFlightImg'><img src='/img/JejuAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어부산"){
											str += "<div class='infoFlightImg'><img src='/img/airBusan.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어서울"){
											str += "<div class='infoFlightImg'><img src='/img/airSeoul.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "진에어"){
											str += "<div class='infoFlightImg'><img src='/img/jinAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "티웨이"){
											str += "<div class='infoFlightImg'><img src='/img/twayAir.png' style='width: 110px; height: 90px;'></div>";
										}
										str += "<div class='infoFlight'><div><b>"+listSch[i].c_name+"</b></div><br><div><b>"+listSch[i].flight_name+"</b></div></div>";
										str += "<div class='infoDepart'><div><b>"+listSch[i].ap_name_d+"</b></div><br><div><b>"+listSch[i].depart_time+"</b></div></div>";
										str += "<div class='infoArrow'><img src='/img/right-arrow.png' style='width: 80px; height: 30px;'></div>";
										str += "<div class='infoArrive'><div><b>"+listSch[i].ap_name_a+"</b></div><br><div><b>"+listSch[i].arrive_time+"</b></div></div>";
										str += "<div class='infoPrice'><div><b>"+AmountCommas(listSch[i].businessseatprice)+"원</b></div></div>";
										str += "<div class='infoButton'><button style='padding: 15px;' id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">선택</button></div></div>";
										str += "</div><br><br>";
									}
								}
							$(".schedule").html(str)
							// 일정 선택 버튼 클릭 이벤트
							$(".schedule button").on("click", function() {
								// 일정번호
								var date_idx = $(this).data("idx");
								// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
								location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=BUSINESS";
							})
					}) // end : 비즈니스 좌석 선택 일정
				} else{
					listScheduleEco({seat_grade:seat_grade.val(), start_date:start_date.val(), ap_name_d:ap_name_d.val(), ap_name_a:ap_name_a.val(), orderby:"lowPrice"}, 
							function(listSch) {
								if(listSch.length == 0){
									alert("일정이 존재하지 않습니다")
								}else{
									for(var i=0; i<listSch.length; i++){
										str += "<div class='flightContainer' style='padding: 20px;'>";
										if(listSch[i].c_name == "대한항공"){
											str += "<div class='infoFlightImg'><img src='/img/koreanAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "아시아나"){
											str += "<div class='infoFlightImg'><img src='/img/Asiana.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "제주에어"){
											str += "<div class='infoFlightImg'><img src='/img/JejuAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어부산"){
											str += "<div class='infoFlightImg'><img src='/img/airBusan.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "에어서울"){
											str += "<div class='infoFlightImg'><img src='/img/airSeoul.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "진에어"){
											str += "<div class='infoFlightImg'><img src='/img/jinAir.png' style='width: 110px; height: 90px;'></div>";
										}else if(listSch[i].c_name == "티웨이"){
											str += "<div class='infoFlightImg'><img src='/img/twayAir.png' style='width: 110px; height: 90px;'></div>";
										}
										str += "<div class='infoFlight'><div><b>"+listSch[i].c_name+"</b></div><br><div><b>"+listSch[i].flight_name+"</b></div></div>";
										str += "<div class='infoDepart'><div><b>"+listSch[i].ap_name_d+"</b></div><br><div><b>"+listSch[i].depart_time+"</b></div></div>";
										str += "<div class='infoArrow'><img src='/img/right-arrow.png' style='width: 80px; height: 30px;'></div>";
										str += "<div class='infoArrive'><div><b>"+listSch[i].ap_name_a+"</b></div><br><div><b>"+listSch[i].arrive_time+"</b></div></div>";
										str += "<div class='infoPrice'><div><b>"+AmountCommas(listSch[i].economyseatprice)+"원</b></div></div>";
										str += "<div class='infoButton'><button style='padding: 15px;' id=choiceScheduleBtn data-idx=" + listSch[i].date_idx + ">선택</button></div></div>";
										str += "</div><br><br>";
									}
								}
							$(".schedule").html(str)
							// 일정 선택 버튼 클릭 이벤트
							$(".schedule button").on("click", function() {
								// 일정번호
								var date_idx = $(this).data("idx");
								// 일정번호, 좌석등급 가지고 항공권 확인 페이지로 이동
								location.href = "scheduleConfirm?date_idx=" + date_idx + "&seat_grade=ECONOMY";
							})
					}) // end : 이코노미 좌석 선택 일정
				} // end : 좌석 구분 else
			} // end : 예외처리 else
		}) // end : 낮은가격순 버튼 클릭 이벤트
		
	}) // end : onload
	
</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>