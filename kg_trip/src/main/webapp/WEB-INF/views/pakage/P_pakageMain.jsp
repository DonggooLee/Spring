<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<meta
      name="viewport"
      content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"
    />
    <!-- Link Swiper's CSS -->
    <link
      rel="stylesheet"
      href="https://unpkg.com/swiper/swiper-bundle.min.css"
    />

    <!-- Demo styles -->
    <style>

      .swiper {
        width: 700px;
        height: 300px;
      }

      .swiper-slide {
        text-align: center;
        font-size: 10px;
        background: #fff;

        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
      }

      .swiper-slide img {
        display: block;
        width: 700px;;
        height: 300px;
        object-fit: cover;
      }
    </style>
<style type="text/css">
	.searchSection{
		width: 1200px;
		height : 800px;
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

</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="cont">
			
			<div class="searchSection" style="width:1200px; height:340px;">
				<div style="width:700px; height:300px; float: left;">
					<!-- Swiper -->
				    <div class="swiper mySwiper">
				      <div class="swiper-wrapper">
				        <div class="swiper-slide"><img alt="이미지" src="/img/p_main1.jpg"></div>
				        <div class="swiper-slide"><img alt="이미지" src="/img/p_main2.jpg"></div>
				        <div class="swiper-slide"><img alt="이미지" src="/img/p_main3.jpg"></div>
				        <div class="swiper-slide"><img alt="이미지" src="/img/p_main4.jpg"></div>
				      </div>
				      <div class="swiper-button-next"></div>
				      <div class="swiper-button-prev"></div>
				      <div class="swiper-pagination"></div>
				    </div>
				
				    <!-- Swiper JS -->
				    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
				
				    <!-- Initialize Swiper -->
				    <script>
				      var swiper = new Swiper(".mySwiper", {
				        spaceBetween: 30,
				        centeredSlides: true,
				        autoplay: {
				          delay: 2500,
				          disableOnInteraction: false,
				        },
				        pagination: {
				          el: ".swiper-pagination",
				          clickable: true,
				        },id
				        navigation: {
				          nextEl: ".swiper-button-next",
				          prevEl: ".swiper-button-prev",
				        },
				      });
				    </script>
				</div>
				<div style="height:100px; float: right; width:500px; object-fit: cover; text-align: center;">
					<h2 style="text-align:center">어디로 떠나세요?</h2><br><br>
					<h2><a href="/pakage/P_allList"> 🎉전체 패키지 여행 구경하기😎</a></h2>
				</div>
			</div>
			<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}" >
			<!------------------------->
			<h1>Best 유럽여행지 특가!</h1>
			<div class="pakageSection">
	        	<c:choose>
        		<c:when test="${not empty listWeu }">
		             <c:forEach var="weu" items="${listWeu }">
				             <div class="pakageList">
				             		<div style="position: relative;">
				             			<a href="/pakage/P_get?p_num=${weu.p_num }">
				                   			<img alt="이미지" src="/img/${weu.p_mainimg }" width="295px" height="180px"/>
			                   			</a>
			                   			<div class="change">
				                   			<c:choose>
				                   				<c:when test="${empty loginPublicInfo.m_idx || empty heart}">
													<div style="position: absolute; top: 5px; right: 10px" class="heart1">
		                   								<img alt="이미지" src="/img/h2.svg" data-num="${weu.p_num}" class="wish"/>
		                   							</div>
				                   				</c:when>
				                   				<c:otherwise>
				                   				<c:set var="loop_flag" value="false"/>
						                   			<c:forEach var="heart" items="${heart}">
														<c:if test="${weu.p_num eq heart.p_num}">
							                   				<c:if test="${not loop_flag }">
																	<div style="position: absolute; top: 5px; right: 10px" class="heart2">
						                   								<img alt="이미지" src="/img/h1.svg" data-num="${weu.p_num}" class="wish"/>
						                   							</div>
						                   								<c:set var="loop_flag" value="true"/>
						                   					</c:if>
														</c:if>
														<c:if test="${weu.p_num ne heart.p_num}">
															<c:if test="${not loop_flag }">
																<div style="position: absolute; top: 5px; right: 10px" class="heart3">
					                   								<img alt="이미지" src="/img/h2.svg" data-num="${weu.p_num}" class="wish"/>
					                   							</div>
					                   						</c:if>
														</c:if>
								           			</c:forEach>
				                   				</c:otherwise>
				                   			</c:choose>
			                   			</div>
				                    </div>
			             			<a href="/pakage/P_get?p_num=${weu.p_num }">
				                   <div>
				                 		<c:out value="${weu.p_region2}"></c:out><br>
				                 		<c:out value="${weu.p_name}"></c:out><br>
				                 		<c:out value="${weu.p_period}"></c:out><br>
										<c:choose>
			                              <c:when test="${weu.p_star gt 4.5}">
			                                          <span class="gold">★★★★★</span>
			                                 </c:when>
			                                 <c:when test="${weu.p_star gt 3.5}">
			                                          <span class="gold">★★★★</span>
			                                 </c:when>
			                                 <c:when test="${weu.p_star gt 2.5}">
			                                          <span class="gold">★★★</span>
			                                 </c:when>
			                                 <c:when test="${weu.p_star gt 1.5}">
			                                          <span class="gold">★★</span>
			                                 </c:when>
			                                 <c:when test="${weu.p_star gt 0.5}">
			                                          <span class="gold">★</span>
			                                 </c:when>
											<c:otherwise>
														후기 이벤트 진행중🥰
											</c:otherwise>
			                              </c:choose>
			                              (<c:out value="${weu.rcount}"></c:out>)<br>
				                 		<fmt:formatNumber value="${weu.p_fee }" pattern="#,###" />원 /1인
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
			<h1>우리가 찾던 허니문</h1>
			<div class="pakageSection">
	        	<c:choose>
        		<c:when test="${not empty listSai }">
		             <c:forEach var="sai" items="${listSai }">
			              <a href="/pakage/P_get?p_num=${sai.p_num }">
				             <div class="pakageList">
				             		<div style="position: relative;">
				             			<a href="/pakage/P_get?p_num=${sai.p_num }">
				                   			<img alt="이미지" src="/img/${sai.p_mainimg }" width="295px" height="180px"/>
			                   			</a>
			                   			<div class="change">
				                   			<c:choose>
				                   				<c:when test="${empty loginPublicInfo.m_idx || empty heart}">
													<div style="position: absolute; top: 5px; right: 10px" class="heart1">
		                   								<img alt="이미지" src="/img/h2.svg" data-num="${sai.p_num}" class="wish"/>
		                   							</div>
				                   				</c:when>
				                   				<c:otherwise>
				                   				<c:set var="loop_flag" value="false"/>
						                   			<c:forEach var="heart" items="${heart}">
														<c:if test="${sai.p_num eq heart.p_num}">
							                   				<c:if test="${not loop_flag }">
																	<div style="position: absolute; top: 5px; right: 10px" class="heart2">
						                   								<img alt="이미지" src="/img/h1.svg" data-num="${sai.p_num}" class="wish"/>
						                   							</div>
						                   								<c:set var="loop_flag" value="true"/>
						                   					</c:if>
														</c:if>
														<c:if test="${sai.p_num ne heart.p_num}">
															<c:if test="${not loop_flag }">
																<div style="position: absolute; top: 5px; right: 10px" class="heart3">
					                   								<img alt="이미지" src="/img/h2.svg" data-num="${sai.p_num}" class="wish"/>
					                   							</div>
					                   						</c:if>
														</c:if>
								           			</c:forEach>
				                   				</c:otherwise>
				                   			</c:choose>
			                   			</div>
				                    </div>
			             			<a href="/pakage/P_get?p_num=${sai.p_num }">
				                   <div>
				                 		<c:out value="${sai.p_region2}"></c:out><br>
				                 		<c:out value="${sai.p_name}"></c:out><br>
				                 		<c:out value="${sai.p_period}"></c:out><br>
										<c:choose>
			                              <c:when test="${sai.p_star gt 4.5}">
			                                          <span class="gold">★★★★★</span>
			                                 </c:when>
			                                 <c:when test="${sai.p_star gt 3.5}">
			                                          <span class="gold">★★★★</span>
			                                 </c:when>
			                                 <c:when test="${sai.p_star gt 2.5}">
			                                          <span class="gold">★★★</span>
			                                 </c:when>
			                                 <c:when test="${sai.p_star gt 1.5}">
			                                          <span class="gold">★★</span>
			                                 </c:when>
			                                 <c:when test="${sai.p_star gt 0.5}">
			                                          <span class="gold">★</span>
			                                 </c:when>
											<c:otherwise>
														후기 이벤트 진행중🥰
											</c:otherwise>
			                              </c:choose>
			                              (<c:out value="${sai.rcount}"></c:out>)<br>
				                 		<fmt:formatNumber value="${sai.p_fee }" pattern="#,###" />원 /1인
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
			<h1>국내로 떠나는 섬캉스</h1>
			<div class="pakageSection">
	        	<c:choose>
        		<c:when test="${not empty listkos }">
		             <c:forEach var="kos" items="${listkos }">
			              <a href="/pakage/P_get?p_num=${kos.p_num }">
							<div class="pakageList">
				             		<div style="position: relative;">
				             			<a href="/pakage/P_get?p_num=${kos.p_num }">
				                   			<img alt="이미지" src="/img/${kos.p_mainimg }" width="295px" height="180px"/>
			                   			</a>
			                   			<div class="change">
				                   			<c:choose>
				                   				<c:when test="${empty loginPublicInfo.m_idx || empty heart}">
													<div style="position: absolute; top: 5px; right: 10px" class="heart1">
		                   								<img alt="이미지" src="/img/h2.svg" data-num="${kos.p_num}" class="wish"/>
		                   							</div>
				                   				</c:when>
				                   				<c:otherwise>
				                   				<c:set var="loop_flag" value="false"/>
						                   			<c:forEach var="heart" items="${heart}">
														<c:if test="${kos.p_num eq heart.p_num}">
							                   				<c:if test="${not loop_flag }">
																	<div style="position: absolute; top: 5px; right: 10px" class="heart2">
						                   								<img alt="이미지" src="/img/h1.svg" data-num="${kos.p_num}" class="wish"/>
						                   							</div>
						                   								<c:set var="loop_flag" value="true"/>
						                   					</c:if>
														</c:if>
														<c:if test="${kos.p_num ne heart.p_num}">
															<c:if test="${not loop_flag }">
																<div style="position: absolute; top: 5px; right: 10px" class="heart3">
					                   								<img alt="이미지" src="/img/h2.svg" data-num="${kos.p_num}" class="wish"/>
					                   							</div>
					                   						</c:if>
														</c:if>
								           			</c:forEach>
				                   				</c:otherwise>
				                   			</c:choose>
			                   			</div>
				                    </div>
			             			<a href="/pakage/P_get?p_num=${kos.p_num }">
				                   <div>
				                 		<c:out value="${kos.p_region2}"></c:out><br>
				                 		<c:out value="${kos.p_name}"></c:out><br>
				                 		<c:out value="${kos.p_period}"></c:out><br>
				                 		<c:choose>
			                              <c:when test="${kos.p_star gt 4.5}">
			                                          <span class="gold">★★★★★</span>
			                                 </c:when>
			                                 <c:when test="${kos.p_star gt 3.5}">
			                                          <span class="gold">★★★★</span>
			                                 </c:when>
			                                 <c:when test="${kos.p_star gt 2.5}">
			                                          <span class="gold">★★★</span>
			                                 </c:when>
			                                 <c:when test="${kos.p_star gt 1.5}">
			                                          <span class="gold">★★</span>
			                                 </c:when>
			                                 <c:when test="${kos.p_star gt 0.5}">
			                                          <span class="gold">★</span>
			                                 </c:when>
											<c:otherwise>
														후기 이벤트 진행중🥰
											</c:otherwise>
			                              </c:choose>
			                              (<c:out value="${kos.rcount}"></c:out>)<br>
				                 		<fmt:formatNumber value="${kos.p_fee }" pattern="#,###" />원 /1인
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
           	<form id="actionForm">
        	</form>
		</section>
		
<script type="text/javascript">

$(function(){
	
	
   	var m_idx = $("input[name=m_idx]").val();
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