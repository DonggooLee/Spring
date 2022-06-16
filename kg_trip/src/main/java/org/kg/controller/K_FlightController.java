package org.kg.controller;

import org.kg.service.FlightService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/flight/*")
public class K_FlightController {
	
	private FlightService service;
	
	// 비행기 스케줄 관리 페이지 이동
	@GetMapping("/ScheduleControlPage")
	public String scheduleManager() {
		return "flight/K_flightScheduleControlPage";
	}
	
	// 항공권 예매 페이지로 이동
	@GetMapping("/bookPage")
	public String bookPage() {
		return "flight/K_flightBookPage";
	}
	
	// 항공권 조회 페이지 이동
	@GetMapping("/bookCheck")
	public String bookCheck() {
		return "flight/K_flightBookCheckPage";
	}
	
	// 예매 항공권 조회
	@GetMapping("/test")
	public String test(Model model) {
		log.info("/test............");
		model.addAttribute("list", service.reservationList_());
		return "flight/test";
	}
	
}
