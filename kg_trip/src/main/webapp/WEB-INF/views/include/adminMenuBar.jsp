<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>


<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<div class="menu_section" style="border: 1px solid black; width: 15%;">
					<ul style="list-style-type: none;">
						<li> </li>
						<li>대시보드</li>
						<li>회원 관리</li>
							<ul>
								<li><a href="/Admin/managePublic" >개인 회원 목록</a></li>
								<li><a href="/Admin/manageCorp" > 기업회원 목록 </a> </li>
								<li><a href="/Admin/manageAdmin" > 관리자 목록</a> </li>
							</ul>
						<li>커뮤니티 관리</li>
							<ul>
								<li> 최근 게시글 </li>
								<li> 신고 게시글 </li>
							</ul>
						<li>고객센터 관리</li>
							<ul>
								<li> 공지사항 </li>
								<li> 1:1 문의 </li>
							</ul>
						<li><a href="/Admin/adminaccount" >계정 관리</a></li>
						<li> </li>
					</ul>
				</div>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		
	
