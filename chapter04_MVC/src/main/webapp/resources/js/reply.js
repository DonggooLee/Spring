console.log("Reply Module...");

var replyService = (function() {
	
	// replyService.add();
	function add(reply, callback, error) {
	
		console.log("add reply...");
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er)
				}
			}
		});
		
	}
	
	return {
		// add(오른쪽) 라는 함수를 add(왼쪽) 라는 명칭으로 던진다
		add : add
	}
	
})();
