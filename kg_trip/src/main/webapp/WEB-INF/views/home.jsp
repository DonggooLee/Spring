<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />
<meta
      name="viewport"
      content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"
    />
    <!-- Link Swiper's CSS -->
    <link
      rel="stylesheet"
      href="https://unpkg.com/swiper/swiper-bundle.min.css"
    />
	<style>
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
	
	</style>
    <!-- Main swiper1 -->
    <style>

      .swiper {
        width: 1200px;
        height: 300px;
      }

      .swiper-slide {
        text-align: center;
        font-size: 18px;
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
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
      
      <!-- Main swiper2 -->
      
      .swiper {
        width: 1000px;
        height: 300px;
      }

      .swiper-slide {
        text-align: center;
        font-size: 18px;
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
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
      
    </style>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

	<section class="cont">
	
		<div class="event">
		</div>
		
		<div>
		<!-- Main Swiper1 -->
	    <div class="swiper mySwiper" style="margin-top: 150px">
	      <div class="swiper-wrapper">
	        <div class="swiper-slide"><img alt="이미지" src="/img/main1.png"></div>
	        <div class="swiper-slide"><img alt="이미지" src="/img/main2.png"></div>
	        <div class="swiper-slide"><img alt="이미지" src="/img/main3.png"></div>
	        <div class="swiper-slide"><img alt="이미지" src="/img/main4.png"></div>
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
	        },
	        navigation: {
	          nextEl: ".swiper-button-next",
	          prevEl: ".swiper-button-prev",
	        },
	      });
	    </script>
		</div>
		
		<br><br>
		
		<h1>취향 저격 동향찾기</h1><br>
		<div>
			<!-- Swiper2 -->
		    <div class="swiper mySwiper2">
		      <div class="swiper-wrapper">
		        <div class="swiper-slide">Slide 1</div>
		        <div class="swiper-slide">Slide 2</div>
		        <div class="swiper-slide">Slide 3</div>
		        <div class="swiper-slide">Slide 4</div>
		        <div class="swiper-slide">Slide 5</div>
		        <div class="swiper-slide">Slide 6</div>
		        <div class="swiper-slide">Slide 7</div>
		        <div class="swiper-slide">Slide 8</div>
		        <div class="swiper-slide">Slide 9</div>
		      </div>
		      <div class="swiper-button-next"></div>
		      <div class="swiper-button-prev"></div>
		      <div class="swiper-pagination"></div>
		    </div>
		    
		    <!-- Initialize Swiper -->
		    <script>
		      var swiper = new Swiper(".mySwiper2", {
		        slidesPerView: 3,
		        spaceBetween: 30,
		        slidesPerGroup: 3,
		        loop: true,
		        loopFillGroupWithBlank: true,
		        pagination: {
		          el: ".swiper-pagination",
		          clickable: true,
		        },
		        navigation: {
		          nextEl: ".swiper-button-next",
		          prevEl: ".swiper-button-prev",
		        },
		      });
		    </script>
	    </div>
	    
	    <br><br>
	    
	    <h1>마감임박 항공권!</h1><br>
	    <div>
			<!-- Swiper3 -->
		    <div class="swiper mySwiper3">
		      <div class="swiper-wrapper">
		        <div class="swiper-slide">Slide 1</div>
		        <div class="swiper-slide">Slide 2</div>
		        <div class="swiper-slide">Slide 3</div>
		        <div class="swiper-slide">Slide 4</div>
		        <div class="swiper-slide">Slide 5</div>
		        <div class="swiper-slide">Slide 6</div>
		        <div class="swiper-slide">Slide 7</div>
		        <div class="swiper-slide">Slide 8</div>
		        <div class="swiper-slide">Slide 9</div>
		      </div>
		      <div class="swiper-button-next"></div>
		      <div class="swiper-button-prev"></div>
		      <div class="swiper-pagination"></div>
		    </div>
		    
		    <!-- Initialize Swiper -->
		    <script>
		      var swiper = new Swiper(".mySwiper3", {
		        slidesPerView: 4,
		        spaceBetween: 20,
		        slidesPerGroup: 4,
		        loop: true,
		        loopFillGroupWithBlank: true,
		        pagination: {
		          el: ".swiper-pagination",
		          clickable: true,
		        },
		        navigation: {
		          nextEl: ".swiper-button-next",
		          prevEl: ".swiper-button-prev",
		        },
		      });
		    </script>
    	</div>
    	
    	<br><br>
    	
    	<h1>마감임박 패키지!</h1><br>
		<div>
			<!-- Swiper4 -->
		    <div class="swiper mySwiper4">
		      <div class="swiper-wrapper">
		        <div class="swiper-slide">Slide 1</div>
		        <div class="swiper-slide">Slide 2</div>
		        <div class="swiper-slide">Slide 3</div>
		        <div class="swiper-slide">Slide 4</div>
		        <div class="swiper-slide">Slide 5</div>
		        <div class="swiper-slide">Slide 6</div>
		        <div class="swiper-slide">Slide 7</div>
		        <div class="swiper-slide">Slide 8</div>
		        <div class="swiper-slide">Slide 9</div>
		      </div>
		      <div class="swiper-button-next"></div>
		      <div class="swiper-button-prev"></div>
		      <div class="swiper-pagination"></div>
      		</div>
      		
      		<!-- Initialize Swiper -->
		    <script>
		      var swiper = new Swiper(".mySwiper4", {
		        slidesPerView: 4,
		        spaceBetween: 20,
		        slidesPerGroup: 4,
		        loop: true,
		        loopFillGroupWithBlank: true,
		        pagination: {
		          el: ".swiper-pagination",
		          clickable: true,
		        },
		        navigation: {
		          nextEl: ".swiper-button-next",
		          prevEl: ".swiper-button-prev",
		        },
		      });
		    </script>
	    </div>

    	
    	<br><br>
		
		<div id="map" style="width:500px;height:400px;"></div>
		
		<!-- 지도 API -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d4c741212991dd85c77c107ac8ba7b95">
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
		   center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		   level: 3 //지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		</script>
		
	</section>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />