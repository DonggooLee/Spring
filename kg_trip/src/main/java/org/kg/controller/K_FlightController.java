package org.kg.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/flight/*")
@AllArgsConstructor
public class K_FlightController {

	// 기업회원 비행기 스케줄 관리 페이지 이동
	@GetMapping("scheduleManagerPage")
	public String scheduleManager() {
		log.info("페이지 이동 : scheduleManagerPage...");
		return "flight/scheduleManagerPage";
	}
	
	// 항공권 조회 페이지 이동
	@GetMapping("scheduleListPage")
	public String scheduleList() {
		log.info("페이지 이동 : scheduleListPage...");
		return "flight/scheduleListPage";
	}
	
}