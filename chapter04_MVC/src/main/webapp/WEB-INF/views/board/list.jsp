<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글 목록
				<button id="regBtn" type="button" class="btn btn-xs pull-right btn-primary">새 게시글 등록</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${list}">
							<tr>
								<td><c:out value="${board.bno}"></c:out></td>
								<td>
									<a class="move" href="${board.bno}">
										<c:out value="${board.title}"></c:out>
									</a>
								</td>
								<td><c:out value="${board.writer}"></c:out></td>
								<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
								<td><fmt:formatDate value="${board.updatedate}" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- page -->
				<div class="pull-right">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage-1 }">&lt;</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" step="1">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':''}">
								<a href="${num }">${num }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="paginate_button">
								<a href="${pageMaker.endPage+1 }">&gt;</a>
							</li>
						</c:if>
					</ul>
				</div>
				<form action="/board/list" method="get" id="actionForm">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				</form>
				<!-- end page -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<script type="text/javascript">
	
	$(function() {
		
		// 새 게시글 등록 버튼 눌렀을 때 
		$("#regBtn").click(function() {
			location.href="/board/register";
		});
		
		// id = actionForm 요소를 변수에 담기
		var actionForm = $("#actionForm");
		
		// class = paginate_button 요소의  a태그  클릭 이벤트
		$(".paginate_button a").click(function(e) {
			// 일단 이벤트 방지
			e.preventDefault();
			// 이름이  pageNum 인   input 객체를 찾고 .val 내가 누른  a태그의 값을 넣겠다??
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		})
		
		// ====== 조회화면 이동 이벤트 처리 ======
		// class = move 요소의 클릭 이벤트
		$(".move").click(function(e) {
			// <a> 클릭시 페이지 이동이 이루어지지 않게 하기 위해서
			e.preventDefault();
			// <a href="${board.bno}"> => href 속성에 들은 값을 가져온다. this를 사용한 이유는 구분짖기 위함
			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});
		
	});

	// 결과창 출력을 위한 코드
	var result = '<c:out value="${result}"/>';
	
	// rttr 객체를 통해 받아온 값이 빈 값이 아닐 때(데이터 변경) 알림 메소드 실행
	if(result != ''){
		checkResult(result);
	}
	
	// 뒤로가기 할 때 문제가 될 수 있으므로
	// history 객체를 조작 ({정보를 담은 객체}, 뒤로가기 버튼 문자열 형태의 제목, 바꿀 url)
	history.replaceState({},null,null);
	function checkResult(result) {
		if(result === '' || history.state){ // 뒤로가기 방지
			return;
		}
		if(result === "ok"){ // 삽입
			alert("게시글이 삽입되었습니다");
			return;
		}
		if(result === "success"){ // 수정, 삭제
			alert("처리가 완료되었습니다");
			return;
		}
	};
	
</script>

<%@ include file="../include/footer.jsp" %>