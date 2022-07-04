<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont2">
			<div class="all" style="display: flex;">
				<jsp:include page="/WEB-INF/views/include/adminMenuBar.jsp"></jsp:include>
				<div class="content_section" style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
					<div class="dashboard" style=" margin : 10px; background-color: white; /* display: flex; */ flex-wrap: wrap;
						justify-content: space-around;">
						<div class="visitor" style="width: 40%">
							<h1> 방문자 현황 </h1>
							<div>
							</div>
						</div>
						<div class="member"  style="width: 40%">
							<h1> 가입자 현황 </h1>
							<div>
							</div>
						</div>
						<div class="qna">
							<h1> 1:1 문의 </h1>
							<div>
							</div>
						</div>
						<div class="report">
							<h1> 신고 게시글 </h1>
							<div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
