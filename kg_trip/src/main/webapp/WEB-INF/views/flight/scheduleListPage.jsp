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
			<button id="getScheduleBtn" type="button">일정 조회</button>
		</div>
	</div>
	
	<div class="listSchedule">
		<h1> 비행일정 </h1>
		<div>
			<ul class="ul">
				<li>일정 없음</li>
			</ul>
		</div>
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
		var ul = $(".ul")
		
		// 일정 조회 버튼 클릭 이벤트
		getScheduleBtn.on("click", function() {
			var str = '';
			listSchedule(start_date.val(), function(listSch) {
				for(var i=0; i<listSch.length; i++){
					str += "<li>"+listSch[i].start_date+"</li>";
					str += "<li>"+listSch[i].flight_name+"</li>";
					str += "<li>"+listSch[i].ap_name_s+"</li>";
					str += "<li>"+listSch[i].ap_name_d+"</li>";
					str += "<li>"+listSch[i].air_name+"</li>";
					str += "<li>"+listSch[i].air_name+"</li>";
					str += "<li>"+listSch[i].seat_grade+"</li>";
					str += "<li>"+listSch[i].seat_price+"</li>";
				}
				ul.html(str)
			})
		}) // end : 일정 조회 버튼 클릭 이벤트 종료
		
	}) // end : onload
	
</script>
</body>
</html>