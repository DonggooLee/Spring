<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
	
	<section class="cont">
	
		<h2>여정 정보</h2>
		<br>
		<div class="scheduleInfo" style="border: 1px solid black; width: 670px; height: 60px; padding: 10px;">
			<table>
				<tr>
					<th>항공편명</th>
					<th>비행일자</th>
					<th>좌석등급</th>
					<th>탑승시각</th>
					<th>출발시간</th>
	 				<th>도착시간</th>
					<th>출발공항</th>
					<th>도착공항</th>
					<th>티켓가격</th>
				</tr>
				<tr>
					<td>${getSchedule.flight_name }</td>
					<td><fmt:formatDate value="${getSchedule.start_date }" pattern="yyyy-MM-dd"/></td>
					<td>${seat_grade }</td>
					<td>${getSchedule.boarding_time }</td>
					<td>${getSchedule.depart_time }</td>
					<td>${getSchedule.arrive_time }</td>
					<td>${getSchedule.ap_name_d }</td>
					<td>${getSchedule.ap_name_a }</td>
					<td id="ticketPrice"></td>
				</tr>
			</table>
		</div>
		<br><hr><br>
		<h2>승객 정보</h2>
		<br>
		<div class="memberInfo" style="border: 1px solid black; padding: 10px; width: 270px;">
			<table>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="m_name" value="${loginPublicInfo.m_name}" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<input type="text" name="m_gender" value="${loginPublicInfo.m_gender}" readonly="readonly">
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
					<th>생년월일</th>
					<td>
						<input type="text" name="m_birth" value="${loginPublicInfo.m_birth}" readonly="readonly">
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
		<br><hr><br>
		<h2>좌석 배정</h2>
		<br>
		<div class="choiceSeat" style="border: 1px solid black; width: 730px; height: 420px; padding: 10px; text-align: center;"></div>
		<br>
		<div class="reservation">
			<button id="goBackBtn">뒤로가기</button>
			&nbsp;
			<button id="reservationBtn">예약하기</button>
			&nbsp;
			<button id="payBtn">결제하기</button>
		</div>
		
		<div class="hidden">
			<!-- 선택한 등급에 따른 좌석을 보여주기 위함 -->
			<input type="hidden" name="seat_grade" value="${seat_grade}">
			<input type="hidden" name="date_idx" value="${getSchedule.date_idx}">
		</div>
		
		<form action="myReservation" method="post" id="myForm">
			<input type="hidden" name="date_idx" value="${getSchedule.date_idx}">
			<input type="hidden" name="flight_name" value="${getSchedule.flight_name}">
			<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}">
		</form>
	
	</section>
	
<style>
	/* 좌석 배정 테스트용 : 이코노미 좌석만 적용 */
	#test:hover {
		background-color: blue;
		font-weight: bold;
		color: blue;
	}
	#test:focus {
		background-color: blue;
		font-weight: bold;
		color: blue;
	}
