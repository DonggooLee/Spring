package org.ddongq.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/sample/*")
public class SampleController {
	// /sample/all => 로그인을 하지 않은 사용자도 접근가능한 URI
	// /sample/member => 로그인 한 사용자들만이 접근할 수 있는 URI
	// /sample/admin => 로그인 한 사용자들 중에서 관리자 권한을 가진 사용자만 접근할 수 있는 URI

	@GetMapping(value = "/all")
	public String doAll() {
		log.info("do all can access everybody");
		return "/sample/all";
	}
	
	@GetMapping(value = "/member")
	public void doMember() {
		log.info("logined member.....");
	}
	
	@GetMapping(value = "/admin")
	public void doAdmin() {
		log.info("admin only.....");
	}
	
}
