<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<footer>
	<ul class="user">
		<c:if test="${empty loginPublicInfo == empty loginCorpInfo == empty loginAdminInfo }">
			<li><button class="btn03" id="adminloginBtn">관리자 로그인</button></li>
		</c:if>
	</ul>
	<ul class="user">
		<c:if test="${not empty loginAdminInfo }">
			<li><button class="btn04" id="adminPageBtn">관리자페이지</button></li>
			<li>
				<button class="btn03" id="adminlogoutBtn">로그아웃</button>
			</li>
		</c:if>
	</ul>
	<div class="a">
		<ul>
			<li><span>고객지원실 운영안내</span></li>
			<li>연중무휴 09:00-18:00 (점심시간 12:00-13:00)</li>
			<li>주말/공휴일 포함, 한국시간 기준</li>
			<li>※ 항공권 환불/변경은 평일 09:00-17:00 접수 가능</li>
			<li>유선상담 02-000-0000</li>
		</ul>
	</div>
	<p class="b">@ 2022 TeamProject.</p>
</footer>
</div>
<script type="text/javascript">
			$(function() {
				$("#adminloginBtn").click(function() {
					location.href = "/admin/login";
				});
				$("#adminlogoutBtn").click(function() {
					location.href = "/logout";
				});
				$("#adminPageBtn").click(function() {
					location.href = "/KingTrip/myPage";
				});

			});
		</script>

</body>
</html>