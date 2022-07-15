<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<<style>
	#mail_check_input_box_false{
    background-color:#ebebe4;
	}
	 
	#mail_check_input_box_true{
	    background-color:white;
	}
	.correct{
	    color : green;
	}
	.incorrect{
	    color : red;
	}
</style>

<section class="cont">

	<h1>개인 회원가입</h1>

	<form action="/Member/join/joinFormP" method="post" role="form">
		<fieldset id="userinfo">
			<legend>개인회원 정보 입력</legend>
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="m_id" id="m_id"></td>
					<td>
						<div class="check_font" id="id_check"></div>
						<input type="hidden" class="doublecheck_font" id="id_doublecheck">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" placeholder="최소 7자 이상의 비밀번호를 만드세요."
						name="m_pw" id="m_pw"></td>
					<td> 
						<div class="check_font" id="pw_check"></div>
						<input type="hidden" class="doublecheck_font" id="pw_doublecheck">
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="m_pwcheck" id="m_pwcheck"></td>
					<td>
						<div class="check_font" id="pwcheck_check"></div>
						<input type="hidden" class="doublecheck_font" id="pwcheck_doublecheck">
					</td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" name="m_nickname" id="m_nickname"></td>
					<td> 
						<div class="check_font" id="nickname_check"></div>
						<input type="hidden" class="doublecheck_font" id="nickname_doublecheck">
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="m_name" id="m_name"></td>
					<td> 
						<div class="check_font" id="name_check"></div>
						<input type="hidden" class="doublecheck_font" id="name_doublecheck">
					</td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td>
						<input type="text" name="birthYear" placeholder="년(예 2022)" id="birthYear">
					</td>
					<td>
						<select name="birthMonth" id="birthMonth">
							<option value="">월
							<option value="01">01
							<option value="02">02
							<option value="03">03
							<option value="04">04
							<option value="05">05
							<option value="06">06
							<option value="07">07
							<option value="08">08
							<option value="09">09
							<option value="10">10
							<option value="11">11
							<option value="12">12
						</select>
						<select name="birthDate" id="birthDate">
							<option value="">일
						</select>
					</td>
					<td>
						<div class="check_font" id="birth_check"></div>
						<input type="hidden" class="doublecheck_font" id="birth_doublecheck">
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" name="m_gender" id="m_gender" value="male" checked="checked">남
						<input type="radio" name="m_gender" id="m_gender" value="female">여
					</td>
				</tr>
				<tr>
					<td>휴대폰 번호</td>
					<td><input type="text" name="m_phone" id="m_phone"></td>
					<td>
						<div class="check_font" id="phone_check"></div>
						<input type="hidden" class="doublecheck_font" id="phone_doublecheck">
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<div class="mail_input_box">
							<input class="mail_input" type="text" name="m_email" id="m_email">
						</div>
					</td>
					<td>
						<div class="check_font" id="email_check"></div>
						<input type="hidden" class="doublecheck_font" id="email_doublecheck">	
					</td>
				</tr>
				<tr>
					<td>
						<div class="mail_check_wrap">
							<div class="mail_check_input_box" id="mail_check_input_box_false">
								<input class="mail_check_input" disabled="disabled">
								<input type="hidden" class="doublecheck_font" id="mail_check_doublecheck">
							</div>
							<div class="mail_check_button">
								<span>인증번호 전송</span>
							</div>
							<div class="clearfix"></div>
							<span id="mail_check_input_box_warn"></span>
						</div>
					</td>				
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
						$("#id_doublecheck").val("false");
					} else {
						if(idJ.test(m_id)){
							// 0 : 아이디 길이 / 문자열 검사
							$("#id_check").text("사용가능한 아이디입니다.");
							$("#id_check").css("color","green");
							$("#id_doublecheck").val("true");
				
						} else if(m_id == ""){
							
							$('#id_check').text('아이디를 입력해주세요.');
							$('#id_check').css('color', 'red');
							$("#id_doublecheck").val("false");			
						} else {
							$('#id_check').text("5~20자의 영문 대 소문자,숫자만 사용 가능합니다.");
							$('#id_check').css('color', 'red');
							$("#id_doublecheck").val("false");
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
							$("#email_check").text("사용중인 이메일 주소입니다.");
							$("#email_check").css("color", "red");
							$("#email_doublecheck").val("false");
					} else {
							if(mailJ.test(m_email)){
								// 0 : 아이디 길이 / 문자열 검사
								$("#email_check").text("사용가능한 이메일 주소입니다.");
								$("#email_check").css("color","green");
								$("#email_doublecheck").val("true");
					
							} else if(m_email == ""){
								
								$('#email_check').text('이메일을 입력해주세요.');
								$('#email_check').css('color', 'red');
								$("#email_doublecheck").val("false");		
								
							} else {
								
								$('#email_check').text("이메일 주소를 다시 확인해주세요.");
								$('#email_check').css('color', 'red');
								$("#email_doublecheck").val("false");
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
								$("#phone_doublecheck").val("false");
							} else {
								if(phoneJ.test(m_phone)){
									// 0 : 아이디 길이 / 문자열 검사
									$("#phone_check").text("사용가능한 전화번호 입니다.");
									$("#phone_check").css("color","green");
									$("#phone_doublecheck").val("true");
								} else if(m_phone == ""){
									$('#phone_check').text('휴대폰 번호를 입력해주세요.');
									$('#phone_check').css('color', 'red');
									$("#phone_doublecheck").val("false");				
								} else {
									$('#phone_check').text("'-'없이 숫자 10자리를 입력하세요.");
									$('#phone_check').css('color', 'red');
									$("#phone_doublecheck").val("false");
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
					$("#name_doublecheck").val("true");
			} else {
				$('#name_check').text('이름을 확인해주세요');
				$('#name_check').css('color', 'red');
				$("#name_doublecheck").val("false");
			}
		});
		// 비밀번호 정규식 체크
		$("#m_pw").blur(function() {
			if (pwJ.test($(this).val())) {
					console.log(pwJ.test($(this).val()));
					$("#pw_check").text('');
					$("#pw_doublecheck").val("true");
			} else {
				$('#pw_check').text('8~16자 영문, 숫자, 특수문자를 사용하세요.');
				$('#pw_check').css('color', 'red');
				$("#pw_doublecheck").val("false");	
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
				$("#pwcheck_doublecheck").val("false");	
			}else if (m_pw == m_pwcheck) {
					$("#pwcheck_check").text('');
					$("#pwcheck_doublecheck").val("true");
			}else {
				$('#pwcheck_check').text('비밀번호가 일치하지 않습니다.');
				$('#pwcheck_check').css('color', 'red');
				$("#pwcheck_doublecheck").val("false");
			}
		});
		
		// 생년월일 일
		$("#birthMonth,#birthYear").on("change",function(){
			var str = "";
			var birthyear = $("#birthYear").val();
			var birthmonth = $("#birthMonth").val();
			var birthdate = $("#birthDate").val();
			var today = new Date(); // 날짜 변수 선언
			var yearNow = today.getFullYear(); // 올해 연도 가져옴
			
			if(birthyear == ""){
				birthdate = "";
				$('#birth_check').text('년도를 입력해주세요.');
				$('#birth_check').css('color', 'red');
				$("#birth_doublecheck").val("false");
			}else if(birthmonth == ""){
				birthdate = "";
				$('#birth_check').text('월을 입력해주세요.');
				$('#birth_check').css('color', 'red');
				$("#birth_doublecheck").val("false");
			}else{
				if (1900 > birthyear || birthyear > yearNow){
					birthdate = "";
				} else if (birthmonth < 1 || birthmonth > 12) {
					birthdate = "";
					
				} else if ((birthmonth==04 || birthmonth==06 || birthmonth==09 || birthmonth==11)) {
					str += "<option value=''>일";
					for(var i=1; i<31; i++){
						if(i < 10){
							str += "<option value="+0+i+">"+0+i;
						}else{
							str += "<option value="+i+">"+i;
						}
					}
				}else if (birthmonth == 2) {
					var isleap = (birthyear % 4 == 0 && (birthyear % 100 != 0 || birthyear % 400 == 0));
					if (isleap) {
						str += "<option value=''>일";
						for(var i=1; i<30; i++){
							str += "<option value="+i+">"+i;
						}
					} else {
						str += "<option value=''>일";
						for(var i=1; i<29; i++){
							str += "<option value="+i+">"+i;
						}
					} 
				} else {
					str += "<option value=''>일";
					for(var i=1; i<32; i++){
						if(i < 10){
							str += "<option value="+0+i+">"+0+i;
						}else{
							str += "<option value="+i+">"+i;
						}
					}
				}
				$("#birthDate").html(str);
				$('#birth_check').text('');
			}
		});
		
		$("#birthDate").on("blur",function () {
			var birthdate = $("#birthDate").val();
			
			if(birthdate == ""){
				$('#birth_check').text('일를 선택해주세요.');
				$('#birth_check').css('color', 'red');
				$("#birth_doublecheck").val("false");
			}else{
				$('#birth_check').text('');
				$("#birth_doublecheck").val("true");
			}
		});
		
		// 닉네임 유효성 검사(1 = 중복 / 0 != 중복)
		$("#m_nickname").blur(function() {
			// id = "id_reg" / name = "userId"
			var m_nickname = $('#m_nickname').val();
			
			$.ajax({
				url : '${pageContext.request.contextPath}/Member/public/nicknameCheckP?m_nickname='+ m_nickname,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복o / 0 = 중복x : "+ data);							
					
					if (data == 1) {
							// 1 : 아이디가 중복되는 문구
							$("#nickname_check").text("사용중인 닉네임입니다.");
							$("#nickname_check").css("color", "red");
							$("#nickname_doublecheck").val("false");
						} else {
							if(m_nickname == ""){
								$('#nickname_check').text('닉네임을 입력해주세요.');
								$('#nickname_check').css('color', 'red');
								$("#nickname_doublecheck").val("false");			
							}else{
								$("#nickname_check").text("사용가능한 닉네임입니다.");
								$("#nickname_check").css("color","green");
								$("#nickname_doublecheck").val("true");
							}
						}
					}, error : function() {
							console.log("실패");
					}
				});
			});
		
		var code = "";	//이메일전송 인증번호 저장위한 코드
		/* 인증번호 이메일 전송 */
		$(".mail_check_button").click(function(){
		    
			var email = $(".mail_input").val();
			var cehckBox = $(".mail_check_input");        // 인증번호 입력란
		    var boxWrap = $(".mail_check_input_box");    // 인증번호 입력란 박스
			
			$.ajax({
		        type:"get",
		        url:"${pageContext.request.contextPath}/Member/public/mailCheck?email=" + email,
		        success:function(data){
		        	console.log("data : " + data);
		        	cehckBox.attr("disabled",false);
		        	boxWrap.attr("id", "mail_check_input_box_true");
		        	code = data;
		        }
		    });
		});
		
		/* 인증번호 비교 */
		$(".mail_check_input").blur(function(){
			var inputCode = $(".mail_check_input").val();        // 입력코드    
		    var checkResult = $("#mail_check_input_box_warn");    // 비교 결과
		    
		    if(inputCode == code){                            // 일치할 경우
		        checkResult.html("인증번호가 일치합니다.");
		        checkResult.attr("class", "correct");
		        $("#mail_check_doublecheck").val("true");
		    } else {                                            // 일치하지 않을 경우
		        checkResult.html("인증번호를 다시 확인해주세요.");
		        checkResult.attr("class", "incorrect");
		        $("#mail_check_doublecheck").val("false");
		    }
		    
		});
		
		// 입력되어 있는게 없을때, 회원가입 버튼을 누를시
		$("#publicJoinBtn").on("click",function(){
			if($("#id_doublecheck").val() == "true" && $("#pw_doublecheck").val() == "true"
					&& $("#pwcheck_doublecheck").val() == "true" && $("#name_doublecheck").val() == "true"
					&& $("#nickname_doublecheck").val() == "true" && $("#birth_doublecheck").val() == "true"
					&& $("#phone_doublecheck").val() == "true" && $("#email_doublecheck").val() == "true"
					&& $("#mail_check_doublecheck").val() == "true"){
				alert("회원가입을 환영합니다.");
			}else{
				alert("회원가입을 완료할 수 없습니다. 입력정보를 다시 한 번 확인해주십시오.");
				if($("#id_doublecheck").val() != "true"){
					$('#id_check').text('아이디 정보를 확인해주세요.');
					$("#id_check").css("color", "red");
				}
				if($("#pw_doublecheck").val() != "true"){
					$('#pw_check').text('비밀번호 정보를 확인해주세요.');
					$("#pw_check").css("color", "red");
				}
				if($("#pwcheck_doublecheck").val() != "true"){
					$('#pwcheck_check').text('비밀번호 확인 정보를 확인해주세요.');
					$("#pwcheck_check").css("color", "red");
				}
				if($("#name_doublecheck").val() != "true"){
					$('#name_check').text('이름 정보를 확인해주세요.');
					$("#name_check").css("color", "red");
				}
				if($("#nickname_doublecheck").val() != "true"){
					$('#nickname_check').text('닉네임 정보를 확인해주세요.');
					$("#nickname_check").css("color", "red");
				}
				if($("#birth_doublecheck").val() != "true"){
					$('#birth_check').text('생일 정보를 확인해주세요.');
					$("#birth_check").css("color", "red");
				}
				if($("#phone_doublecheck").val() != "true"){
					$('#phone_check').text('전화번호 정보를 확인해주세요.');
					$("#phone_check").css("color", "red");
				}
				if($("#email_doublecheck").val() != "true"){
					$('#email_check').text('이메일 정보를 확인해주세요.');
					$("#email_check").css("color", "red");
				}
				return false
			}
		})
		
</script>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



