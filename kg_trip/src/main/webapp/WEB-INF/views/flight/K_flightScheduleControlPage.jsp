<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<title>Home</title>
<link rel="stylesheet" type="text/css" href="/resources/css/default.css">
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont">
		
			<!-- <div  class="flight_3" style="border: 1px solid black; width: 300px;">
				<h1 style="text-align: center;">항공편 일정 만들기 페이지</h1>
				<div>
					<div>항공사</div>
					<div>
						<select name="air_idx">
							<option value="1">대한항공</option>
							<option value="2">아시아나</option>
							<option value="3">진에어</option>
							<option value="4">제주항공</option>
							<option value="5">에어서울</option>
							<option value="6">에어부산</option>
							<option value="7">티웨이항공</option>
						</select>
					</div>
				</div>
				<div>
					<div>항공편명</div>
					<div><input type="text" name="flight_name"></div>
				</div>
				<div>
					<div>비행일자</div>
					<div><input type="date" name="start_date"></div>
				</div>
				<div>
					<div>탑승시각</div>
					<div><input type="text" name="boarding_time" placeholder="YYYY-MM-DD HH:MM"></div>
				</div>
				<div>
					<div>출발시각</div>
					<div><input type="text" name="depart_time" placeholder="YYYY-MM-DD HH:MM"></div>
				</div>
				<div>
					<div>도착시각</div>
					<div><input type="text" name="arrive_time" placeholder="YYYY-MM-DD HH:MM"></div>
				</div>
				<div>
					<div>출발공항</div>
					<div>
						<select name="air_idx_s">
							<option value="1">인천(ICN)</option>
							<option value="2">제주(CJU)</option>
							<option value="3">부산(PUS)</option>
							<option value="4">청주(CJJ)</option>
							<option value="5">여수(RSU)</option>
							<option value="6">광주(KWJ)</option>
							<option value="7">대구(TAE)</option>
							<option value="8">김포(GMP)</option>
							<option value="9">양양(YNY)</option>
							<option value="10">군산(KUV)</option>
							<option value="11">울산(USN)</option>
							<option value="12">포항(KPO)</option>
						</select>
					</div>
				</div>
				<div>
					<div>도착공항</div>
					<div>
						<select name="air_idx_s">
							<option value="1">인천(ICN)</option>
							<option value="2">제주(CJU)</option>
							<option value="3">부산(PUS)</option>
							<option value="4">청주(CJJ)</option>
							<option value="5">여수(RSU)</option>
							<option value="6">광주(KWJ)</option>
							<option value="7">대구(TAE)</option>
							<option value="8">김포(GMP)</option>
							<option value="9">양양(YNY)</option>
							<option value="10">군산(KUV)</option>
							<option value="11">울산(USN)</option>
							<option value="12">포항(KPO)</option>
						</select>
					</div>
				</div>
				<div>
					<div><input type="submit" value="일정추가"></div>
				</div>
			</div> -->
			
			<br>
			
			<div class="flight_2" style="border: 1px solid black; width: 300px;">
				<h1 style="text-align: center;">좌석 DB 페이지</h1>
				<div>
					<div>항공편명</div>
					<div><input type="text" name="flight_name" value="테스트"></div>
				</div>
				<div>
					<div>좌석등급</div>
					<div>
						<select name="seat_grade">
							<option value="FIRST">FIRST</option>
							<option value="2">BUSINESS</option>
							<option value="3">ECONOMY</option>
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
			
			<br>
			
			<form class="flight_1" style="border: 1px solid black; width: 300px;">
				<h1 style="text-align: center;">비행기 DB 페이지</h1>
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
			</form>
			
		</section>
		
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	console.log("로그테스트.........")
	
	$(function() {
		
		var flightInsertBtn = $("#flightInsertBtn")
		var seatInsertBtn = $("#seatInsertBtn");
		
		var flight_1 = $(".flight_1");
		var flight_name_1 = flight_1.find("input[name='flight_name']");
		var flight_people_1 = flight_1.find("input[name='flight_people']");
		
		// 항공편 추가 버튼 클릭 이벤트		
		flightInsertBtn.on("click", function() {
			alert("TEST 클릭 이벤트")
			console.log("항공편명 : " + flight_name_1.val());
			console.log("항공편인원수 : " + flight_people_1.val());
			flightServiece.add(
				{flight_name:flight_name_1.val(), flight_people:flight_people_1.val()},
				function(result) {
					alert("테스트 결과 : " + result);		
				}
			); 
		}); // end : 항공편 추가 버튼 종료
		
	}); // end : onload
	
</script>		
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>