package org.kg.controller;

import java.util.List;

import org.kg.domain.K_airlineVO;
import org.kg.domain.K_airportVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_scheduleVO;
import org.kg.domain.K_seatVO;
import org.kg.domain.K_inputScheduleDTO;
import org.kg.domain.K_getScheduleVO;
import org.kg.service.FlightService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	private FlightService service;
	
	// 항공사 추가
	@PostMapping(value = "/airlineInsert", 
			consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> airlineInsert(@RequestBody K_airlineVO vo){
		log.info("K_airlineVO..." + vo);
		int insertCount = service.airlineInsert_(vo);
		log.info("Reply Insert Count..." + insertCount);
		return insertCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 항공편 추가
	@PostMapping(value = "/flightInsert", 
			consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> flightInsert(@RequestBody K_flightVO vo){
		log.info("K_flightVO..." + vo);
		int insertCount = service.flightInsert_(vo);
		log.info("Reply Insert Count..." + insertCount);
		return insertCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 좌석 추가
	@PostMapping(value = "/seatInsert",
			consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> seatInsert(@RequestBody K_seatVO vo){
		log.info("K_seatVO..." + vo);
		int insertCount = service.seatInsert_(vo);
		log.info("Reply Insert Count..." + insertCount);
		return insertCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 일정 추가
	@PostMapping(value = "/scheduleInsert",
			consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> scheduleInsert(@RequestBody K_scheduleVO vo){
		log.info("K_scheduleVO..." + vo);
		int insertCount = service.scheduleInsert_(vo);
		log.info("Reply Insert Count..." + insertCount);
		return insertCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 공항 조회
	@GetMapping(value = "/airportList", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<K_airportVO>> airportList(){
		log.info("공항 조회...");
		return new ResponseEntity<>(service.airportList_(), HttpStatus.OK);
	}
	
	// 항공편 조회
	@GetMapping(value = "/flightList", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<K_flightVO>> flightList(){
		log.info("항공편 조회...");
		return new ResponseEntity<>(service.flightList_(), HttpStatus.OK);
	}
	
	// 항공사 조회
	@GetMapping(value = "/airlineList", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<K_airlineVO>> airlineList(){
		log.info("항공사 조회...");
		return new ResponseEntity<>(service.airlineList_(), HttpStatus.OK);
	}
	
	// 해당 일자에 항공편 조회
	@PostMapping(value = "/getSchedule", 
			consumes = "application/json", 
			produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<K_getScheduleVO>> getSchedule(@RequestBody K_inputScheduleDTO inputSch){
		log.info("일정 조회...");
		log.info("inputSch : " + inputSch);
		return new ResponseEntity<>(service.scheduleList_(inputSch), HttpStatus.OK);
	}
	
}
