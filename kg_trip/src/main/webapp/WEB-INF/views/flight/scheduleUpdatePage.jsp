<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>${updateInfo.flight_name} 항공편 일정 변경 페이지 !</h1>
	
	<form action="scheduleUpdate" method="post">
		<table style="border: 1px solid black; padding: 15px;" class="getSchedule">
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
					<select name="ap_name_d" class="selectAirport_d">
						<option>없음</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>도착공항</th>
				<td>
					<select name="ap_name_a" class="selectAirport_a">
						<option>없음</option>
					</select>
				</td>
			</tr>
		</table>
		<br>
		<div>
			<input type="reset" value="취소">
			&nbsp;
			<input type="submit" value="수정">
		</div>
	</form>
	
	<!-- 공항 중복되는 값 제거를 위한 객체 -->
	<input type="hidden" id="ap_name_d" value="${updateInfo.ap_name_d}">
	<input type="hidden" id="ap_name_a" value="${updateInfo.ap_name_a}">
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">
	
	$(function() {
		
		// 공항 조회에 필요한 객체
		var selectAirport_d = $(".selectAirport_d");
		var selectAirport_a = $(".selectAirport_a");
		var ap_name_d = $(".getSchedule").find("select[name='ap_name_d']");
		var ap_name_a = $(".getSchedule").find("select[name='ap_name_a']");
		var ap_name_d_ = $("#ap_name_d").val()
		var ap_name_a_ = $("#ap_name_a").val()
		
		// 공항 조회
		listAirport(function(listAp) {
			var str_1 = "<option value=" + ap_name_d_ + ">" + ap_name_d_ + "</option>";
			var str_2 = "<option value=" + ap_name_a_ + ">" + ap_name_a_ + "</option>";
			for(var i=0; i<listAp.length; i++){
				if(ap_name_d_ != listAp[i].ap_name_d){
					str_1 += "<option value=" + listAp[i].ap_idx + ">" + listAp[i].ap_name_d + "</option>";
				}
				if(ap_name_a_ != listAp[i].ap_name_a){
					str_2 += "<option value=" + listAp[i].ap_idx + ">" + listAp[i].ap_name_a + "</option>";
				}
			}
			// 출발 공항
			selectAirport_d.html(str_1)
			// 도착 공항
			selectAirport_a.html(str_2)
		})
		
	}) // end : onload

</script>
</body>
</html>