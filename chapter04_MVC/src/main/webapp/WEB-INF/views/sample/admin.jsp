<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>/sample/admin Page</h1>
	
	<!-- principal : 
	디테일서비스 객체 세션처럼 한번 저장되면 시큐리티 객체를 사용하면된다 + 서버 단에서도 사용이 가능하다 시큐리티 정보가 담긴다! 
	-->
	<p> principal : <sec:authentication property="principal"/></p>
	<p> memberVO : <sec:authentication property="principal.member"/></p>
	<p> 사용자 이름 : <sec:authentication property="principal.member.userName"/></p>
	<p> 사용자 아이디 : <sec:authentication property="principal.member.userid"/></p>
	<p> 사용자 비밀번호 : <sec:authentication property="principal.member.userpw"/></p>
	<p> 사용자 권한 리스트 : <sec:authentication property="principal.member.authList"/></p>
	
	<a href="/customLogout">로그아웃</a>
	
</body>
</html>