console.log("flight.js 파일을 불러 왔습니다 !")

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


// 일정 추가
function schduleAdd(schdule, callback, error) {
	$.ajax({
		type : 'post',
		url : '/flightManager/scheduleInsert',
		data : JSON.stringify(schdule), 
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
} // end : schduleAdd()


// 항공편 조회
function listFlight(callback, error) {
	$.ajax({
		type : 'get',
		url : '/flightManager/flightList',
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
} // end : listFlight()


// 공항 조회
function listAirport(callback, error) {
	$.ajax({
		type : 'get',
		url : '/flightManager/airportList',
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
} // end : listAirport()


// 항공사 조회
function listAirline(callback, error) {
	$.ajax({
		type : 'get',
		url : '/flightManager/airlineList',
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
} // end : listAirline()


// 일정 조회
function listSchedule(input, callback, error) {
	$.ajax({
		type : 'post',
		url : '/flightManager/getSchedule',
		// 보내는 데이터
		data : JSON.stringify(input), 
		// 보내는 데이터의 타입
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
} // end : listSchedule()
