package org.kg.controller;

import java.util.List;
import java.util.Random;

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
	public String scheduleList(HttpServletRequest request, Model model) {
		log.info("페이지 이동 : scheduleListPage...");
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		return "flight/scheduleListPage";
	}
	
	// 일반회원 : 항공권 예약 조회 페이지 이동
	@GetMapping("scheduleBookPage")
	public String reservationConfirmPage(HttpServletRequest request, Model model) {
		log.info("페이지 이동 : scheduleBookPage...");
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		return "flight/scheduleBookPage";
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
		log.info("넘어오는 정보 확인 : " + info.getDate_idx() + " / " + info.getFlight_name());
		return new ResponseEntity<>(service.getReservationSeatList_(info), HttpStatus.OK);
	}
	
	// 일반회원 : 예약하기
	@PostMapping("myReservation")
	public String insertReservation(K_bookInfo bookInfo, Model model) {
		Random ran = new Random();
		String ridx = "";
		for(int i=0; i<5; i++) {
			String num = String.valueOf(ran.nextInt(10));
			String str = String.valueOf((char)((int)(ran.nextInt(26))+65));
			ridx += (str+num);
		}
		bookInfo.setReservation_idx("2022"+ridx);
		log.info("예약정보..." + bookInfo);
		int result = service.insertReservation_(bookInfo);
		if(result==1) {
			log.info("예약정보 입력 결과(성공) : " + result);
			model.addAttribute("bookNum", bookInfo.getReservation_idx());
			log.info(bookInfo.getReservation_idx());
			model.addAttribute("bookInfo", service.getResrvationInfo_(bookInfo.getReservation_idx()));
		}else {
			log.info("예약정보 입력 결과(실패) : " + result);
			// 실패 했을 때 다시 예약하는 페이지로 보내기?
		}
		return "flight/myReservation";
	}
	
}