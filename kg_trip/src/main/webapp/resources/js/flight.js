console.log("flght.js 파일을 불러 왔습니다!")

// 항공사 추가
function airlineAdd(airline, callback, error){
	$.ajax({
		type : 'post',
		url : '/flightManager/airlineInsert',
		data : JSON.stringify(airline), 
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
	});
} // end : flightAdd()


// 항공편 추가
function flightAdd(flight, callback, error){
	$.ajax({
		type : 'post',
		url : '/flightManager/flightInsert',
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
	});
} // end : flightAdd()


// 좌석 추가 
function seatAdd(seat, callback, error) {
	$.ajax({
		type : 'post',
		url : '/flightManager/seatInsert',
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
} // end : seatAdd()

