package org.kg.controller;

import org.kg.service.FlightService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/flight/*")
@AllArgsConstructor
public class K_FlightController {
	
	private FlightService service;

	// 기업회원 : 비행기 스케줄 관리 페이지 이동
	@GetMapping("scheduleManagerPage")
	public String scheduleManager() {
		log.info("페이지 이동 : scheduleManagerPage...");
		return "flight/scheduleManagerPage";
	}
	
	// 일반회원 : 항공권 조회 페이지 이동
	@GetMapping("scheduleListPage")
	public String scheduleList() {
		log.info("페이지 이동 : scheduleListPage...");
		return "flight/scheduleListPage";
	}
	
	// 일반회원 : 항공권 선택 후 확인 페이지 이동
	@GetMapping("scheduleConfirm")
	public String scheduleConfirm(@RequestParam("date_idx") int date_idx, @RequestParam("seat_grade") String seat_grade, Model model) {
		log.info("페이지 이동 : scheduleConfirm...");
		log.info("date_idx 값 : " + date_idx);
		log.info("seat_grade 값 : " + seat_grade);
		model.addAttribute("getSchedule", service.getSchedule_(date_idx, seat_grade));
		return "flight/scheduleConfirm";
	}
	
	// 일반회원 : 확인 페이지에서 좌석배정 버튼 클릭 시 페이지 이동
	@PostMapping("choiceSeat")
	public String choiceSeat(@RequestParam("date_idx") int date_idx, @RequestParam("seat_grade") String seat_grade,
			@RequestParam("flight_name") String flight_name, Model model) {
		log.info("페이지 이동 : choiceSeat...");
		log.info("date_idx 값 : " + date_idx);
		log.info("seat_grade 값 : " + seat_grade);
		log.info("flight_name 값 : " + flight_name);
		model.addAttribute("date_idx", date_idx);
		model.addAttribute("seat_grade", seat_grade);
		model.addAttribute("flight_name", flight_name);
		model.addAttribute("getSchedule", service.choiceSeat_(date_idx, flight_name));
		return "flight/choiceSeat";
	}
	
	// 일반회원 : 일정/좌석/개인정보 최종확인
	@PostMapping("reservationConfirm")
	public String reservationConfirm(@RequestParam("date_idx") int date_idx, @RequestParam("seat_grade") String seat_grade,
			@RequestParam("flight_name") String flight_name, @RequestParam("seat_idx") int seat_idx, Model model) {
		log.info("페이지 이동 : reservationConfirm...");
		log.info("date_idx 값 : " + date_idx);
		log.info("seat_idx 값 : " + seat_idx);
		log.info("seat_grade 값 : " + seat_grade);
		log.info("flight_name 값 : " + flight_name);
		model.addAttribute("getSeat", service.getSeat_(seat_idx));
		model.addAttribute("getSchedule", service.getSchedule_(date_idx, seat_grade));
		return "flight/reservationConfirm";
	}
	
}