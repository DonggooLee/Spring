<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont">

	<h1>개인 회원가입</h1>

	<form action="/Member/join/joinFormP" method="post" role="form">
		<fieldset id="userinfo">
			<legend>개인회원 정보 입력</legend>
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="m_id" id="m_id"></td>
					<td><div class="check_font" id="id_check"></div></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" placeholder="최소 7자 이상의 비밀번호를 만드세요."
						name="m_pw" id="m_pw"></td>
					<td> 
						<div class="check_font" id="pw_check"></div>
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="m_pwcheck" id="m_pwcheck"></td>
					<td>
						<div class="check_font" id="pwcheck_check"></div>
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="m_name" id="m_name"></td>
					<td> 
						<div class="check_font" id="name_check"></div>
					</td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td>
						<input type="number" name="m_birth" placeholder="YYYYDDMM" id="m_birth">
					</td>
					<td>
						<div class="check_font" id="birth_check"></div>
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td><input type="radio" name="m_gender" value="male">남
						<input type="radio" name="m_gender" value="female">여</td>
				</tr>
				<tr>
					<td>휴대폰 번호</td>
					<td><input type="text" name="m_phone" id="m_phone"></td>
					<td><div class="check_font" id="phone_check"></div></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="m_email" id="m_email"></td>
					<td><div class="check_font" id="email_check"></div></td>
				</tr>

			</table>
		</fieldset>


		<div class="btnWrap" style="width: calc(100% - 20px); margin: 20px 0; padding: 0 20px 0 0; padding-right: 20px; text-align: right;">
			<button class="btn01" id="publicJoinBtn">회원가입</button>
		</div>

	</form>


</section>

<script>

	//모든 공백 체크 정규식
	var empJ = /\s/g;
	//아이디 정규식
	var idJ = /^[A-za-z0-9]{5,20}$/g;
	// 비밀번호 정규식
	var pwJ = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	// 이름 정규식
	var nameJ = /^[가-힣]{2,10}$/;
	// 이메일 검사 정규식
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]$/i;
	// 휴대폰 번호 정규식
	var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	
	// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
	$("#m_id").blur(function() {
		// id = "id_reg" / name = "userId"
		var m_id = $('#m_id').val();
		
		$.ajax({
			url : '${pageContext.request.contextPath}/Member/public/idCheckP?m_id='+ m_id,
			type : 'get',
			success : function(data) {
				console.log("1 = 중복o / 0 = 중복x : "+ data);							
				
				if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다.");
						$("#id_check").css("color", "red");
						$("#publicJoinBtn").attr("disabled", true);
					} else {
						if(idJ.test(m_id)){
							// 0 : 아이디 길이 / 문자열 검사
							$("#id_check").text("");
							$("#publicJoinBtn").attr("disabled", false);
				
						} else if(m_id == ""){
							
							$('#id_check').text('아이디를 입력해주세요.');
							$('#id_check').css('color', 'red');
							$("#publicJoinBtn").attr("disabled", true);				
							
						} else {
							
							$('#id_check').text("5~20자의 영문 대 소문자,숫자만 사용 가능합니다.");
							$('#id_check').css('color', 'red');
							$("#publicJoinBtn").attr("disabled", true);
						}

					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
		
		// 이메일 유효성 검사(1 = 중복 / 0 != 중복)
		$("#m_email").blur(function() {
			// id = "id_reg" / name = "userId"
			var m_email = $('#m_email').val();
			
			$.ajax({
				url : '${pageContext.request.contextPath}/Member/public/emailCheckP?m_email='+ m_email,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복o / 0 = 중복x : "+ data);							
					
					if (data == 1) {
							// 1 : 아이디가 중복되는 문구
							$("#email_check").text("사용중인 이메일입니다.");
							$("#email_check").css("color", "red");
							$("#publicJoinBtn").attr("disabled", true);
					} else {
							if(mailJ.test(m_email)){
								// 0 : 아이디 길이 / 문자열 검사
								$("#email_check").text("");
								$("#publicJoinBtn").attr("disabled", false);
					
							} else if(m_email == ""){
								
								$('#email_check').text('이메일을 입력해주세요.');
								$('#email_check').css('color', 'red');
								$("#publicJoinBtn").attr("disabled", true);				
								
							} else {
								
								$('#email_check').text("이메일 주소를 다시 확인해주세요.");
								$('#email_check').css('color', 'red');
								$("#publicJoinBtn").attr("disabled", true);
							}

						}
					}, error : function() {
							console.log("실패");
					}
				});
			});
			
			// 핸드폰 유효성 검사(1 = 중복 / 0 != 중복)
			$("#m_phone").blur(function() {
				// id = "id_reg" / name = "userId"
				var m_phone = $('#m_phone').val();
				
				$.ajax({
					url : '${pageContext.request.contextPath}/Member/public/phoneCheckP?m_phone='+ m_phone,
					type : 'get',
					success : function(data) {
						console.log("1 = 중복o / 0 = 중복x : "+ data);							
						
						if (data == 1) {
								// 1 : 아이디가 중복되는 문구
								$("#phone_check").text("사용중인 휴대폰 번호 입니다.");
								$("#phone_check").css("color", "red");
								$("#publicJoinBtn").attr("disabled", true);
							} else {
								if(phoneJ.test(m_phone)){
									// 0 : 아이디 길이 / 문자열 검사
									$("#phone_check").text("");
									$("#publicJoinBtn").attr("disabled", false);
						
								} else if(m_phone == ""){
									
									$('#phone_check').text('휴대폰 번호를 입력해주세요.');
									$('#phone_check').css('color', 'red');
									$("#publicJoinBtn").attr("disabled", true);				
									
								} else {
									
									$('#phone_check').text("정확한 휴대폰 번호를 입력해주세요.");
									$('#phone_check').css('color', 'red');
									$("#publicJoinBtn").attr("disabled", true);
								}

							}
						}, error : function() {
								console.log("실패");
						}
					});
				});
		
		// 이름에 특수문자 들어가지 않도록 설정
		$("#m_name").blur(function() {
			if (nameJ.test($(this).val())) {
					console.log(nameJ.test($(this).val()));
					$("#name_check").text('');
			} else {
				$('#name_check').text('이름을 확인해주세요');
				$('#name_check').css('color', 'red');
				$("#publicJoinBtn").attr("disabled", true);	
			}
		});
		// 비밀번호 정규식 체크
		$("#m_pw").blur(function() {
			if (pwJ.test($(this).val())) {
					console.log(pwJ.test($(this).val()));
					$("#pw_check").text('');
			} else {
				$('#pw_check').text('8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.');
				$('#pw_check').css('color', 'red');
				$("#publicJoinBtn").attr("disabled", true);	
			}
		});
		//비밀번호 체크
		$("#m_pwcheck").blur(function() {
			var m_pw = $('#m_pw').val();
			var m_pwcheck = $('#m_pwcheck').val();
			
			console.log(m_pw);
			console.log(m_pwcheck);
			
			if(m_pwcheck == ""){
				$('#pwcheck_check').text('입력한 비밀번호를 확인해주세요.');
				$('#pwcheck_check').css('color', 'red');
				$("#publicJoinBtn").attr("disabled", true);	
			}else if (m_pw == m_pwcheck) {
					$("#pwcheck_check").text('');
			}else {
				$('#pwcheck_check').text('비밀번호가 일치하지 않습니다.');
				$('#pwcheck_check').css('color', 'red');
				$("#publicJoinBtn").attr("disabled", true);	
			}
		});

</script>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



