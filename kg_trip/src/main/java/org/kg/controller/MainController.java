package org.kg.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_AdminVO;
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
public class MainController {

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
		B_AdminVO loginAdminvo = (B_AdminVO)session.getAttribute("admin");

		if (loginPublicvo != null) {
			model.addAttribute("loginPublicInfo", loginPublicvo);
			log.info(loginPublicvo);
		}else if(loginPublicvo == null) {
			if(loginCorpvo != null) {
				model.addAttribute("loginCorpInfo", loginCorpvo);
				log.info(loginCorpvo);
			}else if(loginCorpvo == null) {
				if(loginAdminvo != null) {
					model.addAttribute("loginAdminInfo", loginAdminvo);
					log.info(loginAdminvo);
				}else {
					model.addAttribute("loginPublicInfo", null);
					model.addAttribute("loginCorpInfo", null);
					model.addAttribute("loginAdminInfo",null);
				}
			}
		}

		return "home";
	}

	// 회원가입 개인/기업 선택
	@GetMapping("/join")
	public String test() {

		return "joinPage";
	}

	// 개인회원 가입페이지로 단순이동
	@GetMapping("/join/joinFormP")
	public String goJoinPageP() {

		return "joinFormP";
	}

	// 개인회원 가입 후 로그인 페이지로 이동
	@PostMapping("/join/joinFormP")
	public String joinPageP(B_PublicMemberVO publicinfo, RedirectAttributes rttr) {
		log.info("※※※※※※※※※※※※join 성공※※※※※※※※※※※※");
		pm_service.joinPublic(publicinfo);
		rttr.addFlashAttribute("result", "okay");
		return "redirect:/userP/login";
	}

	// 기업회원 가입페이지로 단순이동
	@GetMapping("/join/joinFormC")
	public String joinFormC() {

		return "joinFormC";
	}

	// 기업회원 가입 후 로그인 페이지로 이동
	@PostMapping("/join/joinFormC")
	public String joinPageC(B_CorpMemberVO corpinfo, RedirectAttributes rttr) {
		log.info("※※※※※※※※※※※※join 성공※※※※※※※※※※※※");
		cm_service.joinCorp(corpinfo);
		rttr.addFlashAttribute("result", "okay");
		return "redirect:/userP/login";
	}

	// 개인 회원가입시 아이디 중복체크
	@GetMapping(value = "/public/idCheckP", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public int publicidCheck(@RequestParam("m_id") String m_id) {
		log.info("개인회원 아이디 중복체크 : " + m_id);
		return pm_service.publicIdCheck(m_id);
	}
	
	// 개인 회원가입시 이메일 중복체크
	@GetMapping(value = "/public/emailCheckP", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public int publicEmailCheck(@RequestParam("m_email") String m_email) {
		log.info("개인회원 이메일 중복체크 : " + m_email);
		return pm_service.publicEmailCheck(m_email);
	}
	// 개인 회원가입시 핸드폰 중복체크
	@GetMapping(value = "/public/phoneCheckP", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public int publicPhoneCheck(@RequestParam("m_phone") String m_phone) {
		log.info("개인회원 핸드폰 중복체크 : " + m_phone);
		return pm_service.publicPhoneCheck(m_phone);
	}

	// 기업 회원가입시 아이디 중복체크
	@GetMapping(value = "/corp/idCheckC", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public int corpidCheck(@RequestParam("c_id") String c_id) {
		log.info("중복쳌쳌쳌쳌쳌쳌쳌쳌쳌" + c_id);
		return cm_service.corpIdCheck(c_id);
	}

	// 기업회원 로그인 후 메인페이지로
	@PostMapping("/loginFormC")
	public String loginFormC() {

		return "loginFormC";
	}
	
	//마이페이지
	@GetMapping("/myPage")
	public String trew(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession(false);
		if (session == null) {
			return "home";
		}

		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");

		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		}else {
			model.addAttribute("loginPublicInfo", loginvo);
			log.info(loginvo);
		}
		
		return "publicMyPage";
	}

}
