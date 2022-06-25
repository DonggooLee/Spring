<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont">
			
			<h1>기업 회원가입</h1>

	<form action="/KingTrip/join/joinFormC" method="post" role="form">
		<fieldset id="userinfo">
			<legend>기업회원 정보 입력</legend>
				<table>
					<tr>
						<td>아이디 </td>
						<td>
							<input type="text" placeholder="최소 5자 이상의 ID를 만드세요." name="c_id" id="c_id">
						</td>
						<td><div class="check_font" id="id_check"></div></td>
					</tr>
					<tr>
						<td>비밀번호 </td>
						<td>
							<input type="password" placeholder="최소 7자 이상의 비밀번호를 만드세요." name="c_pw">
						</td>
					</tr>
					<tr>
						<td>비밀번호 확인 </td>
						<td>
							<input type="password" name="c_pwcheck">
						</td>
					</tr>
					<tr>
						<td>담당자 이름</td>
						<td>
							<input type="text" name="c_dname">
						</td>
					</tr>
					<tr>
						<td>담당자 휴대폰 번호 </td>
						<td>
							<input type="text" name="c_dphone">
						</td>
					</tr>
					<tr>
						<td>담당자 이메일 </td>
						<td>
							<input type="text" name="c_demail">
						</td>
					</tr>
					<tr>
						<td>기업 이름 </td>
						<td>
							<input type="text" name="c_name">
						</td>
					</tr>
					<tr>
						<td>우편번호 </td>
						<td>
							<input type="text" name="c_zipcode">
						</td>
					</tr><tr>
						<td>주소 </td>
						<td>
							<input type="text" name="c_address">
						</td>
					</tr>
					<tr>
						<td>기업 소개 </td>
						<td>
							<textarea rows="5" cols="50" name="c_intro"></textarea>
						</td>
					</tr>
					<tr>
						<td>사업자등록번호</td>
						<td>
							<input type="text" name="c_code">
						</td>
					</tr>
					<tr>
						<td>기업 유형</td>
						<td>
							<select name="c_type">
								<option value=""> 유형을 선택해주세요
								<option value="100"> 항공권
								<option value="200"> 패키지여행
							</select>
						</td>
					</tr>
						
				</table>
		</fieldset>


		<div class="btnWrap"
			style="width: calc(100% - 20px); margin: 20px 0; padding: 0 20px 0 0; padding-right: 20px; text-align: right;">
			<button class="btn01">회원가입</button>
		</div>

		</form>
			
			
		
		</section>
		
		<script>
// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
	$("#c_id").blur(function() {
		// id = "id_reg" / name = "userId"
		alert($('#c_id').val());
		var c_id = $('#c_id').val();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/KingTrip/corp/idCheckC?c_id='+c_id,
			type : 'get',
			success : function(data) {
				console.log("1 = 중복o / 0 = 중복x : "+ data);							
				
				if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다 :p");
						$("#id_check").css("color", "red");
					} else {
						if(c_id == ""){
							$('#id_check').text('아이디를 입력해주세요 :)');
							$('#id_check').css('color', 'red');
						}
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
</script>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
