package org.kg.controller;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_seatVO;
import org.kg.service.FlightControlService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@AllArgsConstructor
@RequestMapping("/flightControl/*")
public class K_FlightRestController {

	private FlightControlService service;
	
	@PostMapping(value = "/flightInsert", 
			consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> flightInsert(@RequestBody K_flightVO vo){
		log.info("K_flightVO........." + vo);
		
		int insertCount = service.flightInsert_(vo);

		log.info("Reply Insert Count........." + insertCount);
		
		return insertCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/seatInsert", 
			consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> seatInsert(@RequestBody K_seatVO vo){
		log.info("K_flightVO........." + vo);
		
		int insertCount = service.seatInsert_(vo);

		log.info("Reply Insert Count........." + insertCount);
		
		return insertCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
