<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont">

	<h1>기업 회원가입</h1>

	<form action="/Member/join/joinFormC" method="post" role="form">
		<fieldset id="userinfo">
			<legend>기업회원 정보 입력</legend>
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" placeholder="최소 5자 이상의 ID를 만드세요."
						name="c_id" id="c_id"></td>
					<td><div class="check_font" id="id_check"></div></td>
					<td><input type="hidden" class="doublecheck_font" id="id_doublecheck"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" placeholder="최소 7자 이상의 비밀번호를 만드세요."
						name="c_pw" id="c_pw"></td>
					<td>
						<div class="check_font" id="pw_check"></div>
						<input type="hidden" class="doublecheck_font" id="pw_doublecheck">
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="c_pwcheck" id="c_pwcheck">
					</td>
					<td>
						<div class="check_font" id="pwcheck_check"></div>
						<input type="hidden" class="doublecheck_font" id="pwcheck_doublecheck">
					</td>
				</tr>
				<tr>
					<td>담당자 이름</td>
					<td><input type="text" name="c_dname" id="c_dname"></td>
					<td>
						<div class="check_font" id="dname_check"></div>
						<input type="hidden" class="doublecheck_font" id="dname_doublecheck">
					</td>
				</tr>
				<tr>
					<td>담당자 휴대폰 번호</td>
					<td><input type="text" name="c_dphone" id="c_dphone">
					</td>
					<td><div class="check_font" id="dphone_check"></div></td>
					<td><input type="hidden" class="doublecheck_font" id="dphone_doublecheck"></td>
				</tr>
				<tr>
					<td>담당자 이메일</td>
					<td><input type="text" name="c_demail" id="c_demail">
					</td>
					<td><div class="check_font" id="demail_check"></div></td>
					<td><input type="hidden" class="doublecheck_font" id="demail_doublecheck"></td>
				</tr>
				<tr>
					<td>기업 명</td>
					<td><input type="text" name="c_name" id="c_name"></td>
					<td>
						<div class="check_font" id="name_check"></div>
						<input type="hidden" class="doublecheck_font" id="name_doublecheck">
					</td>
				</tr>
				<tr>
					<td>사업자등록번호</td>
					<td><input type="text" name="c_code" id="c_code"></td>
					<td>
						<div class="check_font" id="code_check"></div>
						<input type="hidden" class="doublecheck_font" id="code_doublecheck">
					</td>
				</tr>
				<tr>
					<td>기업 소개 (<p class="textCount">0자</p><p class="textTotal">/500자</p>)</td>
					<td><textarea rows="5" cols="50" name="c_intro" id="c_intro" style="resize: none;" maxlength="500"></textarea>
					</td>
					<td>
						<div class="check_font" id="intro_check"></div>
					</td>
					<td>
						<input type="hidden" class="doublecheck_font" id="intro_doublecheck">
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<input type="text" name="c_zipcode" id="c_zipcode" placeholder="우편번호" readonly="readonly">
						<input type="button" onclick="execDaumPostcode()"value="우편번호 찾기">
					</td>
				</tr>
				<tr>
					<td> </td>
					<td>
						<input type="text" name="address" id="address" placeholder="주소" readonly="readonly">
						<input type="text" name="detailaddress" id="detailaddress" placeholder="상세주소">
					</td>
						<td><div class="check_font" id="address_check"></div></td>
						<td><input type="hidden" class="doublecheck_font" id="address_doublecheck"></td>
				</tr>
				<tr>
					<td>기업 유형</td>
					<td><select name="c_type" id="c_type">
							<option value="">유형을 선택해주세요
							<option value="100">항공사
							<option value="200">여행사
					</select></td>
					<td><div class="check_font" id="type_check"></div></td>
				</tr>
			</table>
			<table class="c_type">
			</table>
		</fieldset>


		<div class="btnWrap"
			style="width: calc(100% - 20px); margin: 20px 0; padding: 0 20px 0 0; padding-right: 20px; text-align: right;">
			<button class="btn01" id="corpJoinBtn">회원가입</button>
		</div>
	</form>
