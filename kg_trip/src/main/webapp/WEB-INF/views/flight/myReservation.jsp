<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
	
	<section class="cont">
	
		<div style="border: 1px solid black; width: 500px; padding: 20px;">
			<h1 style="text-align: center;">예약정보</h1>
			<br>
			<h3>예약번호: ${bookNum}</h3>
			<br>
			<table>
				<tr><th>이름</th><td>${bookInfo.m_name }</td></tr>
				<tr><th>항공편명</th><td>${bookInfo.flight_name }</td></tr>
				<tr><th>비행일자</th><td>${bookInfo.start_date }</td></tr>
				<tr><th>탑승시각</th><td>${bookInfo.boarding_time }</td></tr>
				<tr><th>출발시각</th><td>${bookInfo.depart_time }</td></tr>
				<tr><th>도착시각</th><td>${bookInfo.arrive_time }</td></tr>
				<tr><th>출발공항</th><td>${bookInfo.ap_name_d }</td></tr>
				<tr><th>도착공항</th><td>${bookInfo.ap_name_a }</td></tr>
				<tr><th>좌석번호</th><td>${bookInfo.seat_name }</td></tr>
			</table>
		</div>
		
	</section>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>