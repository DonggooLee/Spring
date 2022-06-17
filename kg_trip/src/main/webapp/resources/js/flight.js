console.log("flght.js 파일을 불러왔습니다!")

var flightServiece = $(function() {
	
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
	} // end : addFlight
	

	// 좌석 추가
	function addtest(seat, callback, error) {
		$.ajax({
			type : 'post',
			url : '/flightControl/seatInsert',
			data : JSON.stringify(seat), 
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
	} // end : addSeat
	
	
	return {
		add : add,
		addtest : addtest
	} // end : return
	
}) // end : onload
