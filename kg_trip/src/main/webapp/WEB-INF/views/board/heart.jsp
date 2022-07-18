<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/resources/css/dohyun.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resources/ckeditor/ckeditor.js"></script>

</head>
<body>
	
	${tf}
	${vo.writer}<br>
	${vo.content}<br>	
	${vo.title }<br>
	${vo.bno }<br>
	${vo.regdate }<br>
	${vo.imageVO }<br>
	${tf3}
	
	
	<c:choose>
	<c:when test="${tf eq 0}"> 
	<form>
		<input class="bno" name="bno" type=hidden value="${vo.bno}">
		<input class="who" name="who" type=hidden value=5>
		<input class="tf" name="tf" type=hidden value=1>
		<button id="like" name="like" >좋아요</button>
	</form>  
	</c:when>
		<c:otherwise> <button id="like" name="like" >좋아요취소</button> </c:otherwise>
	</c:choose>
	 
	
	
	<script>
	  $('#like').on('click', function(){
	        
		  $.ajax({
			    type : "POST",
			    url : "/content/like", 
			    data : $('form').serialize(),
			    error : function(error) {
			    	console.log("error");
			    },
			    success : function(data) {
				console.log("success");
			    }
			});
	    });
		
	  

		
	 
	</script>

</body>
</html>