<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<title>Home</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/defalut.css">
<body>
	<div class="container">
		<header>
			<div class="headerWrap">
				<div class="topHead">
					<div class="logo">청춘트립</div>
					<div class="test">
						<div class="search">
							<input type="text" value="검색" style="width: 200px; height: 25px; border-radius: 15px; border: 1px solid;">
						</div>
						<ul class="user">
							<c:if test="${empty loginPublicInfo == empty loginCorpInfo }">
								<li><button class="btn04" id="loginBtn">로그인</button></li>
								<li><button class="btn03" id="joinBtn">회원가입</button></li>
							</c:if>
							<c:if
								test="${loginPublicInfo.m_auth == 'public'}">
								<li>${loginPublicInfo.m_id } 님 </li>
								<li><a href='/Traveler/myPage'>마이페이지</a></li>
								<li><button class="btn03" id="logoutBtn">로그아웃</button></li>
							</c:if>
							<c:if
								test="${loginPublicInfo.m_auth == 'admin'}">
								<li>${loginPublicInfo.m_id } 님 </li>
								<li><a href='/Admin/adminPage'>관리자 페이지</a></li>
								<li><button class="btn03" id="logoutBtn">로그아웃</button></li>
							</c:if>
							<c:if
								test="${not empty loginCorpInfo }">
								<li>${loginCorpInfo.c_id } 님 </li>
								<li><a href='/Partner/corpPage'>기업 페이지</a></li>
								<li><button class="btn03" id="logoutBtn">로그아웃</button></li>
							</c:if>
						</ul>
					</div>
				</div>
				<div class="bottomHead">
					<nav>
						<ul class="main_menubar">
							<li class="menu1"><a href='/flight/scheduleList'>항공권</a></li>
							<li class="menu2"><a href='/flight/scheduleBookPage'>예약조회</a></li>
							<li class="menu3"><a href='/flight/scheduleManagerPage'>항공권 관리</a></li>
							<li class="menu4"><a href='/pakage/P_pakageMain'>패키지</a></li>
							<li class="menu5"><a href="/notice/list">고객센터</a>
								<ul class="menu5_submenu">
									<li>공지사항</li>
									<li>자주찾는질문</li>
									<li>1:1문의</li>
								</ul>
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</header>
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script type="text/javascript">
			$(function() {
				$("#loginBtn").click(function() {
					location.href = "/Member/login";
				});
				$("#joinBtn").click(function() {
					location.href = "/Member/join";
				});
				$("#logoutBtn").click(function() {
					location.href = "/Member/logout";
				});
				// 로고 클릭시 메인 페이지 이동
	             $(".logo").click(function() {
	               location.href = "/KingTrip/main";
	            });
			});
		</script>