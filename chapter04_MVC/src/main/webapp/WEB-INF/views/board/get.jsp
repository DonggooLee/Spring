<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 화면</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글 화면</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group">
					<label>글 번호</label>
					<input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>글 제목</label>
					<input class="form-control" name="title" value='<c:out value="${board.title }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>글 내용</label>
					<textarea class="form-control" name="content" rows="3" readonly="readonly"><c:out value="${board.content }"/></textarea>
				</div>
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>
				<button data-oper="modify" class="btn btn-primary">수정</button>
				<button data-oper="list" class="btn btn-warning">목록</button>
				
				<form action="/board/modify" method="get" id="operForm">
					<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'/>
					<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount" value="${cri.amount }">
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class = 'row'>
   <div class = "col-lg-12">
      <!-- /.panel -->
      <div class = "panel panel-default">
         <div class= "panel-heading">
            <i class = "fa fa-comments fa-fw"></i> 댓글
            <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">댓글 달기</button>
         </div>
         <!-- /.panel-heading -->
         <div class = "panel-body">
            <ul class = "chat">
               <!-- start reply -->
               <li class = "left clearfix" data-rno = '12'>
                  <div>
                     <div class = "header">
                        <strong class = "primary-font">user00</strong>
                        <small class = "pull-right text-muted">2018-01-01 13:13</small>                        
                     </div>
                     <p>Good job!</p>
                  </div>
               </li>
               <!-- end reply -->
            </ul>
            <!-- ./ end ul -->
         </div>
         <!-- /.panel .chat-panel -->
      </div>
   </div>
   <!-- ./end row -->
</div>

<!-- Modal -->
<div class="modal fade" id = "MyModal" tabindex = "-1" role = "dialog"
	aria-labelledby = "myModalLabel" aria-hidden = "true">
	<div class = "modal-dialog">
		<div class = "modal-content">
			<div class = "modal-header">
				<button type = "button" class = "close" data-dismiss = "modal"
					ari-hidden = "true">&times;</button>
				<h4 class = "modal-title" id = "myModalLabel">새 게시글 등록</h4>
			</div>
			<div class = "modal-body">
				<div class = "form-group">
					<label>댓글</label>
					<input class = "form-control" name = 'reply' value = 'New Reply!!!!'>
				</div>
				<div class = "form-group">
					<label>작성자</label>
					<input class = "form-control" name = 'replyer' value = 'replyer'>
				</div>
				<div class = "form-group">
					<label>등록 날짜</label>
					<input class = "form-control" name = 'replyDate' value = '' >
				</div>
			</div>
			<div class = "modal-footer">
				<button id = 'modalModBtn' type = "button" class = "btn btn-warning">수정</button>
				<button id = 'modalRemoveBtn' type = "button" class = "btn btn-danger">삭제</button>
				<button id = 'modalRegisterBtn' type = "button" class = "btn btn-primary">등록</button>
				<button id = 'modalCloseBtn' type = "button" class = "btn btn-default">취소</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript" src="/resources/js/util.js"></script>
<script type="text/javascript">

	$(function() {
		
		// id = operForm 인 요소 변수에 담기
		var operForm = $("#operForm");
		
		// button 태그의  data-oper 속성값이  modify 인  요소 클릭시 이벤트
		$("button[data-oper='modify']").click(function() {
			// operForm 에 속성 action = /board/modify 로 만든 후 submit();
			operForm.attr("action", "/board/modify").submit();
		});
		
		// button 태그의  data-oper 속성값이  list 인  요소 클릭시 이벤트
		$("button[data-oper='list']").click(function() {
			// operForm 안에는  bno 값도 있지만  리스트로 이동할 때는  필요 없기 때문에 지워주기!
			operForm.find("#bno").remove();
			// operForm 에 속성 action = /board/list 로 만든 후 submit();
			operForm.attr("action", "/board/list").submit();
			al
		});
		
	})