</section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('c_zipcode').value = data.zonecode;
                document.getElementById("address").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailaddress").focus();
            }
        }).open();
    }
</script>
<script>
	//아이디 정규식
	var idJ = /^[A-za-z0-9]{5,20}$/g;
	// 비밀번호 정규식
	var pwJ = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	// 이름 정규식
	var nameJ = /^[가-힣]{2,10}$/;
	// 이메일 검사 정규식
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]$/i;
	// 휴대폰 번호 정규식
	var phoneJ = /^01([0|1|6|7|8|9])([0-9]{8})$/;
	// 숫자를 제외한 정규식
	var nocodeJ = /[^0-9]/g;
	// 숫자 10자리만 입력할수있는 정규식 
	var codeJ = /^([0-9]{10})$/;
	// 특수문자 정규식
	var aircodeJ = /[^\w\sㄱ-힣]|[\_]/g;
	
	// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
	$("#c_id").blur(function() {
					var c_id = $('#c_id').val();
						$.ajax({url : '${pageContext.request.contextPath}/Member/corp/idCheckC?c_id='+ c_id,
									type : 'get',
									success : function(data) {
										console.log("1 = 중복o / 0 = 중복x : "+ data);
										if (data == 1) {
											// 1 : 아이디가 중복되는 문구
											$("#id_check").text("사용중인 아이디입니다.");
											$("#id_check").css("color", "red");
											$("#id_doublecheck").val("false");
										} else {
											if (idJ.test(c_id)) {
												// 0 : 아이디 길이 / 문자열 검사
												$("#id_check").text("사용가능한 아이디입니다.");
												$("#id_check").css("color","green");
												$("#id_doublecheck").val("true");
											} else {
												$('#id_check').text("5~20자의 영문,숫자만 사용 가능합니다.");
												$('#id_check').css('color','red');
												$("#id_doublecheck").val("false");
											}
										}
									},
									error : function() {
										console.log("실패");
									}
								});
					});
	// 이메일 유효성 검사(1 = 중복 / 0 != 중복)
	$("#c_demail").blur(function() {
		var c_demail = $('#c_demail').val();
						$.ajax({url : '${pageContext.request.contextPath}/Member/corp/demailCheckC?c_demail='+ c_demail,
									type : 'get',
									success : function(data) {
										console.log("1 = 중복o / 0 = 중복x : "+ data);
										if (data == 1) {
											// 1 : 아이디가 중복되는 문구
											$("#demail_check").text("사용중인 이메일 주소입니다.");
											$("#demail_check").css("color","red");
											$("#demail_doublecheck").val("false");
										} else {
											if (mailJ.test(c_demail)) {
												// 0 : 아이디 길이 / 문자열 검사
												$("#demail_check").text("사용가능한 이메일주소입니다.");
												$("#demail_check").css("color","green");
												$("#demail_doublecheck").val("true");
											} else if (c_demail == "") {
												$('#demail_check').text('이메일 주소를 입력해주세요.');
												$('#demail_check').css('color','red');
												$("#demail_doublecheck").val("false");

											} else {
												$('#demail_check').text("이메일 주소에 '@'와 '.'를 포함해주세요");
												$('#demail_check').css('color','red');
												$("#demail_doublecheck").val("false");
											}
										}
									},
									error : function() {
										console.log("실패");
									}
								});
					});
	// 휴대번호
	$("#c_dphone").blur(function() {
		var c_dphone = $('#c_dphone').val();
		$.ajax({url : '${pageContext.request.contextPath}/Member/corp/dphoneCheckC?c_dphone='+ c_dphone,
				type : 'get',
				success : function(data) {
				console.log("1 = 중복o / 0 = 중복x : "+ data);
							if (data == 1) {
								// 1 : 아이디가 중복되는 문구
								$("#dphone_check").text("사용중인 전화번호 입니다.");
								$("#dphone_check").css("color","red");
								$("#dphone_doublecheck").val("false");
							} else {
								if (phoneJ.test(c_dphone)) {
									// 0 : 아이디 길이 / 문자열 검사
									$("#dphone_check").text("사용가능한 전화번호 입니다.");
									$("#dphone_check").css("color","green");
									$("#dphone_doublecheck").val("true");
								} else if (c_dphone == "") {
									$('#dphone_check').text('휴대폰 번호를 입력해주세요.');
									$('#dphone_check').css('color', 'red');
									$("#dphone_doublecheck").val("false");

								} else {
									$('#dphone_check').text("'-'없이 숫자 10자리를 입력하세요.");
									$('#dphone_check').css('color','red');
									$("#dphone_doublecheck").val("false");
								}
							}
				},
				error : function() {
					console.log("실패");
				}
		});
	});
	//기업 유형별 aircode가 있없
	$("#c_type").on("change",function() {
						var str = "";
						if ($("#c_type").val() == 100) {
							str += "<tr><td>항공 코드 </td><td><input type='text' name='c_aircode' id='c_aircode'></td></tr>";
							str += "<td><div class='check_font' id='aircode_check'></div></td>";
							str += "<td><input type='hidden' class='doublecheck_font' id='aircode_doublecheck'></td>";
							$(".c_type").append(str);
							//항공코드 유효성
							$("#c_aircode").on("keyup",function() {
								$("#c_aircode").val($("#c_aircode").val().replace(aircodeJ, ""));
							});
							$("#c_aircode").on("blur",function() {
								if($("#c_aircode").val() == ""){
									console.log('빈칸');
									$('#aircode_check').text('항공코드를 입력해주세요');
									$('#aircode_check').css('color', 'red');
									$("#aircode_doublecheck").val("false");
								}else{
									$('#aircode_check').text('');
									$("#aircode_doublecheck").val("true");
								}
							});
						} else {
							$(".c_type").empty();
						}
						
						if ($(this).val() != "") {
							$("#type_check").text('');
						}
					});
					
	// 이름에 특수문자 들어가지 않도록 설정
	$("#c_dname").blur(function() {
		if (nameJ.test($(this).val())) {
			console.log(nameJ.test($(this).val()));
			$("#dname_check").text('');
			$("#dname_doublecheck").val("true");
		} else if($(this).val() == "") {
			$('#dname_check').text('이름을 입력하세요.');
			$('#dname_check').css('color', 'red');
			$("#dname_doublecheck").val("false");
		}else{
			$('#dname_check').text('한글로만 입력하세요');
			$('#dname_check').css('color', 'red');
			$("#dname_doublecheck").val("false");
		}
	});
	// 비밀번호 정규식 체크
	$("#c_pw").blur(function() {
		if (pwJ.test($(this).val())) {
			console.log(pwJ.test($(this).val()));
			$("#pw_check").text('');
			$("#pw_doublecheck").val("true");
		} else {
			$('#pw_check').text('8~16자 영문, 숫자, 특수문자를 입력하세요.');
			$('#pw_check').css('color', 'red');
			$("#pw_doublecheck").val("false");
		}
	});
	//비밀번호 체크
	$("#c_pwcheck").blur(function() {
		var c_pw = $('#c_pw').val();
		var c_pwcheck = $('#c_pwcheck').val();

		console.log(c_pw);
		console.log(c_pwcheck);

		if (c_pwcheck == "") {
			$('#pwcheck_check').text('비밀번호를 확인해주세요.');
			$('#pwcheck_check').css('color', 'red');
			$("#pwcheck_doublecheck").val("false");
		} else if (c_pw == c_pwcheck) {
			$("#pwcheck_check").text('비밀번호가 일치합니다.');
			$("#pwcheck_check").css("color","green");
			$("#pwcheck_doublecheck").val("true");
		} else {
			$('#pwcheck_check').text('비밀번호가 일치하지 않습니다.');
			$('#pwcheck_check').css('color', 'red');
			$("#pwcheck_doublecheck").val("false");
		}
	});
	// 주소 유효성
	$("#c_zipcode").on("click",function() {
			execDaumPostcode()
	});

	$("#detailaddress").on("blur",function() {
		if ($(this).val() == "") {
			$('#address_check').text('상세주소를 입력해주세요.');
			$('#address_check').css('color', 'red');
			$("#address_doublecheck").val("false");	
		}else{
			$("#address_check").text('');
			$("#address_doublecheck").val("true");
		}
	});
	
	// 기업명
	$("#c_name").blur(function() {
		if ($(this).val() != "") {
			$("#name_check").text('');
			$("#name_doublecheck").val("true");
		} else {
			$('#name_check').text('기업명을 입력해주세요');
			$('#name_check').css('color', 'red');
			$("#name_doublecheck").val("false");
		}
	});
	
	// 사업자등록번호
	$("#c_code").on("keyup",function() {
		$(this).val($(this).val().replace(nocodeJ, ""));
	});
	
	$("#c_code").blur(function() {
		if($(this).val() == ""){
			$('#code_check').text('사업자등록번호를 입력해주세요');
			$('#code_check').css('color', 'red');
			$("#code_doublecheck").val("false");
		}else if(codeJ.test($(this).val())){
			$("#code_check").text('');
			$("#code_doublecheck").val("true");
		}else{
			$('#code_check').text('사업자등록번호 10자리를 입력해주세요');
			$('#code_check').css('color', 'red');
			$("#code_doublecheck").val("false");
		}
	});
	
	// 기업소개
	$("#c_intro").blur(function() {
		if ($(this).val() == "") {
			$('#intro_check').text('기업소개를 입력해주세요');
			$('#intro_check').css('color', 'red');
			$("#intro_doublecheck").val("false");
		}
	});
	
	// 기업소개 여기보셈
	$('#c_intro').keyup(function (e) {
		let content = $(this).val();
	    
		// 글자수 세기
	    if (content.length == 0 || content == '') {
	    	$('.textCount').text('0자');
	    } else {
	    	$('.textCount').text(content.length + '자');
	    }
		//글자 없을때
	    if (content == "") {
			$('#intro_check').text('기업소개를 입력해주세요');
			$('#intro_check').css('color', 'red');
			$("#intro_doublecheck").val("false");
		}
	 	// 글자수 이상
	    if (content.length < 10) {
	        // 10자 안넘으면 알림창 뜨도록
	        $('#intro_check').text('기업소개는 10자 이상 입력가능합니다.');
			$('#intro_check').css('color', 'red');
	        $("#intro_doublecheck").val("false");
	    }else{
	    	$('#intro_check').text('');
	    	$("#intro_doublecheck").val("true");
	    }
	    // 글자수 제한
	    if (content.length > 500) {
	    	// 200자 부터는 타이핑 되지 않도록
	        $(this).val($(this).val().substring(0, 500));
	        $('.textCount').text(500 + '자');
	        // 200자 넘으면 알림창 뜨도록
	        alert('글자수는 500자까지 입력 가능합니다.');
	    };
	});
	
	// 입력되어 있는게 없을때, 회원가입 버튼을 누를시
	$("#corpJoinBtn").on("click",function(){
		if($("#c_type").val() != 100){
			if($("#id_doublecheck").val() == "true" && $("#demail_doublecheck").val() == "true"
				&& $("#dphone_doublecheck").val() == "true" && $("#c_type").val() != ""
				&& $("#dname_doublecheck").val() == "true" && $("#pw_doublecheck").val() == "true"
				&& $("#pwcheck_doublecheck").val() == "true" && $("#name_doublecheck").val() == "true"
				&& $("#code_doublecheck").val() == "true" && $("#intro_doublecheck").val() == "true"
				&& $("#address_doublecheck").val() == "true"){
			alert("회원가입을 환영합니다.");
			}else{
				alert("회원가입을 완료할 수 없습니다. 입력정보를 다시 한 번 확인해주십시오.");
				if($("#id_doublecheck").val() != "true"){
					$('#id_check').text('아이디 정보를 확인해주세요.');
					$("#id_check").css("color", "red");
				}
				if($("#demail_doublecheck").val() != "true"){
					$('#demail_check').text('이메일 정보를 확인해주세요.');
					$("#demail_check").css("color", "red");
				}
				if($("#dphone_doublecheck").val() != "true"){
					$('#dphone_check').text('전화번호 정보를 확인해주세요.');
					$("#dphone_check").css("color", "red");
				}
				if($("#c_type").val() == ""){
					$('#type_check').text('기업유형을 선택해주세요.');
					$("#type_check").css("color", "red");
				}
				if($("#dname_doublecheck").val() != "true"){
					$('#dname_check').text('담당자 이름 정보를 확인해주세요.');
					$("#dname_check").css("color", "red");
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
					$('#name_check').text('기업 이름 정보를 확인해주세요.');
					$("#name_check").css("color", "red");
				}
				if($("#code_doublecheck").val() != "true"){
					$('#code_check').text('사업자등록번호 정보를 확인해주세요.');
					$("#code_check").css("color", "red");
				}
				if($("#intro_doublecheck").val() != "true"){
					$('#intro_check').text('기업소개 정보를 확인해주세요.');
					$("#intro_check").css("color", "red");
				}
				if($("#address_doublecheck").val() != "true"){
					$('#address_check').text('주소 정보를 확인해주세요.');
					$("#address_check").css("color", "red");
				}
				return false
			}
		}else{
			if($("#id_doublecheck").val() == "true" && $("#demail_doublecheck").val() == "true"
					&& $("#dphone_doublecheck").val() == "true" && $("#c_type").val() != ""
					&& $("#dname_doublecheck").val() == "true" && $("#pw_doublecheck").val() == "true"
					&& $("#pwcheck_doublecheck").val() == "true" && $("#name_doublecheck").val() == "true"
					&& $("#code_doublecheck").val() == "true" && $("#intro_doublecheck").val() == "true"
					&& $("#address_doublecheck").val() == "true" && $("#aircode_doublecheck").val() == "true"){
				alert("회원가입을 환영합니다.");
			}else{
				alert("회원가입을 완료할 수 없습니다. 입력정보를 다시 한 번 확인해주십시오.");
				if($("#id_doublecheck").val() != "true"){
					$('#id_check').text('아이디 정보를 확인해주세요.');
					$("#id_check").css("color", "red");
				}
				if($("#demail_doublecheck").val() != "true"){
					$('#demail_check').text('이메일 정보를 확인해주세요.');
					$("#demail_check").css("color", "red");
				}
				if($("#dphone_doublecheck").val() != "true"){
					$('#dphone_check').text('전화번호 정보를 확인해주세요.');
					$("#dphone_check").css("color", "red");
				}
				if($("#c_type").val() == ""){
					$('#type_check').text('기업유형을 선택해주세요.');
					$("#type_check").css("color", "red");
				}
				if($("#dname_doublecheck").val() != "true"){
					$('#dname_check').text('담당자 이름 정보를 확인해주세요.');
					$("#dname_check").css("color", "red");
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
					$('#name_check').text('기업 이름 정보를 확인해주세요.');
					$("#name_check").css("color", "red");
				}
				if($("#code_doublecheck").val() != "true"){
					$('#code_check').text('사업자등록번호 정보를 확인해주세요.');
					$("#code_check").css("color", "red");
				}
				if($("#intro_doublecheck").val() != "true"){
					$('#intro_check').text('기업소개 정보를 확인해주세요.');
					$("#intro_check").css("color", "red");
				}
				if($("#address_doublecheck").val() != "true"){
					$('#address_check').text('주소 정보를 확인해주세요.');
					$("#address_check").css("color", "red");
				}
				if($("#aircode_doublecheck").val() != "true"){
					$('#aircode_check').text('항공코드 정보를 확인해주세요.');
					$("#aircode_check").css("color", "red");
				}
				return false
			}
		}
	})
	
</script>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



