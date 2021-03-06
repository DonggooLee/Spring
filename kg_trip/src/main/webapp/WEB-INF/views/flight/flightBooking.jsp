<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
	
	<section class="cont">
	
		<h1>카카오페이 결제성공 페이지! (예약완료)</h1>
		<br>
		<div>
			<h2 id="bookIdx"></h2>
			<br>
			<table class="bookInfo" style="padding: 20px; border: 1px solid black;">
			
			</table>
		</div>
		<br>
		<div>
			<button id="mainBtn">메인페이지</button>
			&nbsp;
			<button id="refundBtn">항공권 환불</button>
		</div>
		
	</section>

<style>
	tr, th, td{ 
		padding: 10px;
	}
</style>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	// URL 로 부터 Parameter 뽑기
	var getParam = function(key){        
		var _parammap = {};        
		document.location.search.replace(/\??(?:([^=]+)=([^&]*)&?)/g, function () {
			function decode(s) {                
					return decodeURIComponent(s.split("+").join(" "));
			}             
			_parammap[decode(arguments[1])] = decode(arguments[2]);
		});         
		return _parammap[key];   
	}; // end : getParam
	
	var reservation_idx = getParam("reservation_idx")
	console.log("예약번호 : " + reservation_idx)
	
	$(function() {
		
		$.ajax({
			type : 'get',
			url : '/flightManager/myReservation/' + reservation_idx,
			success : function(info) {
				var str = '';
				// 정보가 있을 경루
				if(info != ""){
					str += "<tr><th colspan='2'>예약 정보</th></tr>";
					str += "<tr><th>성 명</th><td>" + info.m_name + "</td></tr>";
					str += "<tr><th>성 별</th><td>" + info.m_gender + "</td></tr>";
					str += "<tr><th>항공편명</th><td>" + info.flight_name + "</td></tr>";
					str += "<tr><th>비행일자</th><td>" + displayTime(info.start_date) + "</td></tr>";
					str += "<tr><th>탑승시각</th><td>" + info.boarding_time + "</td></tr>";
					str += "<tr><th>출발시각</th><td>" + info.depart_time + "</td></tr>";
					str += "<tr><th>도착시각</th><td>" + info.arrive_time + "</td></tr>";
					str += "<tr><th>출발공항</th><td>" + info.ap_name_d + "</td></tr>";
					str += "<tr><th>도착공항</th><td>" + info.ap_name_a + "</td></tr>";
					str += "<tr><th>좌석번호</th><td>" + info.seat_name + "</td></tr>";
					str += "<tr><th>예매가격</th><td>" + info.ticket_price + "</td></tr>";
					$(".bookInfo").html(str)
				}else{
					$(".bookInfo").html("<h2>정보가 존재하지 않습니다.</h2>")
				}
			}
		}) // end : ajax()
		
		// 예약 번호 붙이기
		$("#bookIdx").html("예약번호 : " + reservation_idx)
		
		// 메인페이지 버튼 클릭 이벤트
		$("#mainBtn").on("click", function() {
			location.href = "/KingTrip/main";
		}) // end : 메인페이지 버튼 클릭 이벤트
		
		// 환불하기 버튼 클릭 이벤트
		$("#refundBtn").on("click", function() {
			if(confirm("정말 환불하시겠습니까?")){
				// 확인 클릭 시 : 항공권 환불
				/* refundReservation(reservation_idx, function(result) {
					if(result == "success"){
						alert("환불이 정상적으로 완료됐습니다.")
						location.href = "/KingTrip/main";
					}else{
						alert("삭제에 실패 하였습니다.")
						return;
					}
					${pageContext.request.contextPath}/flight
				}) */
				alert("환불 버튼 클릭 이벤트")
			}else{
				// 취소 클릭 시
				return;
			}
		}) // end : 환불하기 버튼 클릭 이벤트
		
	}) // end : onload
	
</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>