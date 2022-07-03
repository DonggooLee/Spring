package org.kg.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_CorpMemberVO;
import org.kg.domain.B_PublicMemberVO;
import org.kg.service.B_corpMemberService;
import org.kg.service.B_publicMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/KingTrip/*")
@AllArgsConstructor
public class B_MainController {

	private B_publicMemberService pm_service;
	private B_corpMemberService cm_service;

	// 실행하자마자 메인페이지 이동, 로그인한다음 이동처리
	@GetMapping("/main")
	// @CookieValue(name="m_id", required = false) String cookieid
	// HttpServletRequest request
	public String home(HttpServletRequest request, Model model) {
		// 로그인 쿠키가 없으면 홈으로 이동
//        if (cookieid == null) {
//            return "mainPage";
//        }
//        model.addAttribute("loginPublic", cookieid);
		HttpSession session = request.getSession(false);
		if (session == null) {
			return "home";
		}

		B_PublicMemberVO loginPublicvo = (B_PublicMemberVO) session.getAttribute("public");
		B_CorpMemberVO loginCorpvo = (B_CorpMemberVO) session.getAttribute("corp");

		if (loginPublicvo != null) {
			model.addAttribute("loginPublicInfo", loginPublicvo);
			log.info(loginPublicvo);
		} else if (loginPublicvo == null) {
			if (loginCorpvo != null) {
				model.addAttribute("loginCorpInfo", loginCorpvo);
				log.info(loginCorpvo);
			} else {
				model.addAttribute("loginPublicInfo", null);
				model.addAttribute("loginCorpInfo", null);
			}
		}

		return "home";
	}






}
