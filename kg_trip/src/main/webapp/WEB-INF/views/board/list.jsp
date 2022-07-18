<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<jsp:include page="/WEB-INF/views/include/dheader.jsp" />

<section class="cont">
<div class="bin"></div>
<section class="page_notice">
</section>
<div class="bin"></div>
<section class="page_check">
<div class="checklist">
<button class="button__c1" style="width: 144px; justify-content: flex-start;">한국</button>
<button class="button__c2" style="width: fit-content; justify-content: flex-start;">서울</button>
<button class="button__c2" style="width: fit-content; justify-content: flex-start;">강원도</button>
<button class="button__c2" style="width: fit-content; justify-content: flex-start;">제주도</button>
<button class="button__c2" style="width: fit-content; justify-content: flex-start;">부산</button>
<button class="button__c2" style="width: fit-content; justify-content: flex-start;">경기도</button>
<button class="button__c2" style="width: fit-content; justify-content: flex-start;">인천</button>
<button class="button__c2" style="width: fit-content; justify-content: flex-start;">충청도</button>
<button class="button__c2" style="width: fit-content; justify-content: flex-start;">경상도</button>
<button class="button__c2" style="width: fit-content; justify-content: flex-start;">전라도</button>

</div>
</section>
<div class="bin"></div>
<div class="cards">

		             	
		<c:choose>
        		<c:when test="${not empty list1}">
		             <c:forEach var="list1" items="${list1}" varStatus="status">
		             

		      			  
						  <div id="card" class="card"  style="cursor:pointer;">		           
						  <div class="cardcon1" OnClick="location.href ='/text/boardlist?bno=${list1.bno}&writer=${list1.writer}'">${list1.title}</div>
						  <div class="cardcon2" OnClick="location.href ='/text/boardlist?bno=${list1.bno}&writer=${list1.writer}'"><img src='/text/display?fileName=${list2[status.index].fileName}'></div>
						 	<div class="cardcon3" id='cardcon3'>
						 	<div class="cardcon3-1" id='cardcon3-<c:out value="${list1.bno}"/>'><a class="likel" bno="${list1.bno}" href="javascript:void(0)" style="text-decoration: none;  color: black;">좋아요 ${like[status.index].count}개</a></div>
						 		<c:choose>
									<c:when test="${likevo[status.index].liketf eq 1}">
										<div class="cardcon3-2" id='hearticon-<c:out value="${list1.bno}"/>'><a class="chodelete" who="5" liketf="1" bno="${list1.bno}" href="javascript:" style="cursor: "><i style="color:red;" id="iconf<c:out value='${list1.bno}'/>" class="fa-solid fa-heart" ></i></a></div></c:when>
									<c:otherwise>
									<form>
											<input class="bno" name="bno" type=hidden value="${list1.bno}">
											<input class="who" name="who" type=hidden value=5>
											<input class="tf" name="tf" type=hidden value=1>		
											<div class="cardcon3-2" id='hearticon-<c:out value="${list1.bno}"/>'><a class="cho" who="5" liketf="1" bno="${list1.bno}" href="javascript:"><i style="color:red;" id="icon<c:out value='${list1.bno}'/>" class="fa-regular fa-heart" ></i></a></div>						
									</form>
										
									</c:otherwise>
								</c:choose>

						 	</div>
						  <div class="cardcon4">${list1.writer}</div>	
						  <div class="cardcon5">여기에는 무엇을 넣어볼까요</div>	
						  </div>
						 
						  		
						
						  

		             </c:forEach>
		          </c:when>
 		          <c:otherwise>
						<h5>게시물이 a66fda1습니다.</h5>
 		          </c:otherwise>
             </c:choose>
             	 
        </div>
</section>

