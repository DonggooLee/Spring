console.log("flght.js 파일을 불러왔습니다!")

var flightServiece = $(function() {
	
	console.log("flightServiece 변수를 불러왔습니다!")
	
	// 항공편 추가
	function add(flight, callback, error) {
		$.ajax({
			type : 'post',
			url : '/flightControl/flightInsert',
			data : JSON.stringify(flight), 
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr) {
				if(callback){
					callback(result)
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er)
				}
			}
		})
	} // end

	return {
		add : add
	} // end : return
	
}) // end : onload
