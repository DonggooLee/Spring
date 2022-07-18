<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html class="dohyun">
<head>
<script
  src="https://code.jquery.com/jquery-3.6.0.js"
  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
  crossorigin="anonymous"></script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<title>Home</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/defalut.css">
	<script src="https://kit.fontawesome.com/2b055b9edf.js" crossorigin="anonymous"></script>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/resources/css/dohyun.css">
<link rel="stylesheet"  href="${pageContext.request.contextPath}/resources/css/modal.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-pen.css" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">
<body class="d-body">
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
							<li class="menu5"><a href='/flight/scheduleList'>항공권</a>
								<ul class="menu5_submenu">
									<li><a href='/flight/scheduleBook'>예약조회</a>
								</ul>
							</li>
							<li class="menu2"><a href="/text/list">커뮤니티</a></li>
							<li class="menu4"><a href='/pakage/P_pakageMain'>패키지</a></li>
							<li class="menu5"><a href="/notice/ntList">고객센터</a>
								<ul class="menu5_submenu">
									<li><a href='/notice/ntList'>공지사항</a></li>
									<li><a href='/freq/list'>자주찾는질문</a></li>
									<li><a href='/obo/list'>일대일문의</a></li>
								</ul>
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</header>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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