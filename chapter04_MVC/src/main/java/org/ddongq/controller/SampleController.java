package org.ddongq.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
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
	
	/*
	 * @PreAuthorize(표현식) 및  @Secured(배열)를 이용하여 권한 체크
	 * 컨트롤러에서 사용하는 시큐리티의 어노테이션을 활성화 하기 위해서
	 * security-context.xml 파일이 아닌 servlet-context.xml에 관련 설정을 추가해야함
	 */
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@GetMapping(value = "/annoMember")
	public void doMember2() {
		log.info("로그인 어노테이션 멤버");
	}
	
	@Secured({"ROLE_ADMIN"})
	@GetMapping(value = "/annoAdmin")
	public void doAdmin2() {
		log.info("어드민 어노테이션");
	}
	
}
