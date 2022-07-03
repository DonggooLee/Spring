package org.kg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_PublicMemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/Admin/*")
public class B_AdminController {

	// 마이페이지
	@GetMapping("/adminPage")
	public String sdfsdf(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession(false);
		if (session == null) {
			return "home";
		}

		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");

		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		} else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		log.info("관리자 페이지로 제발 가주세요");
		return "admin/adminPage";
	}
	
	@GetMapping("/managePublic")
	public String sdf() {
	
		log.info("갔나?");
		
		return "admin/publicmemberlist";
	}
}
