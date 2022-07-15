package org.kg.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_CorpMemberVO;
import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.K_bookInfo;
import org.kg.domain.K_getSeatVO;
import org.kg.domain.K_insertScheduleDTO;
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

	// 기업회원 : 비행기 스케줄 등록 페이지 이동 (일정 등록)
	@GetMapping("scheduleInsertPage")
	public String scheduleManager(HttpServletRequest request, Model model) {
		log.info("페이지 이동 : scheduleInsertPage...");
		HttpSession session = request.getSession(false);
		B_CorpMemberVO loginvo = (B_CorpMemberVO) session.getAttribute("corp");
		if (loginvo == null) {
			model.addAttribute("loginCorpInfo", null);
		}else {
			model.addAttribute("loginCorpInfo", loginvo);
			log.info(loginvo);
		}
		return "flight/scheduleInsertPage";
	}
	
	// 기업회원 : 비행기 스케줄 관리 페이지 이동 (일정 수정/삭제)
	@GetMapping("scheduleManagerPage")
	public String scheduleManagerPage(HttpServletRequest request, Model model) {
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
	
	// 기업회원 : 비행기 스케줄 관리 페이지에서 수정 버튼 클릭 시 
	@GetMapping("scheduleUpdatePage")
	public String scheduleUpdatePage(HttpServletRequest request, Model model, 
			@RequestParam("date_idx") String date_idx) {
		log.info("페이지 이동 : scheduleUpdatePage...");
		log.info("date_idx : " + date_idx);
		HttpSession session = request.getSession(false);
		B_CorpMemberVO loginvo = (B_CorpMemberVO) session.getAttribute("corp");
		if (loginvo == null) {
			model.addAttribute("loginCorpInfo", null);
		}else {
			model.addAttribute("loginCorpInfo", loginvo);
			log.info(loginvo);
		}
		model.addAttribute("updateInfo", service.getFlight_(date_idx));
		return "flight/scheduleUpdatePage";
	}
	
	// 기업회원 : 항공편 일정 변경 페이지에서 최종 수정 버튼 클릭 시
	@PostMapping(value = "scheduleUpdate", consumes = "application/json")
	public ResponseEntity<String> scheduleUpdate(HttpServletRequest request, Model model, 
			@RequestBody K_insertScheduleDTO input) {
		log.info("수정정보..." + input);
		HttpSession session = request.getSession(false);
		B_CorpMemberVO loginvo = (B_CorpMemberVO) session.getAttribute("corp");
		if (loginvo == null) {
			model.addAttribute("loginCorpInfo", null);
		}else {
			model.addAttribute("loginCorpInfo", loginvo);
			log.info(loginvo);
		}
		return service.updateSchdule_(input) == 1 ?
				new ResponseEntity<String>("success",HttpStatus.OK) : 
					new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
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
		log.info("페이지 이동  : scheduleConfirm...");
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
	
	// 일반회원 : 선택 좌석 출력
	@PostMapping(value = "getSeatList", consumes = "application/json", 
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<K_getSeatVO> getSeatList(@RequestBody K_getInfoDTO info){
		log.info("Date_idx : " + info.getDate_idx());
		log.info("Seat_grade : " + info.getSeat_grade());
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
	@PostMapping(value = "getReservationSeatList", consumes = "application/json", 
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<K_checkSeatVO>> getReservationSeatList(@RequestBody K_getInfoDTO info){
		log.info("예약 좌석 조회 넘어오는 정보 확인 : " + info.getDate_idx() + " / " + info.getFlight_name());
		return new ResponseEntity<>(service.getReservationSeatList_(info), HttpStatus.OK);
	}
	
	// 일반회원 : 일정 확인 후 결제버튼 클릭 시 결제 페이지 이동
	@PostMapping("/kakaoPay")
	public String kakaoPay(K_bookInfo bookInfo) {
		log.info("페이지이동 : 카카오페이 결제하기...");
		log.info("결제 및 예약 정보..." + bookInfo);
		// 통신에 성공하면 결제 정보를 가지고 있는 QR코드 생성하는 URL로 redirect!
		return "redirect:" + kakaopay.kakaoPayReady(bookInfo);
	}
	
	// 일반회원 : QR 결제 성공 후 정상적으로 결제 요청이 완료된 경우 ! => 결제 승인 요청 API 호출 (pg_token 필수!)
	@GetMapping(value = "/kakaoPaySuccess")
	public String kakaoPaySuccess(K_bookInfo bookInfo, HttpServletRequest request, Model model) {
		log.info("페이지이동 : 카카오페이 결제성공...");
		log.info("결제 및 예약 정보..." + bookInfo);
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		model.addAttribute("info", kakaopay.kakaoPayInfo(bookInfo));
		return "flight/scheduleReservationComplete";
	}
	
	// 일반회원 : 결제가 완료된 페이지에서 비동기 방식으로 항공권 예약 DB에 Insert !
    @PostMapping(value = "/insertReservation", 
    		consumes = "application/json", 
    		produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> insertReservation(@RequestBody K_bookInfo bookInfo) {
        log.info("항공권 예약 확정하기...");
        log.info("예약정보..." + bookInfo);
        int result = service.insertReservation_(bookInfo);
        return result == 1?
        		new ResponseEntity<>("success", HttpStatus.OK) :
 					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
	
	// 일반회원 : 환불버튼 클릭 시 결제취소 요청 후 응답정보를 담아 마이페이지 > 항공권 예약내역 페이지로 이동 (!페이지 이동 시 리스트 출력 문제!)
    @PostMapping(value = "/kakaoPayCancel", consumes = "application/json")
    public ResponseEntity<String> kakaoPayCancel(@RequestBody K_bookInfo bookInfo, 
    		HttpServletRequest request, Model model) {
    	log.info("항공권 예약 환불하기...");
    	log.info("환불정보..." + bookInfo);
    	HttpSession session = request.getSession(false);
    	B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
    	if (loginvo == null) {
    		model.addAttribute("loginPublicInfo", null);
    	}else {
    		model.addAttribute("loginPublicInfo", loginvo);
    		log.info(loginvo);
    	}
    	model.addAttribute("refundInfo", kakaopay.kakaoPayCancel(bookInfo));
    	return new ResponseEntity<>("success", HttpStatus.OK);
    }
	
	// 일반회원 : 항공권 예약 조회 페이지 이동
	@GetMapping("scheduleBook")
	public String reservationConfirmPage(HttpServletRequest request, Model model) {
		log.info("페이지 이동 : scheduleBook...");
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		return "flight/scheduleBook";
	}
	
	// 일반회원 : 마이페이지에서 항공권 예약내역 페이지 이동
	@GetMapping("myBookList")
	public String bookList(HttpServletRequest request, Model model) {
		log.info("페이지 이동 : myBookList...");
		HttpSession session = request.getSession(false);
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		model.addAttribute("airBookList", service.getBookingList_(loginvo.getM_idx()));
		return "flight/myBookList";
	}
	
}