</script>
<script type="text/javascript">
	
	console.log("================");
	console.log("JS TEST");
	
	$(function() {
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat"); // 제이쿼리 문법
		
		showList(1);
		function showList(page) {
			
			replyService.getList({bno:bnoValue, page:page || 1}, function(list){
				var str = '';
				if(list == null || list.length==0){
					// 댓글 리스트가 없으면
					// empty() 동일
					// append 이어쓰기 / html 덮쓰기
					replyUL.html("");
					return;
				}else{
					// 댓글 리스트가 있으면
					for(var i=0; i<list.length; i++){
						str += "<li class = 'left clearfix' data-rno = '" + list[i].rno + "'>";
						str += "<div>";
						str += "<div class = 'header'>";
						str += "<strong class = 'primary-font'>" + list[i].replyer + "</strong>";
						str += "<small class = 'pull-right text-muted'>" + displayTime(list[i].replyDate) + "</small>";                          
						str += "</div>";
						str += "<p>" + list[i].reply + "</p>";
						str += "</div>";
						str += "</li>";
					};
					// append를 하면 기존에 가지고 있는 값은 그대로 사용하기 때문에  html 사용
					replyUL.html(str);
				};
			});
			
		};
		
		/* ---------------------------------------------------------------- */
		
		// 모달 창 관련 스크립트
		var modal = $(".modal");
		
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		// 댓글 달기 버튼 클릭 이벤트
		$("#addReplyBtn").on("click", function(e){
		   modal.find("input").val("");               // 입력 창 비우기
		   modalInputReplyDate.closest("div").hide();      // 등록 날짜 입력 창 숨기기
		   //modal.find("button[id!=modalCloseBtn]").hide(); // 취소 버튼 제외 숨기기
		   modalModBtn.hide();            // 수정 버튼 숨기기
		   modalRemoveBtn.hide();         // 삭제 버튼 숨기기
		   modalRegisterBtn.show();      // 등록 버튼 보이기
		   
		   $(".modal").modal("show");      // 모달 창 보이기
		});
		
		// (댓글 등록)취소 버튼 클릭 이벤트
		$("#modalCloseBtn").on("click", function(e){
		   $(".modal").modal("hide");  	 // 모달 창 숨김
		});
		
		// 모달 댓글 
		// 값 비우고 숨기기
		// 1. 삽입에 대한 내용 경고창 알려주기
		// 2. 입력 input 비워주기
		// 3. 모달창 숨기기
		modalRegisterBtn.on("click", function(e){
			replyService.add(
				{bno:bnoValue, reply:modalInputReply.val(), replyer:modalInputReplyer.val()},
				function(result) {
					// js 파일에서 성공한다면 콜백 함수가 실행되면서 result값이 넘어 오는것을 받는다
					alert("result : " + result);
					$(".modal").modal("hide");
				}
			);	   
		});
		
	});
	
	
	// var bnoValue = '<c:out value="${board.bno}"/>';
	
	/* replyService.get(6, function(result){
		console.log(result);
	}); */
	
	
	/* replyService.update(
		{rno:7, reply:'댓글수정테스트'},
		function(result) {
			alert("result : " + result);
		}
	); */
	
	
	/* replyService.remove(5, function(result){
		if(result=="success"){
			alert("댓글이 삭제 되었습니다.")
		}else{
			alert("댓글이 삭제에 실패했습니다.")
		}
	}); */
	
	
	/* replyService.getList({bno:bnoValue, page:1}, function(list){
			for(var i=0; i<list.length; i++){
				console.log(list[i]);
			};
	}); */
	
	
	// add 함수를 호출하고 필요한 인자값 3개중 에러를 제외한 2개 던져준다
	/* replyService.add(
		{bno:bnoValue, reply:'JS TEST00', replyer:'tester00'},
		function(result) {
			// js 파일에서 성공한다면 콜백 함수가 실행되면서 result값이 넘어 오는것을 받는다
			alert("result : " + result);
		}
	); */
	
</script>

<%@include file="../include/footer.jsp" %>