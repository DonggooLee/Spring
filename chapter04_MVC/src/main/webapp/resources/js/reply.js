console.log("Reply Module...");

function displayTime(timeValue){
	   var today = new Date();
	   var gap = today.getTime() - timeValue;
	   var dateObj = new Date(timeValue);
	   var str = "";
	   
	   if(gap < (1000 * 60 * 60 * 24)){
	      var hh = dateObj.getHours();
	      var mi = dateObj.getMinutes();
	      var ss = dateObj.getSeconds();
	      return [(hh>9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
	   }else{
	      var yy = dateObj.getFullYear();
	      var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
	      var dd = dateObj.getDate();
	      return [yy, '/', (mm > 9 ? '' : '0')+mm, '/', (dd > 9 ? '' : '0') + dd].join('');
	   }
}

var replyService = (function() {
	
	// replyService.add();
	function add(reply, callback, error) {
	
		$.ajax({
			// 데이터 타입 및 url은 컨트롤러 기준으로 보내준다
			type : 'post',
			url : '/replies/new',
			// JSON.stringify()는 자바스크립트의 값을 JSON 문자열로 변환
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
	
	//replyService.getList();
	function getList(param, callback, error) {
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.ajax({
			type : 'get',
			url : '/replies/pages/'+bno+'/'+page+'.json',
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
	
	//replyService.remove();
	function remove(rno, status, error) {
		
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
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
	
	//replyService.update();
	function update(reply, callback, error) {
		
		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			// reply 전달 받은 객체
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
	
	//replyService.get();
	function get(rno, callback, error) {
		
		$.ajax({
			type : 'get',
			url : '/replies/' + rno,
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
		// 왼쪽(키) 오른쪽(벨류:함수명) 자바스크립트 선언적 함수 부분 참고!!!!!
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get
	}
	
})();