<jsp:include page="/WEB-INF/views/board/modallike.jsp" />
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>
	
	function showlikeup(data, data2){
		let go=data;
		let go2=data2;
		
	    console.log(go+"올리기");
	    console.log(go2+"올리기");
	    
	    $("#cardcon3-"+data).html("좋아요 "+data2+"개");
	    $("#hearticon-"+data).html("<a class='chodelete' who='5' liketf='1' bno='"+data+"'href='javascript:'><i style='color:red;' id='iconf"+data+"' class='fa-solid fa-heart'>");
		
	    $(".chodelete").on("click", function() {

		    // 게시물 번호(no)를 idx로 전달받아 저장합니다.
		    let bno = $(this).attr('bno');
		    let who = $(this).attr('who');
		    let tf = $(this).attr('liketf');
		    
		    $(document).off("click", "#iconf"+bno).on('click', '#iconf'+bno, function(){
				
			       
			 
					  $.ajax({
						    type : "GET",
						    url : "/content/likedelete", 
						    data : {
						    	bno:bno,
						    	who:who,
						    	tf:tf,
						    
						    },
						    datatype :"JSON.stringify",
						    

						    error : function(error) {
						    	console.log("error");
						    },
						    success : function(result) {
						        
						 
						    
						    	 
						    	/* showlikeup(xml);  */
						    console.log(result);
						    
						    	
						    var bno2= result.getElementsByTagName("bno")[0].childNodes[0].nodeValue;  
						    var count2= result.getElementsByTagName("count")[0].childNodes[0].nodeValue;
							
						    console.log(bno2+"여기가 삭제");
						    console.log(count2+"삭제");	
						    
						    
						    fullshowlikeup(bno2,count2);
						   /* showlikeup(bno,count); */
						 

							
						    }
						}); 
		});
		    
		   
		
		
		});
	}
	    
	
	function fullshowlikeup(data, data2){
		let go=data;
		let go2=data2;
		
	    console.log(go);
	    console.log(go2);
	    
	    $("#cardcon3-"+data).html("좋아요 "+data2+"개");
	    $("#hearticon-"+data).html("<a class='cho' who='5' liketf='1' bno='"+data+"'href='javascript:'><i style='color:red;' id='icon"+data+"'class='fa-regular fa-heart'>");
	
	    $(".cho").on("click", function() {

		    // 게시물 번호(no)를 idx로 전달받아 저장합니다.
		    let bno = $(this).attr('bno');
		    let who = $(this).attr('who');
		    let tf = $(this).attr('liketf');
		    
		    $(document).off("click", "#icon"+bno).on('click', '#icon'+bno, function(){
				
			       
			 
					  $.ajax({
						    type : "GET",
						    url : "/content/like", 
						    data : {
						    	bno:bno,
						    	who:who,
						    	tf:tf,
						    
						    },
						    datatype :"JSON.stringify",
						    

						    error : function(error) {
						    	console.log("error");
						    },
						    success : function(result) {
						        
						 
						    
						    	 
						    	/* showlikeup(xml);  */
						    console.log(result);
						    
						    	
						    var bno= result.getElementsByTagName("bno")[0].childNodes[0].nodeValue;   //123
						    var count= result.getElementsByTagName("count")[0].childNodes[0].nodeValue;

						   showlikeup(bno,count);
						 

							
						    }
						}); 
		});
		    
		   
		
		
		});
	
	}
	    
	
	//좋아요 추가
	$(".cho").on("click", function() {

	    // 게시물 번호(no)를 idx로 전달받아 저장합니다.
	    let bno = $(this).attr('bno');
	    let who = $(this).attr('who');
	    let tf = $(this).attr('liketf');
	    
	    $(document).off("click", "#icon"+bno).on('click', '#icon'+bno, function(){
			
		       
		 
				  $.ajax({
					    type : "GET",
					    url : "/content/like", 
					    data : {
					    	bno:bno,
					    	who:who,
					    	tf:tf,
					    
					    },
					    datatype :"JSON.stringify",
					    

					    error : function(error) {
					    	console.log("error");
					    },
					    success : function(result) {
					        
					 
					    
					    	 
					    	/* showlikeup(xml);  */
					    console.log(result);
					    
					    	
					    var bno= result.getElementsByTagName("bno")[0].childNodes[0].nodeValue;   //123
					    var count= result.getElementsByTagName("count")[0].childNodes[0].nodeValue;

					   showlikeup(bno,count);
					 

						
					    }
					}); 
	});
	    
	   
	
	
	});
	
	//좋아요삭제
	
	
	$(".chodelete").on("click", function() {

	    // 게시물 번호(no)를 idx로 전달받아 저장합니다.
	    let bno = $(this).attr('bno');
	    let who = $(this).attr('who');
	    let tf = $(this).attr('liketf');
	    
	    $(document).off("click", "#iconf"+bno).on('click', '#iconf'+bno, function(){
			
		       
		 
				  $.ajax({
					    type : "GET",
					    url : "/content/likedelete", 
					    data : {
					    	bno:bno,
					    	who:who,
					    	tf:tf,
					    
					    },
					    datatype :"JSON.stringify",
					    

					    error : function(error) {
					    	console.log("error");
					    },
					    success : function(result) {
					        
					 
					    
					    	 
					    	/* showlikeup(xml);  */
					    console.log(result);
					    
					    	
					    var bno2= result.getElementsByTagName("bno")[0].childNodes[0].nodeValue;  
					    var count2= result.getElementsByTagName("count")[0].childNodes[0].nodeValue;
						
					    console.log(bno2+"여기가 삭제");
					    console.log(count2+"삭제");	
					    
					    
					    fullshowlikeup(bno2,count2);
					   /* showlikeup(bno,count); */
					 

						
					    }
					}); 
	});
	    
	   
	
	
	});
	
		
	
	
	 
	</script>
</body>
</html>