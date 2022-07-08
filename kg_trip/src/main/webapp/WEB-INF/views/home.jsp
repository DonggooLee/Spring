<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>

<jsp:include page="/WEB-INF/views/include/header.jsp" />
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->

	<section class="cont">
	
		<div class="event">
		</div>
		
		<div style="height: 500px; ">
			<img src="/img/main.jpg" style="width: 100%;">
		</div>
		
		<br><br>
		
		<div id="map" style="width:500px;height:400px;"></div>
		
		<!-- 지도 API -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bb3cb6b25b4f8327f491d5c78447c63c"></script>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bb3cb6b25b4f8327f491d5c78447c63c&libraries=LIBRARY"></script>
		<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bb3cb6b25b4f8327f491d5c78447c63c&libraries=services,clusterer,drawing"></script>
		
		<script type="text/javascript">
		
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			
			var options = { //지도를 생성할 때 필요한 기본 옵션
				center: new kakao.maps.LatLng(37.4820800, 126.8980980), //지도의 중심좌표.
				level: 2, //지도의 레벨(확대, 축소 정도)
				draggable : true,
				keyboardShortcuts : true
			};
		
			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
			
		</script>
		
	</section>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />