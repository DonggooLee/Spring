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

	<h2>여정 정보</h2>
	<div class="scheduleInfo" style="border: 1px solid black; width: 800px; height: 80px;">
		<table>
			<tr>
				<th>일정번호</th>
				<th>항공편명</th>
				<th>비행일자</th>
				<th>좌석등급</th>
				<th>출발시간</th>
 				<th>도착시간</th>
				<th>출발공항</th>
				<th>도착공항</th>
				<th>티켓가격</th>
			</tr>
			<tr>
				<td>${getSchedule.date_idx }</td>
				<td>${getSchedule.flight_name }</td>
				<td>${getSchedule.start_date }</td>
				<td>${getSchedule.seat_grade }</td>
				<td>${getSchedule.depart_time }</td>
				<td>${getSchedule.arrive_time }</td>
				<td>${getSchedule.ap_name_s }</td>
				<td>${getSchedule.ap_name_d }</td>
				<td>${getSchedule.seat_price }</td>
			</tr>
		</table>
	</div>
	
	<hr>
	
	<h2>승객 정보</h2>
	<div class="memberInfo">
		<table>
			<tr>
				<th>승객이름</th>
				<td>
					<input type="text" name="m_name" value="${loginPublicInfo.m_name}">
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="text" name="m_gender" value="${loginPublicInfo.m_gender}">
				</td>
			</tr>
			<tr>
				<th>국적</th>
				<td>
					<input type="text" name="m_gender">
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="text" name="m_birth" value="${loginPublicInfo.m_birth}">
				</td>
			</tr>			
			<tr>
				<th>회원번호</th>
				<td>
					<input type="text" name="m_idx" value="${loginPublicInfo.m_id}">
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="m_email" value="${loginPublicInfo.m_email}">
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<input type="text" name="m_phone" value="${loginPublicInfo.m_phone}">
				</td>
			</tr>
			<tr>
				<th>여권번호</th>
				<td>
					<input type="text" name="passport_num">
				</td>
			</tr>
		</table>
	</div>
	
	<hr>
	
	<h2>좌석 정보</h2>
	<div class="choiceSeat" style="border: 1px solid black; width: 800px; height: 200px; text-align: center;">
		<table>
			<tr>
				<th>좌석등급</th>
				<th>좌석번호</th>
				<th>좌석가격</th>
			</tr>
			<tr>
				<td>${getSeat.seat_grade }</td>
				<td>${getSeat.seat_name }</td>
				<td>${getSeat.seat_price }</td>
				<td><button>결제하기</button></td>
			</tr>
		</table>
	</div>
	
	<hr>
	
	<div class="confirm">
		<button>예약하기</button>
	</div>
	
<script type="text/javascript">

	$(function() {
		
		/*
		// 결제하기 버튼 클릭 이벤트
		$(".choiceSeat").find("button").on("click", function() {
			
			$.ajax({
				url : '/flightManager/kakaopay?test=' + total_amount,
				dataType : 'json',	
				success : function(data) {
					console.log(data);
					window.open(data.next_redirect_pc_url);
				},
				error : function(error) {
					alert("실패 : " + error)
				}
			})
			
		}) // end : 결제하기 버튼 클릭 이벤트 종료
		*/
		
		// 예약하기 버튼 클릭 이벤트
		$(".confirm").find("button").on("click", function() {
			
			// 예약확정 페이지로 갈 때 가지고 가야하는 값
			// 티켓번호 : 자동완성(컨트롤러에서 처리), 일정번호, 항공편명, 항공사번호, 회원번호(세션에 저장된 값 꺼내기), 예약일자(sysdate), 티켓가격, 여권번호
			
			
			alert(" 버튼 클릭 테스트 ! ")
		
		}) // end : 예약하기 버튼 클릭 이벤트 종료
		
	}) // end : onload

</script>
</body>
</html>