<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont2">
			<div class="all" style="display: flex;">
				<jsp:include page="/WEB-INF/views/include/adminMenuBar.jsp"></jsp:include>
				<div class="content_section" style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
					<div class="content" style=" margin : 10px; background-color: white;">
						<h1 style="border-bottom: 1px solid #e9e9e9;">개인 회원 목록</h1>
							<div>
								리스트 촤르륵
							</div>
					</div>
				</div>
			</div>
		
		</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
