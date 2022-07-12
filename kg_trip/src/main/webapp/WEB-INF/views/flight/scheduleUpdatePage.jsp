<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>${updateInfo.flight_name} 항공편 일정 변경 페이지!</h1>
	
	<div style="border: 1px solid black; padding: 15px; width: 300px;" class="getSchedule">
		<form action="scheduleUpdate" method="post" id="myForm">
			<table>
				<tr>
					<th>일정번호</th>
					<td><input type="text" name="date_idx" value="${updateInfo.date_idx}" readonly="readonly"></td>
				</tr>
				<tr>
					<th>항공편명</th>
					<td><input type="text" name="flight_name" value="${updateInfo.flight_name}" readonly="readonly"></td>
				</tr>
				<tr>
					<th>비행일자</th>
					<td><input type="date" name="start_date"></td>
				</tr>
				<tr>
					<th>탑승시각</th>
					<td><input type="time" name="boarding_time" value="${updateInfo.boarding_time}"></td>
				</tr>
				<tr>
					<th>출발시각</th>
					<td><input type="time" name="depart_time" value="${updateInfo.depart_time}"></td>
				</tr>
				<tr>
					<th>도착시각</th>
					<td><input type="time" name="arrive_time" value="${updateInfo.arrive_time}"></td>
				</tr>
				<tr>
					<th>출발공항</th>
					<td>
						<select name="ap_idx_d" class="selectAirport_d">
							<option>없음</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>도착공항</th>
					<td>
						<select name="ap_idx_a" class="selectAirport_a">
							<option>없음</option>
						</select>
					</td>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<td colspan="2">
						<button id="cancelBtn">취소</button>
						&nbsp;
						<button id="updateBtn">수정</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">
	
	$(function() {
		
		// 공항 조회에 필요한 객체
		var selectAirport_d = $(".selectAirport_d");
		var selectAirport_a = $(".selectAirport_a");
		
		// 항공편 수정을 위한 값
		var date_idx = $("#myForm").find("input[name='date_idx']").val();
		var flight_name = $("#myForm").find("input[name='flight_name']").val();
		var start_date = $("#myForm").find("input[name='start_date']");
		var boarding_time = $("#myForm").find("input[name='boarding_time']").val();
		var depart_time = $("#myForm").find("input[name='depart_time']").val();
		var arrive_time = $("#myForm").find("input[name='arrive_time']").val();
		var ap_idx_d = $("#myForm").find("select[name='ap_idx_d']");
		var ap_idx_a = $("#myForm").find("select[name='ap_idx_a']");
		
		// 공항 조회
		listAirport(function(listAp) {
			var str_1 = "";
			var str_2 = "";
			for(var i=0; i<listAp.length; i++){
				str_1 += "<option value=" + listAp[i].ap_idx + ">" + listAp[i].ap_name_d + "</option>";
				str_2 += "<option value=" + listAp[i].ap_idx + ">" + listAp[i].ap_name_a + "</option>";
			}
			// 출발 공항
			selectAirport_d.html(str_1)
			// 도착 공항
			selectAirport_a.html(str_2)
		}) // end : 공항 조회
		
		// 수정하기 버튼 클릭 이벤트
		$("#updateBtn").on("click", function(e) {
			e.preventDefault();
			var param = {date_idx:date_idx, flight_name:flight_name,start_date:start_date.val(), boarding_time:boarding_time,
					depart_time:depart_time, arrive_time:arrive_time, ap_idx_d:ap_idx_d.val(), ap_idx_a:ap_idx_a.val()}
			if (start_date.val() == "") {
				alert("비행일자를 입력해 주세요")
			}else if(boarding_time == ""){
				alert("탑승시각을 입력해 주세요")
			}else if(depart_time == ""){
				alert("출발시각을 입력해 주세요")
			}else if(arrive_time == ""){
				alert("도착시각을 입력해 주세요")
			}else if(depart_time >= arrive_time){
				alert("출발시각이 도착시각과 같거나 늦게 설정 되었습니다.")	
			}else if (ap_idx_d.val() == ap_idx_a.val()) {
				alert("출발공항과 도착공항을 다르게 입력해 주세요")
			}else{
				$.ajax({
					type : 'post',
					url : '/flight/scheduleUpdate',
					data : JSON.stringify(param), 
					contentType : 'application/json; charset=utf-8',
					success : function() {
						opener.location.href="scheduleManagerPage";
						window.close();
					}
				})
			}
		}) // end : 수정하기 버튼 클릭 이벤트
		
		// 취소하기 버튼 클릭 이벤트
		$("#cancelBtn").on("click", function() {
			opener.location.href="scheduleManagerPage";
			window.close();
		}) // end : 취소 버튼 클릭 이벤트
		
	}) // end : onload

</script>
</body>
</html>