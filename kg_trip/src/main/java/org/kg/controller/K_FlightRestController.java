package org.kg.controller;

import java.util.List;

import org.kg.domain.K_getScheduleDTO;
import org.kg.domain.K_airportVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_getResrvationInfoVO;
import org.kg.domain.K_inputScheduleDTO;
import org.kg.domain.K_insertScheduleDTO;
import org.kg.domain.K_scheduleDTO;
import org.kg.service.K_FlightService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/flightManager")
@AllArgsConstructor
public class K_FlightRestController {
	
	private K_FlightService service;
	
	// 공항 조회
	@GetMapping(value = "/airportList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<K_airportVO>> airportList(){
		log.info("공항 조회...");
		return new ResponseEntity<>(service.airportList_(), HttpStatus.OK);
	}
	
	// 항공사 조회
	@GetMapping(value = "/flightList/{c_aircode}", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<K_flightVO>> flightList(@PathVariable("c_aircode") String c_aircode){
		log.info("항공사 조회...");
		log.info("c_aircode..." + c_aircode);
		return new ResponseEntity<>(service.flightList_(c_aircode), HttpStatus.OK);
	}
	
	// 항공편 일정 조회
	@GetMapping(value = "/scheduleList/{c_aircode}", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<K_scheduleDTO>> scheduleList(@PathVariable("c_aircode") String c_aircode){
		log.info("항공편 일정 조회...");
		log.info("c_aircode..." + c_aircode);
		return new ResponseEntity<>(service.scheduleList_(c_aircode), HttpStatus.OK);
	}
	
	// 항공편 일정 추가
	@PostMapping(value = "/insertSchedule", consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> scheduleInsert(@RequestBody K_insertScheduleDTO insertSch){
		log.info("항공편 일정 추가...");
		log.info("K_insertScheduleDTO : " + insertSch);
		int insertCount = service.insertSchedule_(insertSch);
		log.info("Reply Insert Count..." + insertCount);
		return insertCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 항공편 일정 삭제
	@DeleteMapping(value = "/deleteSchedule/{date_idx}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> deleteSchedule(@PathVariable("date_idx") String date_idx){
		log.info("항공편 일정 삭제...");
		log.info("date_idx..." + date_idx);
		int result = service.deleteSchedule_(date_idx);
		return result == 1 ?
				new ResponseEntity<>("일정이 정상적으로 삭제 되었습니다 !", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 항공편 일정 조회 (조건 : 좌석 등급 )
	@PostMapping(value = "/getSchedule", consumes = "application/json", 
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<K_getScheduleDTO>> getSchedule(@RequestBody K_inputScheduleDTO inputSch){
		log.info("일정 조회...");
		log.info("K_inputScheduleDTO : " + inputSch);
		if(inputSch.getSeat_grade().equals("FIRST") & inputSch.getOrderby().equals("date")) {
			log.info("퍼스트석 & 탑승시간순 정렬");
			return new ResponseEntity<>(service.searchScheduleFir_(inputSch), HttpStatus.OK);
		}else if (inputSch.getSeat_grade().equals("BUSINESS") & inputSch.getOrderby().equals("date")) {
			log.info("비즈니스석 & 탑승시간순 정렬");
			return new ResponseEntity<>(service.searchSchedulBis_(inputSch), HttpStatus.OK);
		}else if (inputSch.getSeat_grade().equals("ECONOMY") & inputSch.getOrderby().equals("date")){
			log.info("이코노미석 & 탑승시간순 정렬");
			return new ResponseEntity<>(service.searchScheduleEco_(inputSch), HttpStatus.OK);
		}else if(inputSch.getSeat_grade().equals("FIRST") & inputSch.getOrderby().equals("lowPrice")){
			log.info("퍼스트석 & 최저가순 정렬");
			return new ResponseEntity<>(service.searchScheduleFirPirce_(inputSch), HttpStatus.OK);
		}else if(inputSch.getSeat_grade().equals("BUSINESS") & inputSch.getOrderby().equals("lowPrice")){
			log.info("비즈니스석 & 최저가순 정렬");
			return new ResponseEntity<>(service.searchSchedulBisPrice_(inputSch), HttpStatus.OK);
		}else {
			log.info("이코노미석 & 최저가순 정렬");
			return new ResponseEntity<>(service.searchScheduleEcoPrice_(inputSch), HttpStatus.OK);
		}
	}
	
	// 항공권 예약 조회
	@GetMapping(value = "myReservation/{reservation_idx}", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<K_getResrvationInfoVO> myReservation(@PathVariable("reservation_idx") String reservation_idx) {
		log.info("항공권 예약조회...");
		log.info("reservation_idx : " + reservation_idx);
		return new ResponseEntity<>(service.getResrvationInfo_(reservation_idx), HttpStatus.OK);
	}
	
}