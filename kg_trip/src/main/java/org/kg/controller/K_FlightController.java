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

	// 관리자 비행기 스케줄 추가 페이지 이동
	@GetMapping("scheduleManagerPage")
	public String scheduleManager() {
		log.info("페이지 이동 : scheduleManagerPage...");
		return "flight/scheduleManagerPage";
	}
	
}