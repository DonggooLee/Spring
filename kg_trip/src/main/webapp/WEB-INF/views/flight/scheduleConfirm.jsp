<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
	
	<section class="cont">
	
		<h1>여정 정보</h1><br>
		<div class="scheduleInfo" style="border: 1px solid black; width: 680px; height: 55px; padding: 10px;">
			<table>
				<tr>
					<th>비행일자</th>
					<th>항공편명</th>
					<th>출발공항</th>
					<th>도착공항</th>
					<th>좌석등급</th>
					<th>예매가격</th>
					<th>탑승시각</th>
					<th>출발시간</th>
	 				<th>도착시간</th>
				</tr>
				<tr>
					<td><fmt:formatDate value="${getSchedule.start_date }" pattern="yyyy-MM-dd"/></td>
					<td>${getSchedule.flight_name }</td>
					<td>${getSchedule.ap_name_d }</td>
					<td>${getSchedule.ap_name_a }</td>
					<td>${seat_grade }</td>
					<td id="ticketPrice"></td>
					<td>${getSchedule.boarding_time }</td>
					<td>${getSchedule.depart_time }</td>
					<td>${getSchedule.arrive_time }</td>
				</tr>
			</table>
		</div>
		
		<br><hr><br>
		
		<h1>승객 정보</h1><br>
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
						<input type="text" name="m_email" value="${loginPublicInfo.m_email}" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<input type="text" name="m_phone" value="${loginPublicInfo.m_phone}" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" name="m_birth" value="${loginPublicInfo.m_birth}" readonly="readonly">
					</td>
				</tr>			
			</table>
		</div>
		
		<br><hr><br>
		
		<h1>좌석 배정</h1><br>
		<div class="choiceSeat" style="border: 1px solid black; width: 730px; height: 420px; padding: 10px; text-align: center;"></div>
		
		<br>
		
		<div class="reservation">
			<button id="goBackBtn">뒤로가기</button>
			&nbsp;
			<button id="payBtn">결제하기</button>
		</div>
		
		<!-- 화면에 보이지 않는 부분 : 데이터 가공 -->
		<div class="hidden">
			<!-- 좌석을 보여주기 위함 -->
			<input type="hidden" name="seat_grade" value="${seat_grade}">
			<input type="hidden" name="date_idx" value="${getSchedule.date_idx}">
			<input type="hidden" name="flight_name" value="${getSchedule.flight_name}">
			<!-- 항공권 예약 시 회원정보 입력 위함 -->
			<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}">
		</div>
		
		<!-- 항공권 예약-->				
		<form action="kakaoPay" method="post" id="reservationForm"></form>
	
	</section>
	
<style>

	#BookSeat{
		background-color: yellow;
		/* 포인터 클릭 이벤트 막기 */
		pointer-events: none;
	}

	#noneBookSeat{
		background-color: white;
	}
	
	#noneBookSeat:hover {
		background-color: #ffc0cb;
		font-weight: bold;
		color: black;
	}
	
	/* 버튼 선택시 색상 유지 */
	#noneBookSeat:focus {
		background-color: #ffc0cb;
	}
	
