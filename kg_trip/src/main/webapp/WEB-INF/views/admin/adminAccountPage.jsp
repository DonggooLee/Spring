<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont2">
			<div class="all" style="display: flex;">
				<jsp:include page="/WEB-INF/views/include/adminMenuBar.jsp"></jsp:include>
				<div class="content_section" style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
					<div class="admin_account_inner" style="display: flex; flex-direction: column; text-align: center; background: white; margin: 15px;">
							<div class="Profile">
								<img alt="이미지" src="/img/cat.png" style="width: 70px; height: 70px;
								border-radius: 70%; overflow: hidden; border: 1px solid black;">
							</div>
							<div class="introduction">
								<ul style="padding: 0;">
									<li> 아이디 : ${loginPublicInfo.m_id } </li>
									<li>닉네임 : ${loginPublicInfo.m_nickname } </li>
									<li>이름 : ${loginPublicInfo.m_name } </li>
									<li>이메일 : ${loginPublicInfo.m_email } </li>
									<li>휴대폰 번호 : ${loginPublicInfo.m_phone } </li>
									<li>자기소개 : ${loginPublicInfo.m_intro } </li>
								</ul>
							</div>
							<div class="setting" style="border: 1px solid; margin: 10px;">
								<ul>
									<li><button>휴대폰 번호 변경</button></li>
									<li><button>비밀번호 변경</button></li>
									<li><button>회원탈퇴</button></li>
								</ul>
							</div>
						</div>
				</div>
			</div>
		
		</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
