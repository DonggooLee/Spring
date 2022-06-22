<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div{
		border: 1px solid black;
		margin: auto;
	}
	button {
		background-color: white;
		padding: 20px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

	<h1> 좌석 예매 페이지 </h1>
	
	<div>
		<table>
			<c:forEach var="list" items="${getSchedule}">
				<!-- 좌석이 없을 경우 seat_choice 값이 0-->
				<c:if test="${list.seat_choice eq 0}">
					없음
				</c:if>
				<!-- 좌석이 있을 경우 seat_choice 값이 1-->
				<c:if test="${list.seat_choice eq 1}">
					<!-- 선택한 좌석과 항공편에 일치하는 좌석 만 출력 -->
					<c:if test="${list.seat_grade eq seat_grade}">
						<tr>
							<td class="seatBox">
								<button data-idx="${list.seat_idx}" name="seat_idx">${list.seat_name}</button>
								<!-- 데이터 이동을 위한 값들 -->
							<td>
						</tr>
					</c:if>
				</c:if>
			</c:forEach>
		</table>
	</div>
	
	<form action="reservationConfirm" method="post" id="myForm">
		<input type="hidden" name="date_idx" value="${date_idx}">
		<input type="hidden" name="seat_grade" value="${seat_grade}">
		<input type="hidden" name="flight_name" value="${flight_name}">
	</form>
	
<script type="text/javascript">

	$(function() {
		
		var seatBox = $(".seatBox");
		var str = '';
		
		// 좌석 버튼 클릭 이벤트
		seatBox.find("button[name='seat_idx']").on("click", function() {
			var seat_idx = $(this).data("idx")
			str += "<input type='hidden' name='seat_idx' value=" + seat_idx + ">";
			$("#myForm").append(str)
			$("#myForm").submit()
		}) // end : 좌석 버튼 클릭 이벤트 종료
		
	}) // end : onload

</script>
</body>
</html>