</style>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 가격을 하나의 변수에 담기 위한 전역 변수 선언
		var price = "";

		// 좌석정보 얻기 위한 객체
		var div = $(".choiceSeat");
		var date_idx = $(".hidden").find("input[name='date_idx']");
		var seat_grade = $(".hidden").find("input[name='seat_grade']");
		
		// 항공권 예매를 위한 객체
		var seat = '';
		var bookInfo_ = '';
		var m_idx = $(".hidden").find("input[name='m_idx']");
		var flight_name = $(".hidden").find("input[name='flight_name']");
		
		// 티켓 가격에 천단위 구분을 위한 함수
		function AmountCommas(val){
		    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
		}

		// 해당 항공편의 좌석정보 출력
		getSeatList({seat_grade:seat_grade.val(), date_idx:date_idx.val()},
				function(seat) {
			
			// 이미 선택된 좌석정보 출력
			getReservationSeatList({flight_name:flight_name.val(), date_idx:date_idx.val()}, 
					function(seatList) {
				
				// 이코노미석 선택
				if(seat.economyseat != null) {
					var pEs = seat.economyseatprice;
					price = pEs;
           			pEs = AmountCommas(pEs)+'원';
					$("#ticketPrice").html(pEs);
					var es = seat.economyseat;
					var split_es = es.split(',');
					var str = '';
					for(var i=0; i<split_es.length; i++){
						for(var j=0; j<seatList.length; j++) {
							if(split_es[i] == seatList[j].seat_name ) {
								str += "<button style='padding: 15px; margin: 5px;' id='BookSeat'>" + split_es[i] + "</button>"
								i++;
							}
						}
						str += "<button style='padding: 15px; margin: 5px;' id='noneBookSeat' data-idx="+split_es[i]+">" + split_es[i] + "</button>"
					}
					div.html(str);
					// 좌석 버튼 클릭 이벤트
					$(".choiceSeat button").on("click", function() {
						var seat_es = $(this).data("idx");
						// 로그인 유무 따른 예외처리
						if(m_idx.val() != ""){
							var rstr = '';
							alert("선택한 좌석 번호 : " + seat_es);
							// 예약을 위한 정보 생성
							rstr += "<input type='hidden' name='m_idx' value=" + m_idx.val() + ">";
							rstr += "<input type='hidden' name='date_idx' value=" + date_idx.val() + ">";
							rstr += "<input type='hidden' name='flight_name' value=" + flight_name.val() + ">";
							rstr += "<input type='hidden' name='seat_name' value=" + seat_es + ">";
							rstr += "<input type='hidden' name='ticket_price' value=" + price + ">";
							$("#reservationForm").html(rstr);
							// 결제하기 버튼 클릭 이벤트
							$("#payBtn").on("click", function() {
								$("#reservationForm").submit();
							}) // end : 결제하기 버튼 클릭 이벤트
						}else {
							alert("로그인이 필요한 서비스 입니다.")
							if(!confirm("로그인 하시겠습니까?")){
								return;
							}else{
								location.href = "${pageContext.request.contextPath}/Member/login";
							}
						} // end : 로그인 유무 따른 예외처리
					}) // end : 좌석 버튼 클릭 이벤트
				} // end : 이코노미석 선택
				
				// 비즈니스석 선택
				if(seat.businessseat != null){
					var pBs = seat.businessseatprice;
					price = pBs;
           			pBs = AmountCommas(pBs)+'원';
					$("#ticketPrice").html(pBs);
					var bs = seat.businessseat;
					var split_bs = bs.split(',');
					var str = '';
           			for(var i=0; i<split_bs.length; i++){
						for(var j=0; j<seatList.length; j++) {
							if(split_bs[i] == seatList[j].seat_name ) {
								str += "<button style='padding: 15px; margin: 5px;' id='BookSeat'>" + split_bs[i] + "</button>"
								i++;
							}
						}
						str += "<button style='padding: 15px; margin: 5px;' id='noneBookSeat' data-idx="+split_bs[i]+">" + split_bs[i] + "</button>"
					}
					div.html(str);
					// 좌석 버튼 클릭 이벤트
					$(".choiceSeat button").on("click", function() {
						var seat_bs = $(this).data("idx");
						// 로그인 유무 따른 예외처리
						if(m_idx.val() != ""){
							var rstr = '';
							alert("선택한 좌석 번호 : " + seat_bs);
							// 예약을 위한 정보 생성
							rstr += "<input type='hidden' name='m_idx' value=" + m_idx.val() + ">";
							rstr += "<input type='hidden' name='date_idx' value=" + date_idx.val() + ">";
							rstr += "<input type='hidden' name='flight_name' value=" + flight_name.val() + ">";
							rstr += "<input type='hidden' name='seat_name' value=" + seat_bs + ">";
							rstr += "<input type='hidden' name='ticket_price' value=" + price + ">";
							$("#reservationForm").html(rstr);
							// 결제하기 버튼 클릭 이벤트
							$("#payBtn").on("click", function() {
								$("#reservationForm").submit();
							}) // end : 결제하기 버튼 클릭 이벤트
						}else {
							alert("로그인이 필요한 서비스 입니다.")
							if(!confirm("로그인 하시겠습니까?")){
								return;
							}else{
								location.href = "${pageContext.request.contextPath}/Member/login";
							}
						} // end : 로그인 유무 따른 예외처리
					}) // end : 좌석 버튼 클릭 이벤트
				} // end : 비즈니스석 선택
				
				// 퍼스트석 선택
				if(seat.firstseat != null){
					var pFs = seat.firstseatprice;
					price = pFs;
           			pFs = AmountCommas(pFs)+'원';
					$("#ticketPrice").html(pFs);
					var fs = seat.firstseat;
					var split_fs = fs.split(',');
					var str = '';
           			for(var i=0; i<split_fs.length; i++){
						for(var j=0; j<seatList.length; j++) {
							if(split_fs[i] == seatList[j].seat_name ) {
								str += "<button style='padding: 15px; margin: 5px;' id='BookSeat'>" + split_fs[i] + "</button>"
								i++;
							}
						}
						str += "<button style='padding: 15px; margin: 5px;' id='noneBookSeat' data-idx="+split_fs[i]+">" + split_fs[i] + "</button>"
					}
					div.html(str);
					// 좌석 버튼 클릭 이벤트
					$(".choiceSeat button").on("click", function() {
						var seat_fs = $(this).data("idx");
						// 로그인 유무 따른 예외처리
						if(m_idx.val() != ""){
							alert("선택한 좌석 번호 : " + seat_fs);
							// 예약을 위한 정보 생성
							rstr += "<input type='hidden' name='m_idx' value=" + m_idx.val() + ">";
							rstr += "<input type='hidden' name='date_idx' value=" + date_idx.val() + ">";
							rstr += "<input type='hidden' name='flight_name' value=" + flight_name.val() + ">";
							rstr += "<input type='hidden' name='seat_name' value=" + seat_fs + ">";
							rstr += "<input type='hidden' name='ticket_price' value=" + price + ">";
							$("#reservationForm").html(rstr);
							// 결제하기 버튼 클릭 이벤트
							$("#payBtn").on("click", function() {
								$("#reservationForm").submit();
							}) // end : 결제하기 버튼 클릭 이벤트
						}else {
							alert("로그인이 필요한 서비스 입니다.")
							if(!confirm("로그인 하시겠습니까?")){
								return;
							}else{
								location.href = "${pageContext.request.contextPath}/Member/login";
							}
						} // end : 로그인 유무 따른 예외처리
					}) // end : 좌석 버튼 클릭 이벤트
				} // end : 퍼스트석 선택
				
			}) // end : 이미 선택된 좌석정보 출력
			
		}) // end : 해당 항공편의 좌석정보 출력
		
		// 뒤로가기 버튼 클릭 이벤트
		$("#goBackBtn").on("click", function() {
			history.back();
		}) // end : 뒤로가기 버튼 클릭 이벤트
		
	}) // end : onload
	
</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>