</style>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 좌석정보 얻기 위한 객체
		var seat_grade = $(".hidden").find("input[name='seat_grade']")
		var date_idx = $(".hidden").find("input[name='date_idx']")
		var div = $(".choiceSeat")
		
		// 항공권 예매를 위한 객체
		var bookInfo_ = '';
		var bookInfo = {};
		var m_idx = $("#myForm").find("input[name='m_idx']")
		var flight_name = $("#myForm").find("input[name='flight_name']")
		var passport_num = $(".memberInfo").find("input[name='passport_num']")

		// 해당 항공편의 좌석정보 출력
		getSeatList({seat_grade:seat_grade.val(), date_idx:date_idx.val()},
				function(seat) {
			
			// 이미 선택된 좌석정보 출력
			getReservationSeatList({flight_name:flight_name.val(), date_idx:date_idx.val()}, 
					function(seatList) {
				
				// 이코노미석 선택
				if(seat.economyseat != null) {
					var pEs = seat.economyseatprice
					$("#ticketPrice").html(pEs)
					var es = seat.economyseat
					var split_es = es.split(',')
					var str = '';
					for(var i=0; i<split_es.length; i++){
						for(var j=0; j<seatList.length; j++) {
							if(split_es[i] == seatList[j].seat_name ) {
								str += "<button style='padding: 15px; background-color: gray; margin: 5px;' disabled='disabled' id='test' data-idx="+split_es[i]+">" + split_es[i] + "</button>"
								i++;
								/* undefined 제거하기 위한 테스트 */
								if(split_es[i] == undefined){
									console.log("=====테스트=====")
								}
							}
						}
						str += "<button style='padding: 15px; background-color: white; margin: 5px;' id='test' data-idx="+split_es[i]+">" + split_es[i] + "</button>"
					}
					div.html(str)
					$(".choiceSeat button").on("click", function() {
						var seat_es = $(this).data("idx")
						alert("선택한 좌석 번호 : " + seat_es)
						bookInfo_ += "<input type='text' name='ticket_price' value=" + pEs + ">"
						bookInfo_ += "<input type='text' name='seat_name' value=" + seat_es + ">"
						bookInfo_ += "<input type='text' name='passport_num' value=" + passport_num.val() + ">"
						// 예약버튼 누르면 안에 있는 값 다지우고 다시 만들기 ?
						$("#myForm").append(bookInfo_)
						/* 
							비동기로 태울 때 필요한 테스트 데이터! ★★★
							bookInfo = {date_idx:date_idx.val(), flight_name:flight_name.val(), m_idx:m_idx.val(), 
								ticket_price:pEs, seat_name:seat_es, passport_num:passport_num.val()}
							console.log(bookInfo.date_idx+bookInfo.flight_name+bookInfo.m_idx+bookInfo.ticket_price
									+bookInfo.seat_name+bookInfo.passport_num);
						*/
					})
				} // end : 이코노미석 선택
				// 비즈니스석 선택
				if(seat.businessseat != null){
					var pBs = seat.businessseatprice
					$("#ticketPrice").html(pBs)
					var bs = seat.businessseat
					var split_bs = bs.split(',')
					var str = '';
					for(var i=0; i<split_bs.length; i++){
						str += "<button style='padding: 15px; background-color: white; margin: 5px;' id=seat_bs data-idx="+split_bs[i]+">" + split_bs[i] + "</button>"
					}
					div.html(str)
					$(".choiceSeat button").on("click", function() {
						var seat_bs = $(this).data("idx")
						alert("선택한 좌석 번호 : " + seat_bs)
						bookInfo_ += "<input type='text' name='ticket_price' value=" + pBs + ">"
						bookInfo_ += "<input type='text' name='seat_name' value=" + seat_bs + ">"
						bookInfo_ += "<input type='text' name='passport_num' value=" + passport_num.val() + ">"
						$("#myForm").append(bookInfo_)
					})
				} // end : 비즈니스석 선택
				// 퍼스트석 선택
				if(seat.firstseat != null){
					var pFs = seat.firstseatprice
					$("#ticketPrice").html(pFs)
					var fs = seat.firstseat
					var split_fs = fs.split(',')
					var str = '';
					for(var i=0; i<split_fs.length; i++){
						str += "<button style='padding: 15px; background-color: white; margin: 5px;' id=seat_fs data-idx="+split_fs[i]+">" + split_fs[i] + "</button>"
					}
					div.html(str)
					$(".choiceSeat button").on("click", function() {
						var seat_fs = $(this).data("idx")
						alert("선택한 좌석 번호 : " + seat_fs)
						bookInfo_ += "<input type='text' name='ticket_price' value=" + pFs + ">"
						bookInfo_ += "<input type='text' name='seat_name' value=" + seat_fs + ">"
						bookInfo_ += "<input type='text' name='passport_num' value=" + passport_num.val() + ">"
						$("#myForm").append(bookInfo_)
					})
				} // end : 퍼스트석 선택
				
			}) // end : 이미 선택된 좌석정보
			
		}) // end : 해당 항공편의 좌석정보 출력
		
		// 뒤로가기 버튼 클릭 이벤트
		$("#goBackBtn").on("click", function() {
			history.back()
		}) // end : 뒤로가기 버튼 클릭 이벤트
		
		// 결제하기 버튼 클릭 이벤트
		$("#payBtn").on("click", function() {
			var price = 15000;
			$.ajax({
				type : 'post',
				url : '/flightManager/kakaopay/' + price,
				dataType: 'json',
				success : function(data) {
					var box = data.next_redirect_pc_url
					window.open(box)
					console.log(data)
				},
				error : function(error) {
					alert(error)
				}
			}) // end : ajax()
		}) // end : 테스트 버튼 클릭 이벤트
		
		// 예약하기 버튼 클릭 이벤트
		$("#reservationBtn").on("click", function() {
			//alert("예약하기 버튼 클릭 이벤트")
			//각종 데이터 예외처리 하기
			$("#myForm").submit()
		}) // end : 예약하기 버튼 클릭 이벤트
		
	}) // end : onload
	
</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
