<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>

<div class="menu_section" style="border: 1px solid black; width: 15%; margin-right: 40px">
	<ul style="list-style-type: none;">
		<li>계정관리</li>
		<li>위시리스트</li>
		<li>예약관리</li>
			<ul>
				<li><a class="move" href='/pakage/P_mlist'>패키지 예약내역</a></li>
				<li><a class="move" href='/flight/bookList'>항공권 예약내역</a></li>
			</ul>
		<li>커뮤니티</li>
			<ul>
				<li>내 게시글</li>
				<li>내 댓글 </li>
			</ul>
		<li>1:1문의</li>
	</ul>
</div>
