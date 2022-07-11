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

// 항공 일정 추가
function insertSchedule(schdule, callback, error) {
	$.ajax({
		type : 'post',
		url : '/flightManager/insertSchedule',
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
} // end : insertSchedule()

//항공편 조회
function listFlight(param, callback, error) {
	var c_aircode = param;
	$.ajax({
		type : 'get',
		url : '/flightManager/flightList/' + c_aircode,
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

//일정 조회
function listSchedule(param, callback, error) {
	var c_aircode = param;
	$.ajax({
		type : 'get',
		url : '/flightManager/scheduleList/' + c_aircode,
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

// 일정 조회 (이코노미 좌석)
function listScheduleEco(input, callback, error) {
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
} // end : listScheduleEco()

// 일정 조회 (비즈니스 좌석)
function listScheduleBis(input, callback, error) {
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
} // end : listScheduleBis()

// 일정 조회 (퍼스트 좌석)
function listScheduleFir(input, callback, error) {
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
} // end : listScheduleFir()

// 좌석 조회
function getSeatList(param, callback, error) {
	$.ajax({
		type : 'post',
		url : '/flight/getSeatList',
		// 보내는 데이터
		data : JSON.stringify(param), 
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
} // end : getSeatList()

// 예약 좌석 조회
function getReservationSeatList(param, callback, error) {
	$.ajax({
		type : 'post',
		url : '/flight/getReservationSeatList',
		// 보내는 데이터
		data : JSON.stringify(param), 
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
} // end : getReservationSeatList()