<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>

<h1>
	Hello world!  
</h1>

<h2>기업회원 일정 관리</h2>
<form action="flight/scheduleManagerPage" method="get">
	<input type="submit" value="기업회원 일정 관리">
</form>

<hr>

<h2>일반회원 항공편 조회</h2>
<form action="flight/scheduleListPage" method="get">
	<input type="submit" value="일반회원 항공편 조회">
</form>

</body>
</html>
