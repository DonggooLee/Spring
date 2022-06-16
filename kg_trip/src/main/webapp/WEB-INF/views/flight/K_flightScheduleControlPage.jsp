<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<title>Home</title>
<link rel="stylesheet" type="text/css" href="/resources/css/default.css">
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont">
		
			<form action="" style="border: 1px solid black; width: 300px; margin: auto; margin-top: 100px;">
				<table>
					<tr>
						<th>항공사</th>
						<td>
							<!-- 둘 중 하나 선택  -->
							<!-- <fieldset>
								<legend>항공사</legend>
								<input type="checkbox" name="region" value="1">대한항공<br>
								<input type="checkbox" name="region" value="2">아시아나<br>
								<input type="checkbox" name="region" value="3">진에어<br>
								<input type="checkbox" name="region" value="4">제주항공<br>
								<input type="checkbox" name="region" value="5">에어서울<br>
								<input type="checkbox" name="region" value="6">에어부산<br>
								<input type="checkbox" name="region" value="7">티웨이항공<br>
							</fieldset> -->
							<select name="air_idx">
								<option value="1">대한항공</option>
								<option value="2">아시아나</option>
								<option value="3">진에어</option>
								<option value="4">제주항공</option>
								<option value="5">에어서울</option>
								<option value="6">에어부산</option>
								<option value="7">티웨이항공</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>항공편명</th>
						<td>
							<!-- 항공편명 보여주기? -->
							<input type="text" name="flight_name">
						</td>
					</tr>
					<tr>
						<th>비행일자</th>
						<td>
							<input type="date" name="start_date">
						</td>
					</tr>
					<tr>
						<th>탑승시각</th>
						<td>
							<input type="text" name="boarding_time" placeholder="YYYY-MM-DD HH:MM">
						</td>
					</tr>
					<tr>
						<th>출발시각</th>
						<td>
							<input type="text" name="depart_time" placeholder="YYYY-MM-DD HH:MM">
						</td>
					</tr>
					<tr>
						<th>도착시각</th>
						<td>
							<input type="text" name="arrive_time" placeholder="YYYY-MM-DD HH:MM">
						</td>
					</tr>
					<tr>
						<th>출발공항</th>
						<td>
							<select name="air_idx_s">
								<option value="1">인천(ICN)</option>
								<option value="2">제주(CJU)</option>
								<option value="3">부산(PUS)</option>
								<option value="4">청주(CJJ)</option>
								<option value="5">여수(RSU)</option>
								<option value="6">광주(KWJ)</option>
								<option value="7">대구(TAE)</option>
								<option value="8">김포(GMP)</option>
								<option value="9">양양(YNY)</option>
								<option value="10">군산(KUV)</option>
								<option value="11">울산(USN)</option>
								<option value="12">포항(KPO)</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>도착공항</th>
						<td>
							<select name="air_idx_d">
								<option value="1">인천(ICN)</option>
								<option value="2">제주(CJU)</option>
								<option value="3">부산(PUS)</option>
								<option value="4">청주(CJJ)</option>
								<option value="5">여수(RSU)</option>
								<option value="6">광주(KWJ)</option>
								<option value="7">대구(TAE)</option>
								<option value="8">김포(GMP)</option>
								<option value="9">양양(YNY)</option>
								<option value="10">군산(KUV)</option>
								<option value="11">울산(USN)</option>
								<option value="12">포항(KPO)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;"><input type="submit" value="일정추가"></td>
					</tr>
				</table>
			</form>
		
		</section>
		
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>