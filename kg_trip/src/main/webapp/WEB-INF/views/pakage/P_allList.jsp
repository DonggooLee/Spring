<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<style type="text/css">
	.searchSection{
		width: 1200px;
		height : 200px;
		background-color: white;
	}
	.pakageSection{
		width: 1200px;
	}
	.pakageList{
		width: 300px;
		height: 400px;
		float: left;
		background-color: white;
	}
	.ull .lii{
		float: left;
	}
</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="cont">
			
			<div class="searchSection" style="height: 100px">
				<h2>어디로 떠나세요?</h2>
				<ul class="ull" style="margin-top: 20px">
					<li class="lii" style="width: 150px"><a href='/pakage/P_allList'>전체보기</a></li>
					<li class="lii" style="width: 150px" id="slinka">유럽</li>
					<li class="lii" style="width: 150px" id="slinkb">동남아/일본</li>
					<li class="lii" style="width: 150px" id="slinkc">하와이/몰디브</li>
					<li class="lii" style="width: 150px" id="slinkd">괌/사이판</li>
					<li class="lii" style="width: 150px" id="slinke">국내여행</li>
				</ul>
			</div><br><br>
			<div>
				<form>
					<h2>국가, 지역명, 도시를 검색하세요 !</h2>
					<input type="text" name="region">
					<button data-oper="P_search" >검색</button>
				</form>
			</div><br>
			<div>
				<a id="linka">가격낮은순</a> / <a id="linkb">가격높은순</a> / 
				<a id="linkc">날짜빠른순</a> / <a id="linkd">날짜느린순</a> /
				<a id="linke">후기많은순</a> / <a id="linkf">별점높은순</a>
			</div><br><br>

			<!------------------------->
			<form class="searchResult">
			<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}" >
				<h1>전체 여행</h1>
				<div class="pakageSection">
		        	<c:choose>
	        		<c:when test="${not empty list }">
			             <c:forEach var="list" items="${list }">
								<div class="pakageList">
				             		<div style="position: relative;">
				             			<a href="/pakage/P_get?p_num=${list.p_num }">
				                   			<img alt="이미지" src="/img/${list.p_mainimg }" width="295px" height="180px"/>
			                   			</a>
			                   			<div class="change">
				                   			<c:choose>
				                   				<c:when test="${empty loginPublicInfo.m_idx || empty heart}">
													<div style="position: absolute; top: 5px; right: 10px" class="heart1">
		                   								<img alt="이미지" src="/img/h2.svg" data-num="${list.p_num}" class="wish"/>
		                   							</div>
				                   				</c:when>
				                   				<c:otherwise>
				                   				<c:set var="loop_flag" value="false"/>
						                   			<c:forEach var="heart" items="${heart}">
														<c:if test="${list.p_num eq heart.p_num}">
							                   				<c:if test="${not loop_flag }">
																	<div style="position: absolute; top: 5px; right: 10px" class="heart2">
						                   								<img alt="이미지" src="/img/h1.svg" data-num="${list.p_num}" class="wish"/>
						                   							</div>
						                   								<c:set var="loop_flag" value="true"/>
						                   					</c:if>
														</c:if>
														<c:if test="${list.p_num ne heart.p_num}">
															<c:if test="${not loop_flag }">
																<div style="position: absolute; top: 5px; right: 10px" class="heart3">
					                   								<img alt="이미지" src="/img/h2.svg" data-num="${list.p_num}" class="wish"/>
					                   							</div>
					                   						</c:if>
														</c:if>
								           			</c:forEach>
				                   				</c:otherwise>
				                   			</c:choose>
			                   			</div>
				                    </div>
				                   <div>
			             			<a href="/pakage/P_get?p_num=${list.p_num }">
				                 		<c:out value="${list.p_region2}"></c:out><br>
				                 		<c:out value="${list.p_name}"></c:out><br>
				                 		<c:out value="${list.p_period}"></c:out><br>
										<c:choose>
				                              <c:when test="${list.p_star gt 4.5}">
				                                          <span class="gold">★★★★★</span>
				                                 </c:when>
				                                 <c:when test="${list.p_star gt 3.5}">
				                                          <span class="gold">★★★★</span>
				                                 </c:when>
				                                 <c:when test="${list.p_star gt 2.5}">
				                                          <span class="gold">★★★</span>
				                                 </c:when>
				                                 <c:when test="${list.p_star gt 1.5}">
				                                          <span class="gold">★★</span>
				                                 </c:when>
				                                 <c:when test="${list.p_star gt 0.5}">
				                                          <span class="gold">★</span>
				                                 </c:when>
												<c:otherwise>
															후기 이벤트 진행중🥰
												</c:otherwise>
			                            </c:choose>
			                            (<c:out value="${list.rcount}"></c:out>)<br>
				                 		<fmt:formatNumber value="${list.p_fee }" pattern="#,###" />원 /1인
					                 </a>
				                   	</div>
			                 </div>
			             </c:forEach>
			          </c:when>
	 		          <c:otherwise>
							<h5>게시물이 없습니다.</h5>
	 		          </c:otherwise>
	             </c:choose>
				</div>
			</form>
			<form id="actionForm">
        	</form>
		</section>
		
