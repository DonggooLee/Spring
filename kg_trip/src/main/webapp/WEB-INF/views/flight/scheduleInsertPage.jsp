<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/corpHeader.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont2">

	<div class="all" style="display: flex;">
		<jsp:include page="/WEB-INF/views/include/corpMenuBar.jsp"></jsp:include>
		<div class="content_section" style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
			<div class="content" style=" margin : 10px; background-color: white;">
				<form action="#">
					<div class="scheduleInsert" style="border: 1px solid black; width: 300px; padding: 15px">
						<h1 style="text-align: center;">${loginCorpInfo.c_name} 항공편 일정 등록</h1>
						<br>
						<div>
							<div>
								<b>항공편명</b>&nbsp;&nbsp;
								<select name="flight_name" class="selectFlight">
									<option>없음</option>
								</select>
							</div>
						</div>
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
								<b>탑승시각</b>&nbsp;&nbsp;
								<input type="time" name="boarding_time">
							</div>
						</div>
						<br>
						<div>
							<div>
								<b>출발시각</b>&nbsp;&nbsp;
								<input type="time" name="depart_time">
							</div>
						</div>
						<br>
						<div>
							<div>
								<b>도착시각</b>&nbsp;&nbsp;
								<input type="time" name="arrive_time">
							</div>
						</div>
						<br>
						<div>
							<div>
								<b>출발공항</b>&nbsp;&nbsp;
								<select name="ap_idx_d" class="selectAirport_d">
									<option>없음</option>
								</select>
							</div>
						</div>
						<br>
						<div>
							<div>
								<b>도착공항</b>&nbsp;&nbsp;
								<select name="ap_idx_a" class="selectAirport_a">
									<option>없음</option>
								</select>
							</div>
						</div>
						<br>
						<div>
							<button id="cancelBtn">취소</button>
							&nbsp;
							<button id="scheduleInsertBtn">일정 추가</button>
						</div>
						<!-- 항공편 조회를 위한 데이터 -->
						<input type="hidden" name="c_aircode" value="${loginCorpInfo.c_aircode}">
					</div> <!-- end : scheduleInsert -->
				</form>
			</div> <!-- end : content -->
		</div> <!-- end : content_section -->
	</div> <!-- end : all -->
	
</section>

<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 항공편 조회에 필요한 객체
		var c_aircode = $(".scheduleInsert").find("input[name='c_aircode']").val();
		var selectFlight = $(".selectFlight");
		
		// 공항 조회에 필요한 객체
		var selectAirport_d = $(".selectAirport_d");
		var selectAirport_a = $(".selectAirport_a");
		
		// 항공편 조회 (관리자 계정의 항공사 코드와 일치하는 항공편만 출력)
		listFlight(c_aircode, function(listFlight) {
			var str = '';
			if(listFlight.length != 0){
				for(var i=0; i<listFlight.length; i++){
					str += "<option value=" + listFlight[i].flight_name + ">" + listFlight[i].flight_name + "</option>";
				}
				selectFlight.html(str)
			}else{
				selectFlight.html("<option>없음</option>")
			}
		})
		
		// 공항 조회
		listAirport(function(listAp) {
			var str = '';
			for(var i=0; i<listAp.length; i++){
				str += "<option value=" + listAp[i].ap_idx + ">" + listAp[i].ap_name_d + "</option>";
			}
			// 출발 공항
			selectAirport_d.html(str)
			// 도착 공항
			selectAirport_a.html(str)
		})
		
		// 일정 추가 버튼 객체
		var scheduleInsertBtn = $("#scheduleInsertBtn")
		
		// 일정 추가에 필요한 객체
		var schedule = $(".scheduleInsert")
		var flight_name = schedule.find("select[name='flight_name']");
		var start_date = schedule.find("input[name='start_date']"); 
		var depart_time = schedule.find("input[name='depart_time']"); 
		var arrive_time = schedule.find("input[name='arrive_time']"); 
		var boarding_time = schedule.find("input[name='boarding_time']"); 
		var ap_idx_d = schedule.find("select[name='ap_idx_d']");
		var ap_idx_a = schedule.find("select[name='ap_idx_a']");

		// 일정 추가 버튼 클릭 이벤트
		scheduleInsertBtn.on("click", function() {
			if(flight_name.val() == "없음"){
				alert("잘못된 접근 입니다. (기업회원 전용)")
			}else if (start_date.val() == "") {
				alert("비행일자를 입력해 주세요")
			}else if(boarding_time.val() == ""){
				alert("탑승시각을 입력해 주세요")
			}else if(depart_time.val() == ""){
				alert("출발시각을 입력해 주세요")
			}else if(arrive_time.val() == ""){
				alert("도착시각을 입력해 주세요")
			}else if (ap_idx_d.val() == ap_idx_a.val()) {
				alert("출발공항과 도착공항을 다르게 입력해 주세요")
			}else if(depart_time.val() >= arrive_time.val()){
				alert("출발시각이 도착시각과 같거나 늦게 설정 되었습니다.")	
			}else{
				// 항공편 일정 추가
				insertSchedule({flight_name:flight_name.val(), start_date:start_date.val(), boarding_time:boarding_time.val(), c_aircode:c_aircode,
					depart_time:depart_time.val(), arrive_time:arrive_time.val(), ap_idx_d:ap_idx_d.val(), ap_idx_a:ap_idx_a.val()}, 
					function(result) {
						alert("일정이 정상적으로 추가되었습니다!")
						console.log(result)
				}) // end : 항공편 일정 추가
			}
		}) // end : 일정 추가 버튼 클릭 이벤트 종료

		// 취소 버튼 클릭 이벤트
		$("#cancelBtn").on("click", function(e) {
			e.preventDefault();
			location.href = "${pageContext.request.contextPath}/Partner/corpPage";
		}) // end : 취소 버튼 클릭 이벤트
		
	}) // end : onload

</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>