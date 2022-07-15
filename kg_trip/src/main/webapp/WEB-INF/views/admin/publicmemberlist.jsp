<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<style>
	.publicInfoTable td{
	text-align: center;
	}
	.pinfo{
	width: 100px;
	text-align: center;
	border: none;
	font-size: 16px;
	}
</style>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<section class="cont2">
	<form>
	<div class="all" style="display: flex;">
		<jsp:include page="/WEB-INF/views/include/adminMenuBar.jsp"></jsp:include>
		<div class="content_section"
			style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
			<div class="content" style="margin: 10px; background-color: white;">
				<h1 style="border-bottom: 1px solid #e9e9e9;">개인 회원 목록</h1>
				<div style="display: flex; justify-content: space-between">
					<div style="border-bottom: 1px solid #e9e9e9;;">
						<select>
							<option value="id"> 아이디
							<option value="name"> 이름
						</select>
						<input type="text">
						<button>검색</button>
					</div>
					<div>
						<a id="authUpdate">변경</a>
						<a id="userDelete">삭제</a>
					</div>
				</div>
					<table style="background-color: white;" class="publicInfoTable" >
						<tr>
							<td colspan="2"><input type="checkbox" id="allcheckbox"></td>
							<td>아이디</td>
							<td>닉네임</td>
							<td>이름</td>
							<td>성별</td>
							<td>이메일</td>
							<td>구분</td>
							<td></td>
						</tr>
						<c:choose>
							<c:when test="${not empty publicList }">
								<c:forEach var="publicList" items="${publicList }">
									<c:if test="${publicList.m_auth == 'public'}">
									<tr>
										<td><input type="hidden" name="array_midx" id="array_midx" ></td>
										<td><input type="checkbox" class="onecheckbox" name="m_idx" value="${publicList.m_idx}"></td>
										<td><input type="text" class="pinfo" value="<c:out value="${publicList.m_id}"/>" readonly="readonly"></td>
										<td><c:out value="${publicList.m_nickname}"/></td>
										<td><c:out value="${publicList.m_name}"/></td>
										<td><c:out value="${publicList.m_gender}"/></td>
										<td><c:out value="${publicList.m_email}"/></td>
										<td>
											개인회원
										</td>
									</tr>
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<h5>개인 회원이 없습니다.</h5>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
			</div>
		</div>
	</div>
	</form>
</section>
<script type="text/javascript">
$(function() {
	$("#allcheckbox").click(function() {
		if($("#allcheckbox").is(":checked")) $(".onecheckbox").prop("checked", true);
		else $(".onecheckbox").prop("checked", false);
	});
	
	$(".onecheckbox").click(function() {
		var total = $(".onecheckbox").length;
		var checked = $(".onecheckbox:checked").length;
		
		if(total != checked) $("#allcheckbox").prop("checked", false);
		else $("#allcheckbox").prop("checked", true); 
	});
	
	$("#userDelete").click(function () {
		var checked = $(".onecheckbox:checked").length;
		var checkBoxArray = new Array();
		$("input:checkbox[name=m_idx]:checked").each(function () {
			checkBoxArray.push(this.value);
		});
		$("#array_midx").val(checkBoxArray);
		alert("회원을 삭제할까요? : " +checkBoxArray);
		
		if($('.onecheckbox').is(':checked') == false){
			alert("선택된 회원이 없습니다.");
		}else{
		$.ajax({
			url : "/Admin/pmemberDelete",
			type : "post",
			traditional : true,
			data : {"m_idx" : checkBoxArray},
			dataType: "json",
			success : function (data) {
				alert("회원을 삭제했습니다.");
				//location.reload();
				$(".publicInfoTable").load("${contextPath}/Admin/managePublic .publicInfoTable");
			}
		});
		}
	});
	
	$("#authUpdate").click(function () {
		var checked = $(".onecheckbox:checked").length;
		var checkBoxArray = new Array();
		$("input:checkbox[name=m_idx]:checked").each(function () {
			checkBoxArray.push(this.value);
		});
		$("#array_midx").val(checkBoxArray);
		alert("관리자로 변경할까요? : " +checkBoxArray);
		
		if($('.onecheckbox').is(':checked') == false){
			alert("선택된 회원이 없습니다.");
		}else{
		$.ajax({
			url : "/Admin/pmemberUpdate",
			type : "post",
			traditional : true,
			data : {"m_idx" : checkBoxArray},
			dataType: "json",
			success : function (data) {
				alert("관리자로 변경되었습니다.");
				//location.reload();
				$(".publicInfoTable").load("${contextPath}/Admin/managePublic .publicInfoTable");
			}
		});
		}
	});
});

</script>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



