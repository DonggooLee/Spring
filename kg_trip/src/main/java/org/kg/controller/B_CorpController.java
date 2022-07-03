package org.kg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_CorpMemberVO;
import org.kg.service.B_corpMemberService;
import org.kg.service.B_publicMemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/Partner/*")
public class B_CorpController {

	
	// 기업페이지
	@GetMapping("/corpPage")
	public String corpPage(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession(false);
		if (session == null) {
			return "home";
		}

		B_CorpMemberVO loginvo = (B_CorpMemberVO) session.getAttribute("corp");

		if (loginvo == null) {
			model.addAttribute("loginCorpInfo", null);
		} else {
			model.addAttribute("loginCorpInfo", loginvo);
			log.info(loginvo);
		}
		log.info("기업 페이지로 갑니다");
		return "corp/corpAccountPage";
	}
}
