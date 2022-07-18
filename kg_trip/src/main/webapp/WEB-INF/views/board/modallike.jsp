<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>



<!-- Modal -->
<div class="modal-wrapper">
  <div class="modal">
    <div class="head">
      <div class="likehead">좋아요     
	       <a class="btn-close trigger">
	        <i class="fa fa-times" aria-hidden="true"></i>
	      </a>
      </div>
    </div>
    <div class="content">
        <div class="good-job" id="good">
          
          	
        </div>
    </div>
  </div>
</div>

<script>

$( document ).ready(function() {
	
	var likewhomodal=0;
	
	$(".likel").on("click", function() {
		$(".modal-wrapper").css("display","block");
		$("#good").html("");
	    // 게시물 번호(no)를 idx로 전달받아 저장합니다.
	    let bno = $(this).attr('bno');
	    var likewho;
	    
	    
	    
	    $.ajax({
		    type : "GET",
		    url : "/content/alllike", 
		    data : {
		    	bno:bno,
		 
		    },
		    datatype :"JSON.stringify",
		    

		    error : function(error) {
		    	console.log("error");
		    },
		    success : function(result) {
		    
		    	 
		    	
		    	
	
		    
		    $('.modal-wrapper').toggleClass('open');
		    $('.page-wrapper').toggleClass('blur-it');
		    	
		    if(result.getElementsByTagName("likewho")[0].childNodes[0].nodeValue == 0){
		    	$("#good").html("<i class='fa fa-thumbs-o-up' aria-hidden='true'></i>");
		    	
		    }
		    else{
		    	
		    	 $(result).find('item').each(function(){
                     likewho = $('likewho', this).text();
                     var str = "<div class='inmodal'>"+likewho+"</div>"
                     $("#good").append(str);
                     
                 });
		        	
		        	  }

		        	
		       }

		}); 

	});
	
	$(".btn-close.trigger").on("click", function(){
	    $('.modal-wrapper').toggleClass('open');
	    $('.page-wrapper').toggleClass('blur-it');
		$(".modal-wrapper").fadeOut("0");
		
		return false;
	})
	  
	 
});



</script>