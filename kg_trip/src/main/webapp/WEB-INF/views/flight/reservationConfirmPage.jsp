<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>예약 조회</h1>

	<form action="myReservation" method="post">
		<div>
			<fieldset style="width: 500px;">
				<div>
					<label>예약번호 또는 항공권 번호</label>
					<input type="text" placeholder="예약번호 또는 항공권 번호" name="ticket_idx">
				</div>
				<br>
				<div>
					<label>탑승일</label>
					<input type="date" placeholder="탑승일(YYYY.MM.DD.)" name="start_date">
				</div>
				<br>
				<div>
					<label>승객명</label>
					<input type="text" placeholder="승객명" name="m_name">
				</div>
				<br>
				<div>
					<input type="submit" value="조회">
				</div>
			</fieldset>
		</div>
	</form>

</body>
</html>