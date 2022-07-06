package org.kg.controller;

import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_CorpMemberVO;
import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.K_bookInfo;
import org.kg.domain.K_getSeatVO;
import org.kg.domain.KakaoPayDTO;
import org.kg.domain.K_checkSeatVO;
import org.kg.domain.K_getInfoDTO;
import org.kg.service.K_FlightService;
import org.kg.service.KakaopayPay;
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
	
	private KakaopayPay kakaopay;
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
	
	// 항공권 예약내역 
	@GetMapping("bookList")
	public String bookList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			log.info(loginvo);
			model.addAttribute("loginPublicInfo", loginvo);
			model.addAttribute("airBookList", service.getBookingList_(loginvo.getM_idx()));
		}
		log.info("페이지 이동 : 항공권 예약 내역 페이지 이동...");
		return "flight/bookList";
	}
    
	// 해당 메소드 탈 경우 카카오페이 결제정보 요청 값
    @PostMapping(value = "/kakaoPay")
    public String kakaoPay(K_bookInfo bookInfo) {
        log.info("카카오페이 결제하기 ...");
        log.info("예약정보..." + bookInfo);
    	// 통신에 성공하면 결제 정보를 가지고 있는 QR 코드 생성하는 URL로 redirect 한다
    	return "redirect:" + kakaopay.kakaoPayReady(bookInfo);
    }
    
    // 결제승인 요청 성공시
    @GetMapping(value = "/kakaoPaySuccess")
    public String kakaoPaySuccess(
    		@RequestParam("pg_token") String pg_token, @RequestParam("ticket_price") String ticket_price, 
    		@RequestParam("seat_name") String seat_name, @RequestParam("flight_name") String flight_name, 
    		@RequestParam("date_idx") String date_idx, @RequestParam("m_idx") String m_idx, Model model) {
        log.info("kakaoPaySuccess get............................................");
        log.info("kakaoPaySuccess pg_token : " + pg_token);
        log.info("kakaoPaySuccess ticket_price : " + ticket_price);
        log.info("kakaoPaySuccess seat_name : " + seat_name);
        log.info("kakaoPaySuccess flight_name : " + flight_name);
        log.info("kakaoPaySuccess date_idx : " + date_idx);
        log.info("kakaoPaySuccess m_idx : " + m_idx);
        // 결제 승인 요청 정보를 담기 위한 임시 객체 생성 및 변수 초기화
        KakaoPayDTO dto = new KakaoPayDTO();
        dto.setPg_token(pg_token);
        dto.setTicket_price(ticket_price);
        dto.setSeat_name(seat_name);
        dto.setFlight_name(flight_name);
        dto.setDate_idx(date_idx);
        dto.setM_idx(m_idx);
        Random ran = new Random();
		String ridx = "";
		for(int i=0; i<5; i++) {
			String num = String.valueOf(ran.nextInt(10));
			String str = String.valueOf((char)((int)(ran.nextInt(26))+65));
			ridx += (str+num);
		}
		dto.setReservation_idx("2022"+ridx);
		// if 예약이 완료 되냐 안되냐에 따라서 값을 다르게 처리하기
        int result = service.insertReservation_(dto);
        if(result==1) {
        	model.addAttribute("reservation_idx", dto.getReservation_idx());
        	model.addAttribute("info", kakaopay.kakaopayInfo(dto));
        }else {
        	model.addAttribute("reservation_idx", "예약실패!");
        	model.addAttribute("info", kakaopay.kakaopayInfo(dto));
        }
        return "flight/kakaoPaySuccess";
    }
	
}