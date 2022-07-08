<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>

<jsp:include page="/WEB-INF/views/include/corpHeader.jsp"/>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

		<section class="cont2">
			<div class="all" style="display: flex;">
				<jsp:include page="/WEB-INF/views/include/corpMenuBar.jsp"></jsp:include>
				
				<div class="content_section" style="border: 1px solid black; width: 85%; background-color: #E8EFFF;">
					<div class="content" style=" margin : 10px; background-color: white;">
				<div>
				<h1>패키지 등록</h1>
				<form action="uploadFormGo" method="post" enctype="multipart/form-data" class="mb-3" id="frm">
					<table style="background-color: white;">
						<tr>
							<td>
								패키지 번호(스펠링3자+100자리숫자)
							</td>
							<td>
								<input type="text" name="p_num">
							</td>
						</tr>
						<tr>
							<td>
								패키지 여행기간(yyyy.mm.dd ~ yyyy.mm.dd) 
							</td>
							<td>
								<input type="text" name="p_period">
							</td>
						</tr>
						<tr>
							<td>
								나라 
							</td>
							<td>
								<input type="text" name="p_country">
							</td>
						</tr>
						<tr>
							<td>
								지역1(ex)북아메리카,서유럽) 
							</td>
							<td>
								<input type="text" name="p_region1">
							</td>
						</tr>
						<tr>
							<td>
								지역2(나라명 or 지역명) 
							</td>
							<td>
								<input type="text" name="p_region2">
							</td>
						</tr>
						<tr>
							<td>
								패키지명 
							</td>
							<td>
								<input type="text" name="p_name">
							</td>
						</tr>
						<tr>
							<td>
								패키지 메인이미지 
							</td>
							<td>
								<input type="file" name="uploadFilea" multiple="multiple">
							</td>
						</tr>
						 <tr>
							<td>
								패키지 이미지1 
							</td>
							<td>
								<input type="file" name="uploadFileb" multiple="multiple">
							</td>
						</tr>
						<tr>
							<td>
								패키지 이미지2
							</td>
							<td>
								<input type="file" name="uploadFilec" multiple="multiple">
							</td>
						</tr>
						<tr>
							<td>
								패키지 이미지3
							</td>
							<td>
								<input type="file" name="uploadFiled" multiple="multiple">
							</td>
						</tr>
						<tr>
							<td>
								패키지 이미지4
							</td>
							<td>
								<input type="file" name="uploadFilee" multiple="multiple">
							</td>
						</tr>
						<tr>
							<td>
								상품 정보
							</td>
							<td>
								<input type="text" name="p_information" style="width:500px ;height:200px">
							</td>
						</tr>
						<tr>
							<td>
								이용 안내
							</td>
							<td>
								<input type="text" name="p_guide" style="width:500px ;height:200px">
							</td>
						</tr>
						<tr>
							<td>
								패키지 인원
							</td>
							<td>
								<input type="number" name="p_max">
							</td>
						</tr>
						<tr>
							<td>
								패키지 금액
							</td>
							<td>
								<input type="number" name="p_fee">
								<input type="hidden" name="p_division" value="등록완료">
							</td>
						</tr>
						<tr>
							<td colspan="2"><button style="width:200px" id="pinsert">패키지 등록</button></td>
						</tr>			
					</table>
				</form>
			</div>
					</div>
					</div>
				</div>
		</section>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

<script type="text/javascript">
$(function(){
	
	var pinsert = $("#pinsert")
	var frm = $("#frm")
	
    $(pinsert).click(function(e){
    	e.preventDefault();
       	
    	if($('input[name=p_num]').val() == ''){
    		alert("패키지 번호 입력 부탁드립니다.");
            return;
    	}if($('input[name=p_period]').val() == ''){
    		alert("패키지 여행기간 입력 부탁드립니다.");
            return;
    	}if($('input[name=p_country]').val() == ''){
    		alert("나라 입력 부탁드립니다.");
            return;
    	}if($('input[name=p_region1]').val() == ''){
    		alert("지역1 입력 부탁드립니다.");
            return;
    	}if($('input[name=p_region2]').val() == ''){
    		alert("지역2 입력 부탁드립니다.");
            return;
    	}if($('input[name=p_name]').val() == ''){
    		alert("패키지명 입력 부탁드립니다.");
            return;
    	}if($('input[name=uploadFilea]').val() == ''){
    		alert("패키지 메인이미지 입력 부탁드립니다.");
            return;
    	}if($('input[name=p_information]').val() == ''){
    		alert("상품정보 입력 부탁드립니다.");
            return;
    	}if($('input[name=p_guide]').val() == ''){
    		alert("이용안내 부탁드립니다.");
            return;
    	}if($('input[name=p_max]').val() == ''){
    		alert("패키지 인원 입력 부탁드립니다.");
            return;
    	}if($('input[name=p_fee]').val() == ''){
    		alert("패키지 금액 입력 부탁드립니다.");
            return;
    	}else{
    		frm.submit();
    	}
        	
   	});
	
});

</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		
	
