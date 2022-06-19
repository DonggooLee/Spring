<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<table>
			<thead>
				<tr>
					<th>이름</th>
					<th>성별</th>
					<th>항공편명</th>
					<th>좌석이름</th>
					<th>좌석등급</th>
					<th>공항명</th>
					<th>출발시각</th>
					<th>도착시각</th>
					<th>탑승시각</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="flight" items="${list}">
					<tr>
						<td>${flight.m_name}</td>
						<td>${flight.m_gender}</td>
						<td>${flight.flight_name}</td>
						<td>${flight.seat_name}</td>
						<td>${flight.seat_grade}</td>
						<td>${flight.ap_name}</td>
						<td><fmt:formatDate value="${flight.depart_time}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td><fmt:formatDate value="${flight.arrive_time}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td><fmt:formatDate value="${flight.boarding_time}" pattern="yyyy-MM-dd HH:mm"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>
	
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
