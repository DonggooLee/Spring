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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_CorpMemberVO;
import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.K_getSeatVO;
import org.kg.domain.K_bookInfo;
import org.kg.domain.K_checkSeatVO;
import org.kg.domain.K_getInfoDTO;
import org.kg.service.K_FlightService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/flight/*")
@AllArgsConstructor
public class K_FlightController {
	
	private K_FlightService service;

	// 기업회원 : 비행기 스케줄 관리 페이지 이동
	@GetMapping("scheduleManagerPage")
	public String scheduleManager(HttpServletRequest request, Model model) {
		log.info("페이지 이동 : scheduleManagerPage...");
		HttpSession session = request.getSession(false);
		B_CorpMemberVO loginvo = (B_CorpMemberVO) session.getAttribute("corp");
		if (loginvo == null) {
			model.addAttribute("loginCorpInfo", null);
		}else {
			model.addAttribute("loginCorpInfo", loginvo);
			log.info(loginvo);
		}
		return "flight/scheduleManagerPage";
	}
	
	// 일반회원 : 항공권 조회 페이지 이동
	@GetMapping("scheduleListPage")
	public String scheduleList() {
		log.info("페이지 이동 : scheduleListPage...");
		return "flight/scheduleListPage";
	}
	
	// 일반회원 : 항공권 예약 조회 페이지 이동
	@GetMapping("reservationConfirmPage")
	public String reservationConfirmPage() {
		log.info("페이지 이동 : reservationConfirmPage...");
		return "flight/reservationConfirmPage";
	}
	
	// 일반회원 : 일정 선택 후 확인 페이지 이동
	@GetMapping("scheduleConfirm")
	public String scheduleConfirm(@RequestParam("date_idx") int date_idx, 
			@RequestParam("seat_grade") String seat_grade, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		log.info("페이지 이동 : scheduleConfirm...");
		log.info("date_idx 값 : " + date_idx + " / seat_grade 값 : " + seat_grade);
		model.addAttribute("getSchedule", service.getSchedule_(date_idx));
		model.addAttribute("seat_grade", seat_grade);
		return "flight/scheduleConfirm";
	}
	
	// 일반회원 : 좌석 출력
	@PostMapping(value = "getSeatList", 
			consumes = "application/json", 
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<K_getSeatVO> getSeatList(@RequestBody K_getInfoDTO info){
		int date_idx =  info.getDate_idx();
		if(info.getSeat_grade().equals("FIRST")) {
			return new ResponseEntity<>(service.getSeatFir_(date_idx), HttpStatus.OK);
		}else if (info.getSeat_grade().equals("BUSINESS")) {
			return new ResponseEntity<>(service.getSeatBis_(date_idx), HttpStatus.OK);
		}else {
			return new ResponseEntity<>(service.getSeatEco_(date_idx), HttpStatus.OK);
		}
	}
	
	// 일반회원 : 예약 좌석 조회
	@PostMapping(value = "getReservationSeatList", 
			consumes = "application/json", 
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<K_checkSeatVO>> getReservationSeatList(@RequestBody K_getInfoDTO info){
		log.info("넘어오는 정보 확인 : " + info.getDate_idx() + "/" + info.getFlight_name());
		return new ResponseEntity<>(service.getReservationSeatList_(info), HttpStatus.OK);
	}
	
	// 예약하기
	@PostMapping("reservation")
	public String insertReservation(K_bookInfo bookInfo, Model model) {
		// 난수발생 로직 만들기 !! ========================================
		bookInfo.setReservation_idx("2022012P456789");
		// 난수발생 로직 만들기 !! ========================================
		log.info("예약정보..." + bookInfo);
		int result = service.insertReservation_(bookInfo);
		log.info("예약정보 입력 결과 : " + result);
		model.addAttribute("result", result);
		model.addAttribute("info", bookInfo);
		log.info("페이지 이동 : reservation...");
		return "flight/reservation";
	}
	
	// 일반회원 : 항공권 예약 조회
//	@PostMapping("myReservation")
//	public String myReservation(@RequestParam("ticket_idx") String ticket_idx, @RequestParam("start_date") String start_date,
//			@RequestParam("m_name") String m_name) {
//		log.info("ticket_idx 값 : " + ticket_idx);
//		log.info("start_date 값 : " + start_date);
//		log.info("m_name 값 : " + m_name);
//		return "flight/myReservation";
//	}
	
	// 카카오 페이 결제 API !
	@RequestMapping(value = "/kakaopay")
	@ResponseBody
	public String kakaopay() {
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
	
	@GetMapping("success")
	public String test() {
		log.info("페이지 이동 : 결제 성공 success...");
		return "flight/success";
	}
	
}