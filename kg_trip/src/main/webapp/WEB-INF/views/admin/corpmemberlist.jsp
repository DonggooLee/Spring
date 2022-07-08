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
				<div style="display: flex; justify-content: space-between">
					<div style="border-bottom: 1px solid #e9e9e9;">
						<select>
							<option value="id">아이디
							<option value="name">이름
						</select> <input type="text">
						<button>검색</button>
					</div>
					<div>
						<a id="userDelete">삭제</a>
					</div>
				</div>

				<div>
					<table style="background-color: white" class="corpInfoTable">
						<tr>
							<td colspan="2"><input type="checkbox" id="allcheckbox"></td>
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
										<td><input type="hidden" name="array_cidx" id="array_cidx"></td>
										<td><input type="checkbox" class="onecheckbox" name="c_idx" value="${corpList.c_idx}"></td>
										<td><c:out value="${corpList.c_id}"></c:out></td>
										<td><c:out value="${corpList.c_name}"></c:out></td>
										<td><c:out value="${corpList.c_dname}"></c:out></td>
										<td><c:out value="${corpList.c_demail}"></c:out></td>
										<td><c:if test="${corpList.c_auth == 'corp'}">
												기업회원
											</c:if></td>
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
		$("input:checkbox[name=c_idx]:checked").each(function () {
			checkBoxArray.push(this.value);
		});
		$("#array_cidx").val(checkBoxArray);
		alert("형님 이녀석 없애버릴까요? : " +checkBoxArray);
		
		if($('.onecheckbox').is(':checked') == false){
			alert("선택된 회원이 없습니다.");
		}else{
		$.ajax({
			url : "/Admin/corpDelete",
			type : "post",
			traditional : true,
			data : {"c_idx" : checkBoxArray},
			dataType: "json",
			success : function (data) {
				alert("형님 처리했습니다.");
				//location.reload();
				$(".corpInfoTable").load("${contextPath}/Admin/manageCorp .corpInfoTable");
			}
		});
		}
	});
});
</script>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />



