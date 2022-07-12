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
							
				<div class="scheduleManager" style="border: 1px solid black; width: 700px; padding: 30px">
				
					<h1 style="text-align: center;">${loginCorpInfo.c_name} 항공편 일정 관리</h1>
					
					<br>
					
					<div class="listSchedule">
						
					</div>
					
					<!-- 항공편 일정을 가져오기 위한 데이터 객체 -->
					<input type="hidden" name="c_aircode" value="${loginCorpInfo.c_aircode}">
					
				</div> <!-- end : scheduleInsert -->
							
			</div> <!-- end : content -->
		</div> <!-- end : content_section -->
	</div> <!-- end : all -->
	
</section>

<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 일정 수정 팝업
		function updatePopup(date_idx) {
		    var popUrl = "scheduleUpdatePage?date_idx=" + date_idx;
		    var popOption = "top=100, left=100, width=500, height=500";
		    window.open(popUrl, "", popOption);
		}
		
		// 일정 조회를 위한 항공사 코드
		var c_aircode = $(".scheduleManager").find("input[name='c_aircode']").val();
		
		// 일정 조회 (관리자 계정의 항공사 코드와 일치하는 일정만 출력)
		listSchedule(c_aircode, function(listSchedule) {
			if(listSchedule.length != 0){
				var str = '';
				str += "<table>";
				str += "<tr>";
				str += "<th>일정번호</th>";
				str += "<th>항공편명</th>";
				str += "<th>비행일자</th>";
				str += "<th>탑승시각</th>";
				str += "<th>출발시각</th>";
				str += "<th>도착시각</th>";
				str += "<th>출발공항</th>";
				str += "<th>도착공항</th>";
				str += "<th>수정</th>";
				str += "<th>삭제</th>";
				str += "</tr>";
				for(var i=0; i<listSchedule.length; i++){
					str += "<tr>";
					str += "<td>" + listSchedule[i].date_idx + "</td>";
					str += "<td>" + listSchedule[i].flight_name + "</td>";
					str += "<td>" + displayTime(listSchedule[i].start_date) + "</td>";
					str += "<td>" + listSchedule[i].boarding_time + "</td>";
					str += "<td>" + listSchedule[i].depart_time + "</td>";
					str += "<td>" + listSchedule[i].arrive_time + "</td>";
					str += "<td>" + listSchedule[i].ap_name_d + "</td>";
					str += "<td>" + listSchedule[i].ap_name_a + "</td>";
					str += "<td><button id='updateBtn' data-idx='"+listSchedule[i].date_idx+"'>수정</button></td>";
					str += "<td><button id='deleteBtn' data-idx='"+listSchedule[i].date_idx+"'>삭제</button></td>";
					str += "</tr>";
				}
				$(".listSchedule").html(str);
				// 수정 버튼 클릭 이벤트
				$(".listSchedule #updateBtn").on("click", function() {
					var date_idx = $(this).data("idx");
					updatePopup(date_idx);
				}) // end : 수정 버튼 클릭 이벤트
				// 삭제 버튼 클릭 이벤트
				$(".listSchedule #deleteBtn").on("click", function() {
					var date_idx = $(this).data("idx");
					if(confirm("일정을 삭제하시겠습니까?")){
						$.ajax({
							type : 'delete',
							url : '/flightManager/deleteSchedule/' + date_idx,
							success : function(result) {
								alert("정상적으로 삭제 되었습니다!")
								location.href = "${pageContext.request.contextPath}/flight/scheduleManagerPage";
							}
						})
					}else{
						return;
					}
				}) // end : 삭제 버튼 클릭 이벤트
			}else{
				$(".listSchedule").html("<h1>일정이 존재 하지 않습니다!</h1>")
			} // end : else
		}) // end : 일정 조회
		
	}) // end : onload

</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>