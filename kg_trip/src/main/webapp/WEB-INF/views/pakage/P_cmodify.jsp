<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>

<style type="text/css">

</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="cont">
			<div>
				<h1>관리자 패키지 등록 페이지</h1>
				<form action="uploadFormMo" method="post" enctype="multipart/form-data" class="mb-3">
					<table style="background-color: white;">
						<tr>
							<td>
								패키지 번호(스펠링3자+100자리숫자)
							</td>
							<td>
								<input type="text" name="p_num" value="${board.p_num }" readonly="readonly">
								<input type="hidden" name="c_idx" value="4">
							</td>
						</tr>
						<tr>
							<td>
								패키지 여행기간(yyyy.mm.dd ~ yyyy.mm.dd) 
							</td>
							<td>
								<input type="text" name="p_period" value="${board.p_period }">
							</td>
						</tr>
						<tr>
							<td>
								나라 
							</td>
							<td>
								<input type="text" name="p_country" value="${board.p_country }">
							</td>
						</tr>
						<tr>
							<td>
								지역1(ex)북아메리카,서유럽) 
							</td>
							<td>
								<input type="text" name="p_region1" value="${board.p_region1 }">
							</td>
						</tr>
						<tr>
							<td>
								지역2(나라명 or 지역명) 
							</td>
							<td>
								<input type="text" name="p_region2" value="${board.p_region2 }">
							</td>
						</tr>
						<tr>
							<td>
								패키지명 
							</td>
							<td>
								<input type="text" name="p_name" value="${board.p_name }">
							</td>
						</tr>
						<tr>
							<td>
								패키지 메인이미지 
							</td>
							<td>
								<input type="file" name="uploadFilea" multiple="multiple">기존파일 : <c:out value="${board.p_mainimg}"/>
							</td>
						</tr>
						 <tr>
							<td>
								패키지 이미지1 
							</td>
							<td>
								<input type="file" name="uploadFileb" multiple="multiple">기존파일 : <c:out value="${board.p_img1}"/>
							</td>
						</tr>
						<tr>
							<td>
								패키지 이미지2
							</td>
							<td>
								<input type="file" name="uploadFilec" multiple="multiple">기존파일 : <c:out value="${board.p_img2}"/>
							</td>
						</tr>
						<tr>
							<td>
								패키지 이미지3
							</td>
							<td>
								<input type="file" name="uploadFiled" multiple="multiple">기존파일 : <c:out value="${board.p_img3}"/>
							</td>
						</tr>
						<tr>
							<td>
								패키지 이미지4
							</td>
							<td>
								<input type="file" name="uploadFilee" multiple="multiple">기존파일 : <c:out value="${board.p_img4}"/>
							</td>
						</tr>
						<tr>
							<td>
								상품 정보
							</td>
							<td>
								<input type="text" name="p_information" value="${board.p_information }">
							</td>
						</tr>
						<tr>
							<td>
								이용 안내
							</td>
							<td>
								<input type="text" name="p_guide" value="${board.p_guide }">
							</td>
						</tr>
						<tr>
							<td>
								패키지 인원
							</td>
							<td>
								<input type="number" name="p_max" value="${board.p_max }">
							</td>
						</tr>
						<tr>
							<td>
								패키지 금액
							</td>
							<td>
								<input type="number" name="p_fee" value="${board.p_fee }">
								<input type="hidden" name="p_division" value="등록완료">
							</td>
						</tr>
						<tr>
							<td><button>패키지 수정</button></td>
						</tr>			
					</table>
				</form>
			</div>
		</section>
		
<script type="text/javascript">

</script>		

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>