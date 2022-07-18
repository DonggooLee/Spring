<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/resources/css/dohyun.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.content{
	width:150px;
	height:1511px;

}
</style>
<script src="/resources/ckeditor/ckeditor.js"></script>

</head>
<body>
<form method="post" action="/text/insert" >
	제목<input type="text" name="title" id="title"><br>
	작성자<input type="text" name="writer" id="writer"><br>
	<textarea name="content" id="content" ></textarea>
	<div class="inputArea">
				<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
	</div>
	<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;"><br>
		
	<div id="uploadResult">
</div>
<!-- 	
<div id="result_card">
	<div class="imgDeleteBtn">x</div>
	<img src="/text/display?2022/07/04/s_1f10b04c-79f0-4725-968e-d9b65a5f4bf0_google-home-mini-press-v2-720x720.jpg">
</div> -->
</form>
	<script>
	
	function showUploadImage(uploadResultArr){
		
		/* 전달받은 데이터 검증 */
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		
		let obj = uploadResultArr;
		
		let str = "";
		
		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
	
		
		str += "<div id='result_card'>";
		str += "<img src='/text/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
		str += "<input type='hidden' id='uploadPath' name='uploadPath'  value='"+obj.uploadPath+"'>";
		str += "<input type='hidden' id='uuid' name='uuid' value='"+obj.uuid+"'>";
		str += "<input type='hidden' id='fileName' name='fileName' value='"+fileCallPath+"'>";
		str += "</div>";		
		
   		uploadResult.append(str);     

	}	

	function deleteFile(){
		
		let targetFile = $(".imgDeleteBtn").data("file");
		
		let targetDiv = $("#result_card");
		
		$.ajax({
			url: '/text/deleteFile',
			data : {fileName : targetFile},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				console.log(result);
				
				targetDiv.remove();
				$("input[type='file']").val("");
				
			},
			error : function(result){
				console.log(result);
				
				alert("파일을 삭제하지 못하였습니다.")
			}
		});
	}
	
	/* 이미지 삭제 버튼 동작 */
	$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
		
		deleteFile();
		
	});
	
	$("input[type='file']").on("change", function(e){
		
		let targetDiv = $("#result_card");
		let d1 = document.getElementById("uploadResult");		
		let formData = new FormData();
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		
		if(!fileCheck(fileObj.name, fileObj.size)){
			
			
			return false;
		}
		
		targetDiv.remove();
		alert("통과");
		
		console.log("fileList : " + fileInput);
		console.log("fileObj : " + fileObj);
		console.log("fileType(MimeType) : " + fileObj.type);
		
		formData.append("uploadFile", fileObj);
		
		$.ajax({
			url: '/text/uploadAjaxAction',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',
	    	success : function(result){
	    		showUploadImage(result);
	    		console.log(result);
	    	}
		
		,error:function(request,status,error){    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}
		
		});	
		
		
		
	});
	
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 10485760; //1MB
	

	
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			$('input[name="uploadFile"]').val("");
			return false;
		}
			  
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			$('input[name="uploadFile"]').val("");
			return false;
		}
		
		return true;		
		
	}
	
	 var ckeditor_config = {
	   resize_enaleb : false,
	   enterMode : CKEDITOR.ENTER_BR,
	   shiftEnterMode : CKEDITOR.ENTER_P,
	   filebrowserUploadUrl : "/admin/goods/ckUpload"
	 };
	 
	 CKEDITOR.replace("content", ckeditor_config);
	 

		
	 
	</script>

</body>
</html>