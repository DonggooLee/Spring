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
import org.kg.service.k_KakaopayPay;
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
	private k_KakaopayPay kakaopay;

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
	@GetMapping("scheduleList")
	public String scheduleList(HttpServletRequest request, Model model) {
		log.info("페이지 이동 : scheduleList...");
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		return "flight/scheduleList";
	}
	
	// 일반회원 : 일정선택 후 상세 정보 입력 페이지 이동
	@GetMapping("scheduleConfirm")
	public String scheduleConfirm(HttpServletRequest request, Model model,
			@RequestParam("date_idx") int date_idx, 
			@RequestParam("seat_grade") String seat_grade) {
		log.info("페이지 이동 : scheduleConfirm...");
		log.info("scheduleConfirm 넘어온 정보 : " + date_idx + " / " + seat_grade);
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		model.addAttribute("getSchedule", service.getSchedule_(date_idx));
		model.addAttribute("seat_grade", seat_grade);
		return "flight/scheduleConfirm";
	}
	
	// 일반회원 : 일정 확인 후 결제버튼 클릭 시 결제 페이지 이동
	@PostMapping("/kakaoPay")
	public String kakaoPay(K_bookInfo bookInfo) {
		log.info("페이지이동 : 카카오페이 결제하기...");
		log.info("결제 및 예약 정보..." + bookInfo);
		// 통신에 성공하면 결제 정보를 가지고 있는 QR코드 생성하는 URL로 redirect!
		return "redirect:" + kakaopay.kakaoPayReady(bookInfo);
	}
	
	// 일반회원 : QR 결제 성공 시 
	@GetMapping(value = "/kakaoPaySuccess")
	public String kakaoPaySuccess(HttpServletRequest request, Model model,
			@RequestParam("pg_token") String pg_token, @RequestParam("m_idx") String m_idx, 
			@RequestParam("seat_name") String seat_name, @RequestParam("flight_name") String flight_name, 
			@RequestParam("date_idx") String date_idx, @RequestParam("ticket_price") String ticket_price) {
		log.info("페이지이동 : 카카오페이 결제성공...");
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		log.info("kakaoPaySuccess get............................................");
		log.info("kakaoPaySuccess pg_token : " + pg_token);
		log.info("kakaoPaySuccess ticket_price : " + ticket_price);
		log.info("kakaoPaySuccess seat_name : " + seat_name);
		log.info("kakaoPaySuccess flight_name : " + flight_name);
		log.info("kakaoPaySuccess date_idx : " + date_idx);
		log.info("kakaoPaySuccess m_idx : " + m_idx);
		// 결제 승인 요청 정보를 담기 위한 임시 객체 생성 및 변수 초기화
		Random ran = new Random();
		String ridx = "";
		for(int i=0; i<5; i++) {
			String num = String.valueOf(ran.nextInt(10));
			String str = String.valueOf((char)((int)(ran.nextInt(26))+65));
			ridx += (str+num);
		}
		KakaoPayDTO dto = new KakaoPayDTO();
		dto.setReservation_idx("2022"+ridx);
		dto.setTicket_price(ticket_price);
		dto.setFlight_name(flight_name);
		dto.setSeat_name(seat_name);
		dto.setDate_idx(date_idx);
		dto.setPg_token(pg_token);
		dto.setM_idx(m_idx);
		model.addAttribute("info", kakaopay.kakaoPayInfo(dto));
		return "flight/kakaoPaySuccess";
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
    
    
    
    // 항공권 예약 확정
    @PostMapping(value = "/insertReservation", 
    		consumes = "application/json", 
    		produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> insertReservation(@RequestBody KakaoPayDTO bookInfo) {
        log.info("항공권 예약 확정하기...");
        log.info("예약정보..." + bookInfo);
        int result = service.insertReservation_(bookInfo);
        return result == 1?
        		new ResponseEntity<>("success", HttpStatus.OK) :
 					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    @PostMapping(value = "/kakaoPayCancel")
    public String kakaoPayCancel(K_bookInfo bookInfo, HttpServletRequest request, Model model) {
    	HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
        log.info("결제취소(환불)...");
        log.info("환불정보..." + bookInfo);
        model.addAttribute("refundInfo", kakaopay.kakaoPayCancel(bookInfo));
        return "flight/bookList"; 
    }
    
}