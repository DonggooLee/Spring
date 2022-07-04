<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont2">
	<div class="all" style="display: flex;">
		<jsp:include page="/WEB-INF/views/include/adminMenuBar.jsp"></jsp:include>
		<div class="content_section"
			style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
			<div class="content" style="margin: 10px; background-color: white;">
				<h1 style="border-bottom: 1px solid #e9e9e9;">기업 회원 목록</h1>


				<div>
					<table style="background-color: white">
						<tr>
							<td>아이디</td>
							<td>기업명</td>
							<td>담당자 이름</td>
							<td>담당자 이메일</td>
							<td>구분</td>
							<td></td>
						</tr>
						<c:choose>
							<c:when test="${not empty corpList }">
								<c:forEach var="corpList" items="${corpList }">
									<tr>
										<td><c:out value="${corpList.c_id}"></c:out></td>
										<td><c:out value="${corpList.c_name}"></c:out></td>
										<td><c:out value="${corpList.c_dname}"></c:out></td>
										<td><c:out value="${corpList.c_demail}"></c:out></td>
										<td>
											<c:if test="${corpList.c_auth == 'corp'}">
												기업회원
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<h5>기업 회원이 없습니다.</h5>
							</c:otherwise>
						</c:choose>
					</table>
				</div>



			</div>
		</div>
	</div>

</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



