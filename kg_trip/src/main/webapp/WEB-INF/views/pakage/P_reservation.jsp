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
    #my_modal1, #my_modal2, #my_modal3 {
        display: none;
        width: 300px;
        padding: 20px 60px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #my_modal1 .modal_close_btn, #my_modal2 .modal_close_btn, #my_modal3 .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="cont">
			<div class="center">
				<form action="/pakage/kakaoPayGo" method="post" role="form" id="reservationForm">
					<h1>결제하기</h1><br>
					<div class="center-middle">
						<img alt="이미지" src="/img/${board.p_mainimg }" width="350px"><br><br>
						<c:out value="${board.p_name}"></c:out><br><br>
						<input type="hidden" name="p_name" value="${board.p_name}" >
						<input type="hidden" name="p_num" value="${board.p_num}" >
						여행일 : <c:out value="${board.p_period}"></c:out><br><br>
						<input type="hidden" name="p_period" value="${board.p_period}" readonly="readonly">
						금액 : <fmt:formatNumber value="${board.p_fee }" pattern="#,###" />원 X <c:out value="${p_rpeople}"/>인<input type="hidden" name="p_rpeople" value="${p_rpeople}" ><br><br>
						총 금액 : <fmt:formatNumber value="${p_totalfee }" pattern="#,###" />원
						<input type="hidden" name="p_totalfee" value="${p_totalfee}" readonly="readonly">
					</div><br><br>
					<div class="center-middle">
						<h3>예약자 정보</h3><br><br>
						<input type="hidden" name="m_id" value="${loginPublicInfo.m_id}" >
						<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}" >
						예약자 이름<br>
						<input type="text" name="m_name" value="${loginPublicInfo.m_name}"><br><br>
						이메일주소<br>
						<input type="text" name="m_email" value="${loginPublicInfo.m_email}"><br><br>
						휴대전화번호<br>
						<input type="text" name="m_phone" value="${loginPublicInfo.m_phone}"><br><br>
					</div><br><br>
					<div class="center-middle">
							<h3>결제 방법</h3><br>
							<img alt="이미지" src="/img/kp.png" height="50px"><br><br>
							<h3>약관 및 안내</h3><br>
							<input type="checkbox" name="agree1" value="1" class="ab"> 전체 약관 동의<br><br>
							<input type="checkbox" name="agree2" value="2" class="ab"><label>여행자 약관(필수)<button id="popup_open_btn1">📝</button></label><br>
							<input type="checkbox" name="agree3" value="3" class="ab"><label>개인정보 수집 및 이용 동의(필수)<button id="popup_open_btn2">📝</button></label><br>
							<input type="checkbox" name="agree4" value="4" class="ab"><label>개인정보 제공 동의(필수)<button id="popup_open_btn3">📝</button></label><br>
							<br>
							<button data-oper="P_preservation" style="width:200px; height:50px"><fmt:formatNumber value="${p_totalfee }" pattern="#,###" />원 결제하기</button><br><br>
					</div>
				</form>
				
            	<form action="/pakage/P_pakageList" method="get" id="actionForm">
           		</form>
			</div>
		</section>
		
<script type="text/javascript">

function modal(id) {
    var zIndex = 9999;
    var modal = $('#' + id);

    // 모달 div 뒤에 희끄무레한 레이어
    var bg = $('<div>')
        .css({
            position: 'fixed',
            zIndex: zIndex,
            left: '0px',
            top: '0px',
            width: '100%',
            height: '100%',
            overflow: 'auto',
            // 레이어 색갈은 여기서 바꾸면 됨
            backgroundColor: 'rgba(0,0,0,0.4)'
        })
        .appendTo('body');

    modal
        .css({
            position: 'fixed',
            boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

            // 시꺼먼 레이어 보다 한칸 위에 보이기
            zIndex: zIndex + 1,

            // div center 정렬
            top: '50%',
            left: '50%',
            transform: 'translate(-50%, -50%)',
            msTransform: 'translate(-50%, -50%)',
            webkitTransform: 'translate(-50%, -50%)'
        })
        .show()
        // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
        .find('.modal_close_btn')
        .on('click', function() {
            bg.remove();
            modal.hide();
        });
	
	$('.agree2').click(function(e){
		$("input[name=agree2]:checkbox").prop("checked", "checked");
		bg.remove();
        modal.hide();
	});
	
	$('.agree3').click(function(e){
		$("input[name=agree3]:checkbox").prop("checked", "checked");
		bg.remove();
        modal.hide();
	});
	
	$('.agree4').click(function(e){
		$("input[name=agree4]:checkbox").prop("checked", "checked");
		bg.remove();
        modal.hide();
	});
	
	$('.back').click(function(e){
		e.preventDefault();
		bg.remove();
        modal.hide();
	});
	
}


$(function(){
    
	$('#popup_open_btn1').on('click', function(e) {
		e.preventDefault();
	    // 모달창 띄우기
	    modal('my_modal1');
	});
	
	$('#popup_open_btn2').on('click', function(e) {
		e.preventDefault();
	    // 모달창 띄우기
	    modal('my_modal2');
	});
	
	$('#popup_open_btn3').on('click', function(e) {
		e.preventDefault();
	    // 모달창 띄우기
	    modal('my_modal3');
	});
	
	$('input[name=agree1]').click(function(e){
		$( '.ab' ).prop( 'checked', this.checked )
		$('input[name=agree1]').prop( 'checked', this.checked )
	});
	
	
    $("button[data-oper='P_preservation']").click(function(e){
    	
    	var m_idx = $('input[name=m_idx]').val();
    	
    	if(m_idx == ""){
			var actionForm = $("#actionForm");
	    	e.preventDefault();
    		alert("로그인 부탁드립니다.");
            actionForm.attr("action", "/Member/login");
            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
            actionForm.submit();
    	}else{
        	if($('input[name=agree2]').is(':checked') == false){
        		alert("여행자 약관(필수)동의 부탁드립니다 .");
        		e.preventDefault();
        	}else if($('input[name=agree3]').is(':checked') == false){
        		alert("개인정보 수집 및 이용 동의(필수) 부탁드립니다 .");
        		e.preventDefault();
        	}else if($('input[name=agree4]').is(':checked') == false){
        		alert("개인정보 제공 동의(필수) 부탁드립니다 .");
        		e.preventDefault();
        	}else{
	    		$("#reservationForm").submit();
        	}
    	}
    });
 });
</script>
<jsp:include page="/WEB-INF/views/include/P_agree.jsp"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>