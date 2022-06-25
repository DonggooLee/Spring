<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
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
                     <input type="text" value="검색">
                  </div>
                  <ul class="user">
					<c:if test="${empty loginPublicInfo == empty loginCorpInfo }">
							<li><button class="btn04" id="loginBtn">로그인</button></li>
							<li><button class="btn03" id="joinBtn">회원가입</button></li>
					</c:if>
					</ul>
					<ul class="user">
						<c:if test="${not empty loginPublicInfo || not empty loginCorpInfo }">
							<li><button class="btn04" id="myPageBtn">마이페이지</button></li>
							<li>
								<button class="btn03" id="logoutBtn">로그아웃</button>
							</li>
						</c:if>
					</ul>
              </div>
            </div>
            <div class="bottomHead">
               <nav>
                  <ul>
                     <li><a href='/flight/scheduleListPage'>항공권</a></li>
                     <li><a href='/flight/reservationConfirmPage'>예약조회</a></li>
                     <li><a href='/flight/scheduleManagerPage'>항공권 관리 페이지</a></li>
                     <li><a href='/pakage/P_pakageMain'>패키지</a></li>
                     <li><a href="/notice/list">고객센터</a></li>
                  </ul>
               </nav>
            </div>
         </div>
      </header>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script type="text/javascript">
      $(function() {
			$("#loginBtn").click(function() {
				location.href = "/userP/login";
			});
			$("#joinBtn").click(function() {
				location.href = "/KingTrip/join";
			});
			$("#logoutBtn").click(function() {
				location.href = "/logout";
			});
			$("#myPageBtn").click(function() {
				location.href = "/KingTrip/myPage";
			});
		});
      </script>