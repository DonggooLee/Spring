<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/corpHeader.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont2">
			<div class="all" style="display: flex;">
				<jsp:include page="/WEB-INF/views/include/corpMenuBar.jsp"></jsp:include>
				<div class="content_section" style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
					<div class="content" style=" margin : 10px; background-color: white;">
						<h1 style="border-bottom: 1px solid #e9e9e9;">계정관리</h1>
						<div class="admin_account_inner" style="display: flex; flex-direction: column; text-align: center;">
							<div class="Profile">
								사진 넣을 거임
							</div>
							<div class="introduction">
								아이디 : ${loginCorpInfo.c_id }
							</div>
							<div class="setting">
								ds
							</div>
						</div>
					</div>
				</div>
			</div>
		
		</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
