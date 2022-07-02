package org.kg.controller;

import java.util.List;

import org.kg.domain.K_getScheduleDTO;
import org.kg.domain.K_airportVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_inputScheduleDTO;
import org.kg.domain.K_insertScheduleDTO;
import org.kg.service.K_FlightService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
	@GetMapping(value = "/airportList", 
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<K_airportVO>> airportList(){
		log.info("공항 조회...");
		return new ResponseEntity<>(service.airportList_(), HttpStatus.OK);
	}
	
	// 항공편 조회
	@GetMapping(value = "/flightList/{c_aircode}", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<K_flightVO>> flightList(@PathVariable("c_aircode") String c_aircode){
		log.info("항공편 조회...");
		return new ResponseEntity<>(service.flightList_(c_aircode), HttpStatus.OK);
	}
	
	// 항공일정 추가
	@PostMapping(value = "/insertSchedule",
			consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> scheduleInsert(@RequestBody K_insertScheduleDTO insertSch){
		log.info("K_insertScheduleDTO..." + insertSch);
		int insertCount = service.insertSchedule_(insertSch);
		log.info("Reply Insert Count..." + insertCount);
		return insertCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 항공편 일정 조회 (조건 : 좌석 등급 )
	@PostMapping(value = "/getSchedule", 
			consumes = "application/json", 
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<K_getScheduleDTO>> getSchedule(@RequestBody K_inputScheduleDTO inputSch){
		log.info("일정 조회...");
		log.info("inputSch : " + inputSch);
		if(inputSch.getSeat_grade().equals("FIRST") ) {
			return new ResponseEntity<>(service.searchScheduleFir_(inputSch), HttpStatus.OK);
		}else if (inputSch.getSeat_grade().equals("BUSINESS") ) {
			return new ResponseEntity<>(service.searchSchedulBis_(inputSch), HttpStatus.OK);
		}else {
			return new ResponseEntity<>(service.searchScheduleEco_(inputSch), HttpStatus.OK);
		}
	}
	
}