<script type="text/javascript">
$(function(){
	
	var m_idx = $("input[name=m_idx]").val();

	var searchResult = $(".searchResult");
    
    $("button[data-oper='P_search']").click(function(e){
    	e.preventDefault();
    	var region = $('input[name=region]').val();
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_jebal?region='+region,
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    						str += '<h1>'+ region + '패키지 검색 결과</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#linka").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linka',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    						str += '<h1>가격 낮은순 검색 결과</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#linkb").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linkb',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    						str += '<h1>가격 높은순 검색 결과</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#linkc").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linkc',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    					str += '<h1>날짜 빠른순 검색 결과</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#linkd").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linkd',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    						str += '<h1>날짜 느린순 검색 결과</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#linke").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linke',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    						str += '<h1>후기 많은순 검색 결과</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#linkf").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linkf',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    					str += '<h1>별점 높은순 검색 결과</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    // 클릭 했을 때
    $("#slinka").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinka',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    						str += '<h1>유럽</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#slinkb").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinkb',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    					str += '<h1>동남아/일본</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#slinkc").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinkc',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    						str += '<h1>하와이</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#slinkd").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinkd',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    						str += '<h1>괌/사이판</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
    $("#slinke").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinke',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
    			
    			if(m_idx ==''){
    				m_idx = 99999;
    			}
    			
    			$.ajax({
    				type : 'post',
    	    		url : '${pageContext.request.contextPath}/pakage/P_wish?m_idx='+m_idx,
    	    		contentType : 'application/json; charset=utf-8',
    	    		success : function(heart) {
						var str = '';
    					
    					if(slist == null || slist.length == 0){
    						searchResult.html("검색 결과가 없습니다.");
    						return;
    					}
    						str += '<h1>국내여행</h1>';
    					for(var i=0; i<slist.length; i++){
    						str += '<div class="pakageSection">'
    						str += '<div class="pakageList">'
    						str += '<div style="position: relative;">'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<img alt="이미지" src="/img/'+ slist[i].p_mainimg +'" width="295px" height="180px"/>'
    						str += '</a>'
    						str += '<div class="change">'					
    						
    						if(m_idx == '' || heart.length == 0 ){
    							str += '<div style="position: absolute; top: 5px; right: 10px" class="heart1">'
    							str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
    							str += '</div>'
    						}else{
    							for(var j=0; j<heart.length; j++){
	    							if(slist[i].p_num == heart[j].p_num){
	    								
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart2">'
	    								str += '<img alt="이미지" src="/img/h1.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'	
	    								break;
	    							}else if(slist[i].p_num != heart[j].p_num){
	    								str += '<div style="position: absolute; top: 5px; right: 10px" class="heart3">'
	    								str += '<img alt="이미지" src="/img/h2.svg" data-num="'+ slist[i].p_num +'" class="wish"/>'
	    								str += '</div>'
	    								
	    							}
    							}
    						}
    						str += '</div>'
    						str += '</div>'
    						str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
    						str += '<div>'
    						str += slist[i].p_region2 + '<br>';
    						str += slist[i].p_name + '<br>';
    						str += slist[i].p_period + '<br>';
    		           			if(slist[i].p_star > 4.5){
    		           				str += '<span class="gold">★★★★★</span>';
    		           			}else if(slist[i].p_star > 3.5){
    		           				str += '<span class="gold">★★★★</span>';
    		           			}else if(slist[i].p_star > 2.5){
    		           				str += '<span class="gold">★★★</span>';
    		           			}else if(slist[i].p_star > 1.5){
    		           				str += '<span class="gold">★★</span>';
    		           			}else if(slist[i].p_star > 0.5){
    		           				str += '<span class="gold">★</span>';
    		           			}else if(slist[i].p_star == ""){
    		           				str += '후기 이벤트 진행중🥰';
    		           			}
    	           			str += '('+slist[i].rcount + ')<br>';
    		           			function AmountCommas(val){
    		           			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    		           			}
    	           			str += AmountCommas(slist[i].p_fee)+'원 /1인'
    						str += '</div>'
    						str += '</div>'
    						str += '</a>'
    	    			}
  						console.log(slist);
  						console.log(heart);
  						searchResult.html(str);
  						
  						var heart1 = $(".heart1") 
  					   	var heart2 = $(".heart2")
  					   	var heart3 = $(".heart3")
  					   	var change = $(".change")
  					   	
  					    $(heart1).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					   	
  					    $(heart3).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  					    
  					    $(heart2).on("click", "img",function(e){
  					    	
  					    	var actionForm = $("#actionForm");
  					    	var p_num = $(this).data("num");
  					       	
  					    	if(m_idx == ''){
  					    		alert("로그인 후 이용가능합니다.");
  					    		actionForm.attr("action", "/Member/login");
  					            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
  					            actionForm.submit();
  					    	}else{
  					    		
  					    		var param = {p_num:p_num, m_idx:m_idx};
  					    		var str = '';
  					    		var p_num = $(this).data("num");
  					    		
  					     		$.ajax({
  					        		type : 'post',
  					        		data : JSON.stringify(param),
  					        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
  					        		contentType : 'application/json; charset=utf-8',
  					        		success :function(){
  					        			location.href = "/pakage/P_allList";
  					        			document.location.reload();
  					        			history.go(0);		
  					        		}
  					        	}); 
  					    	}
  					    });
  						
    	    		}
    			})
    			
			}
    	})
    })
    
	var heart1 = $(".heart1") 
   	var heart2 = $(".heart2")
   	var heart3 = $(".heart3")
   	var change = $(".change")
   	
    $(heart1).on("click", "img",function(e){
    	
    	var actionForm = $("#actionForm");
    	var p_num = $(this).data("num");
       	
    	if(m_idx == ''){
    		alert("로그인 후 이용가능합니다.");
    		actionForm.attr("action", "/Member/login");
            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
            actionForm.submit();
    	}else{
    		
    		var param = {p_num:p_num, m_idx:m_idx};
    		var str = '';
    		
     		$.ajax({
        		type : 'post',
        		data : JSON.stringify(param),
        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
        		contentType : 'application/json; charset=utf-8',
        		success :function(){
        			location.href = "/pakage/P_pakageMain";
        			document.location.reload();
        			history.go(0);		
        		}
        	}); 
    	}
    });
   	
    $(heart3).on("click", "img",function(e){
    	
    	var actionForm = $("#actionForm");
    	var p_num = $(this).data("num");
       	
    	if(m_idx == ''){
    		alert("로그인 후 이용가능합니다.");
    		actionForm.attr("action", "/Member/login");
            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
            actionForm.submit();
    	}else{
    		
    		var param = {p_num:p_num, m_idx:m_idx};
    		var str = '';
    		var p_num = $(this).data("num");
    		
     		$.ajax({
        		type : 'post',
        		data : JSON.stringify(param),
        		url : '${pageContext.request.contextPath}/pakage/P_wishinsert',
        		contentType : 'application/json; charset=utf-8',
        		success :function(){
        			location.href = "/pakage/P_pakageMain";
        			document.location.reload();
        			history.go(0);		
        		}
        	}); 
    	}
    });
    
    $(heart2).on("click", "img",function(e){
    	
    	var actionForm = $("#actionForm");
    	var p_num = $(this).data("num");
       	
    	if(m_idx == ''){
    		alert("로그인 후 이용가능합니다.");
    		actionForm.attr("action", "/Member/login");
            actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
            actionForm.submit();
    	}else{
    		
    		var param = {p_num:p_num, m_idx:m_idx};
    		var str = '';
    		var p_num = $(this).data("num");
    		
     		$.ajax({
        		type : 'post',
        		data : JSON.stringify(param),
        		url : '${pageContext.request.contextPath}/pakage/P_wishdelete',
        		contentType : 'application/json; charset=utf-8',
        		success :function(){
        			location.href = "/pakage/P_pakageMain";
        			document.location.reload();
        			history.go(0);		
        		}
        	}); 
    	}
    });
    
});
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>