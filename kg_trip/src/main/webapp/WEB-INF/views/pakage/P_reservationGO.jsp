<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<style type="text/css">
	.center-middle{
		width : 900px;
		background-color: white;
		height : auto;
	}

</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="cont">
				<h1>예약이 완료되었습니다</h1>
		
		<div class="bookInfo">
			
		</div>
			
		<br>
		
		<div>
			<button id="mainBtn">홈으로</button>
		</div>
		
		<div id="Info">
			<input type="hidden" name="p_rnum" value="${info.p_rnum}">
			<input type="hidden" name="p_num" value="${info.p_num}">
			<input type="hidden" name="m_idx" value="${info.m_idx}">
			<input type="hidden" name="p_name" value="${info.p_name}">
			<input type="hidden" name="p_period" value="${info.p_period}">
			<input type="hidden" name="m_id" value="${info.m_id}">
			<input type="hidden" name="m_name" value="${info.m_name}">
			<input type="hidden" name="m_phone" value="${info.m_phone}">
			<input type="hidden" name="p_rpeople" value="${info.p_rpeople}">
			<input type="hidden" name="p_totalfee" value="${info.p_totalfee}">
			<input type="hidden" name="p_tid" value="${info.tid}">
		</div>

		</section>
		
<script type="text/javascript">

$(function() {
	
	// 예약을 위한 정보 저장
	var p_rnum = $("#Info").find("input[name='p_rnum']").val();
	var p_num = $("#Info").find("input[name='p_num']").val();
	var m_idx = $("#Info").find("input[name='m_idx']").val();
	var p_name = $("#Info").find("input[name='p_name']").val();
	var p_period = $("#Info").find("input[name='p_period']").val();
	var m_id = $("#Info").find("input[name='m_id']").val();
	var m_name = $("#Info").find("input[name='m_name']").val();
	var m_phone = $("#Info").find("input[name='m_phone']").val();
	var p_rpeople = $("#Info").find("input[name='p_rpeople']").val();
	var p_totalfee = $("#Info").find("input[name='p_totalfee']").val();
	var p_tid = $("#Info").find("input[name='p_tid']").val();
	
	console.log(p_name);
	console.log(p_tid);
	
	
	var param = {p_rnum:p_rnum, p_num:p_num, m_idx:m_idx, p_name:p_name, p_period:p_period,
			m_id:m_id, m_name:m_name, m_phone:m_phone, m_phone:m_phone,
			p_rpeople:p_rpeople, p_totalfee:p_totalfee, p_tid:p_tid}
	
	// 항공권 예약확정
	
	$.ajax({
		type : 'post',
		url : '/pakage/P_preservation',
		data : JSON.stringify(param), 
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			console.log("예약결과 : " + result);
			alert("결제가 정상적으로 완료되었습니다 :)")
			
			$.ajax({
				type : 'get',
				url : '/pakage/getreservation/' + p_rnum,
				success : function(info) {
					var str = '';
					if(info != ""){
						str += "<table style='padding: 20px; border: 1px solid black;'>";
						str += "<tr><th colspan='2'>예약 정보</th></tr>";
						str += "<tr><th>예약번호</th><td>" + info.p_rnum + "</td></tr>";
						str += "<tr><th>패키지명</th><td>" + info.p_name + "</td></tr>";
						str += "<tr><th>여행기간</th><td>" + info.p_period + "</td></tr>";
						str += "<tr><th>예약일자</th><td>" + info.p_rdate + "</td></tr>";
						str += "<tr><th>예약자명</th><td>" + info.m_name + "</td></tr>";
						str += "<tr><th>예약인원</th><td>" + info.p_rpeople + "인</td></tr>";
						function mobile_keyup(obj){
							return obj.toString().replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/\-{1,2}$/g, "");
						}
						str += "<tr><th>예약자 전화번호</th><td>" + mobile_keyup(info.m_phone) + "</td></tr>";
						function AmountCommas(val){
	           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
	           			}
						str += "<tr><th>총 결제금액</th><td>" + AmountCommas(info.p_totalfee) + "원</td></tr>";
						str += "</table>";
						$(".bookInfo").html(str);
					}else{
						$(".bookInfo").html("<h1>정보가 존재하지 않습니다.</h1>");
					}
				}
			}) // end : 항공권 예약확정 시 예약번호를 통한 예약정보 출력
		}
	})
		
	
	$("#mainBtn").on("click", function(){
		location.href = "/KingTrip/main";
	});
});	
	
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>