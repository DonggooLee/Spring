<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>

	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple">
	</div>
	
	<div class="uploadResult">
		<ul>
			
		</ul>
	</div>
	
	<button id="uploadBtn">Upload</button>
	
	<script type="text/javascript">
	
		$(function() {
			
			// 확장자 및 파일 크기에 대한 정규식
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			// 1B = 8bit / 1KB = 1024b / 1MB = 1024kb
			// var maxSize = 20971520; //20MB
			var maxSize = 5242880; //5MB

			function checkExtension(fileName, fileSize) {
				if (fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				if (regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드할 수 없습니다");
					return false;
				}
				return true;
			} // end : checkExtension
			
			// 버튼 클릭 전 초기 상태 복사
			var cloneObj = $(".uploadDiv").clone();
			
			// 업로드 버튼 클릭 이벤트
			$("#uploadBtn").on("click",function(){
				var formData = new FormData(); // form 태그를 가상으로 만들어 사용하는 의미
				var inputFile = $("input[name='uploadFile']");
				// inputFile으로 받은 리스트 값중 0번째 인덱스의 파일 값
				var files = inputFile[0].files;
				for(var i=0; i<files.length; i++){
					// false 가 넘어왔을 때
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					}
					formData.append("uploadFile", files[i]);
				}	
				$.ajax({
		               url : "/uploadAjaxAction",
		               type : "post",
		               processData : false,
		               contentType : false,
		               data : formData,
		               dataType : "json",	
		               // 받는 데이터의 타입이 json
		               success : function(result) {
		            	   console.log(result)
		            	   // 성곻적으로 업로드 되어 리턴 받으면 초기값으로 다시 세팅
		            	   $(".uploadDiv").html(cloneObj);
		            	   // 받아온 값을 showUploadFile 함수에 담기
		            	   showUploadFile(result);
		               }
		       }); 
			}) // end : uploadBtn
			
			// 파일 업로드 후 업로드 된 파일 결과 화면에 보여주기
			var uploadResult = $(".uploadResult ul");
			
			function showUploadFile(uploadResultArr) {
				var str = '';
				for(var i=0; i<uploadResultArr.length; i++){
					var obj = uploadResultArr[i];
					// encodeURIComponent => 각 종 특수문자를 제대로 보내주려면 인코딩이 필요
					var fileCallpath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					str += '<li>'; 
					str += "<a href=/download?fileName=" + fileCallpath + ">";
					str += '<img src="resources/img/cat.png" style="width: 11px;"/> ';
					str += obj.fileName;
					str += "</a>";
					str += "<span data-file='" + fileCallpath + "'> X </span>";
					str += '</li>';
				}
				// for문 다 돌면 str에 담긴 데이터  붙이기
				uploadResult.html(str);
				// uploadResult 객체 안 span 객체 클릭 시 이벤트
				uploadResult.on("click", "span", function() {
					// this 의미 = <span> 객체
					var targetFile = $(this).data("file");
					// span 태그 안 data-file 속성의 값이 담김
					console.log(targetFile);
					$.ajax({
			               url : "/deleteFile",
			               data : {fileName : targetFile},
			               type : "post",
			               dataType : "text",
			               success : function(result) {
								alert(result);
			               }
			       });
				}) // end : uploadResult.span
			} // end : showUploadFile
			
		}) // end : onload
		
	</script>
	
</body>
</html>