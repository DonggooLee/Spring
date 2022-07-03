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
	
	.conted {
		/* position: relative; */
		width: 100%;
		max-width: 1200px;
		margin: 0 auto;
		height: 2000px;
		background-color: #F0FFFF;
		

		을지가 수정한 것들 !! 여기부터
		background-color: gray;
		border: 2px solid pink;
		padding: 20px;
		을지가 수정한 것들 !! 여기까지
	}
</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="conted">
			
			<div class="searchSection">
				<h2>어디로 떠나세요?</h2>
				<ul>
					<li id="slinka">유럽</li>
					<li id="slinkb">동남아/일본</li>
					<li id="slinkc">하와이</li>
					<li id="slinkd">괌/사이판</li>
					<li id="slinke">국내여행</li>
				</ul>
			</div>
			<div>
				<form>
					<h4>국가, 지역명, 도시를 검색하세요 !</h4>
					<input type="text" name="region">
					<button data-oper="P_search" >검색</button>
				</form>
			</div>
			<div>
				<a id="linka">가격낮은순</a> / <a id="linkb">가격높은순</a> / 
				<a id="linkc">날짜빠른순</a> / <a id="linkd">날짜느린순</a> /
				<a id="linke">후기많은순</a> / <a id="linkf">별점높은순</a>
			</div>

			<!------------------------->
			<form class="searchResult">
				<h1>전체 여행</h1>
				<div class="pakageSection">
		        	<c:choose>
	        		<c:when test="${not empty list }">
			             <c:forEach var="list" items="${list }">
				            <a href="/pakage/P_get?p_num=${list.p_num }">
					             <div class="pakageList">
					             		<div>
					                   		<img alt="이미지" src="/resources/images/${list.p_mainimg }" width="250px" height="200px">
					                   </div>
					                   <div>
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
					                   </div>
				                 </div>
			                 </a>
			             </c:forEach>
			          </c:when>
	 		          <c:otherwise>
							<h5>게시물이 없습니다.</h5>
	 		          </c:otherwise>
	             </c:choose>
				</div>
			</form>
			
		</section>
		
<script type="text/javascript">
$(function(){
	
	var searchResult = $(".searchResult");
    
    $("button[data-oper='P_search']").click(function(e){
    	e.preventDefault();
    	var region = $('input[name=region]').val();
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_jebal?region='+region,
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>'+ region + '패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#linka").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linka',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>가격 낮은 순 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#linkb").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linkb',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>가격 높은 순 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#linkc").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linkc',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>날짜 빠른 순 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#linkd").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linkd',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>날짜 느린 순 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#linke").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linke',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>후기 많은 순 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#linkf").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_linkf',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>별점 높은 순 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    // 클릭 했을 때
    $("#slinka").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinka',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>유럽 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#slinkb").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinkb',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>동남아/일본 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#slinkc").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinkc',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>하와이 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#slinkd").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinkd',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>괌/사이판 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
    
    $("#slinke").click(function(e){
    	
    	$.ajax({
    		type : 'post',
    		url : '${pageContext.request.contextPath}/pakage/P_slinke',
    		contentType : 'application/json; charset=utf-8',
    		success : function(slist) {
				var str = '';
				
				if(slist == null || slist.length == 0){
					searchResult.html("검색 결과가 없습니다.");
					return;
				}
					str += '<h1>국내여행 패키지 검색 결과</h1>';
				for(var i=0; i<slist.length; i++){
					str += '<div class="pakageSection">';
					str += '<a href="/pakage/P_get?p_num='+ slist[i].p_num +'">';
					str += '<div class="pakageList">';
					str += '<div>';
					str += '<img alt="이미지" src="/resources/images/'+ slist[i].p_mainimg +'" width="250px" height="200px">';
					str += '</div>';
					str += '<div>';
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
					str += '</div>';
					str += '</div>';
					str += '</a>';
				}
    			console.log(slist);
	    		searchResult.html(str)
    		}
    	});
    });
});
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>