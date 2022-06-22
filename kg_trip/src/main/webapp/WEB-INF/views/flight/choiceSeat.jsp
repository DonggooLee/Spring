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
			<c:if test="">
			
			</c:if>
			<c:forEach var="list" items="${getSchedule}">
				<tr>
					<td class="seatBox">
						<button data-idx="${list.seat_idx}" name="seat_idx">${list.seat_name}</button>
					<td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
</body>
<script type="text/javascript">

	$(function() {
		
		var seatBox = $(".seatBox");
		
		seatBox.find("button[name='seat_idx']").on("click", function() {
			
			alert("버튼 클릭 이벤트 ! idx 값 : " + $(this).data("idx"))
			
		});
		
	}) // end : onload

</script>
</html>