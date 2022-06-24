package org.kg.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/kakaopay/{test}", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public String kakaopay(@PathVariable("test") String test) {
		log.info(test);
		try {
			// 주소
			URL addr = new URL("https://kapi.kakao.com/v1/payment/ready");
			// 서버 연결
			HttpURLConnection serverConn = (HttpURLConnection)addr.openConnection();
			serverConn.setRequestMethod("POST");
			serverConn.setRequestProperty("Authorization", "KakaoAK 7f0d70eee3a169f9c0b2267692ce2ac9");
			serverConn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			// 연결을 통해서 넣어줄게 있는지 없는지 판단 : output은 기본적으로 false이기 때문에
 			serverConn.setDoOutput(true);
 			String parameter = "cid=TC0ONETIME&"
 					+ "partner_order_id=partner_order_id&"
 					+ "partner_user_id=partner_user_id&"
 					+ "item_name=초코파이&quantity=1&total_amount=30000&"
 					+ "vat_amount=200&tax_free_amount=0&"
 					+ "approval_url=http://localhost:8080/flight/success&"
 					+ "fail_url=http://localhost:8080/fail&"
 					+ "cancel_url=http://localhost:8080/cancel";
 			// 주는애
 			OutputStream output = serverConn.getOutputStream();
 			// 데이터 주는애
 			DataOutputStream dataOutput = new DataOutputStream(output);
 			dataOutput.writeBytes(parameter);
 			// close()만 해도 dataOutput.flush()가 선행되어진다  flush하면 데이터를 보내고(?)비운다는 의미이기 때문에 전송함
 			dataOutput.close();
 			int result = serverConn.getResponseCode();
 			// 받는애
 			InputStream input;
 			if(result == 200) {
 				// 통신성공
 				input = serverConn.getInputStream();
 			}else {
 				// 통신실패
 				input = serverConn.getErrorStream();
 			}
 			// 읽는애
 			InputStreamReader reader = new InputStreamReader(input);
 			// 형변환(?)느낌  => 바이트로 통신했기 때문에!
 			BufferedReader casReader = new BufferedReader(reader);
 			// 문자열로 형변환하고 찍어준다 
 			return casReader.readLine();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 그곳에 도달한경우는 try문 내에서 예외가 발생해 try문 밖으로 빠져나온 경우에 서버작업이 실패했다는 의미로 주는 값
		// 올바르게 작업이 처리된경우는 트라이문 안에있는 return에 도달하고 함수가 끝나게됩니다
		return "{\"result\":\"NO\"}";
	}
	
}
