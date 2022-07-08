package org.kg.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kg.domain.AddressForm;
import org.kg.domain.B_CorpMemberVO;
import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.LoginForm;
import org.kg.service.B_corpMemberService;
import org.kg.service.B_publicMemberService;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/Member/*")
public class B_JoinLoginController {

	private B_publicMemberService pm_service;
	private B_corpMemberService cm_service;

	// 로그인 페이지로 단순이동
	@GetMapping("/login")
	public String loginForm(@ModelAttribute LoginForm loginform) {
		log.info("로그인페이지로 슝슝");
		return "login/loginPage";
	}

	// 로그인 할거임
	@PostMapping("/loginFormP")
	public String loginPublic(@ModelAttribute LoginForm loginform, BindingResult bindingResult,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(); // 세션이 있으면 있는 세션 반환, 없으면 신규 세션을 생성하여 반환

		B_PublicMemberVO loginvo = pm_service.loginPublic(loginform.getM_id(), loginform.getM_pw());

		// 오류나면 로그인페이지로 다시 감.
		if (loginvo == null) {
			session.setAttribute("public", null);
			bindingResult.reject("loginFail", "아이디 또는 비밀번호가 맞지 않습니다.");
			return "login/loginPage";
		}
		session.setAttribute("public", loginvo); // 세션에 로그인 회원 정보 보관

		log.info(session.getAttribute("public"));

		return "redirect:/KingTrip/main";
////		// 쿠키에 저장할거임
//		Cookie idCookie = new Cookie("m_id", String.valueOf(loginvo.getM_id()));
//		response.addCookie(idCookie);

//		// 로그인 성공 처리
	}

	@PostMapping("/loginFormC")
	public String loginCorp(@ModelAttribute LoginForm loginform, BindingResult bindingResult,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(); // 세션이 있으면 있는 세션 반환, 없으면 신규 세션을 생성하여 반환

		B_CorpMemberVO loginvo = cm_service.loginCorp(loginform.getC_id(), loginform.getC_pw());

		// 오류나면 로그인페이지로 다시 감.
		if (loginvo == null) {
			session.setAttribute("corp", null);
			bindingResult.reject("loginFail", "아이디 또는 비밀번호가 맞지 않습니다.");
			return "login/loginPage";
		}
		session.setAttribute("corp", loginvo); // 세션에 로그인 회원 정보 보관

		log.info(session.getAttribute("corp"));

		return "redirect:/KingTrip/main";
////		// 쿠키에 저장할거임
//		Cookie idCookie = new Cookie("m_id", String.valueOf(loginvo.getM_id()));
//		response.addCookie(idCookie);

//		// 로그인 성공 처리
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
//		expireCookie(response, "m_id");
		return "redirect:/KingTrip/main";
	}

	// 로그아웃에 필요한 메소드
//	private void expireCookie(HttpServletResponse response, String cookieName) {
//		Cookie cookie = new Cookie(cookieName, null);
//		cookie.setMaxAge(0);
//		response.addCookie(cookie);
//	}
	// 회원가입 개인/기업 선택
	@GetMapping("/join")
	public String test() {

		return "join/joinPage";
	}

	// 개인회원 가입페이지로 단순이동
	@GetMapping("/join/joinFormP")
	public String goJoinPageP() {

		return "join/joinFormP";
	}

	// 개인회원 가입 후 로그인 페이지로 이동
	@PostMapping("/join/joinFormP")
	public String joinPageP(B_PublicMemberVO publicinfo, RedirectAttributes rttr) {
		log.info("※※※※※※※※※※※※join 성공※※※※※※※※※※※※");
		pm_service.joinPublic(publicinfo);
		rttr.addFlashAttribute("result", "okay");
		return "redirect:/Member/login";
	}

	// 기업회원 가입페이지로 단순이동
	@GetMapping("/join/joinFormC")
	public String joinFormC() {

		return "join/joinFormC";
	}

	// 기업회원 가입 후 로그인 페이지로 이동
	@PostMapping("/join/joinFormC")
	public String joinPageC(B_CorpMemberVO corpinfo, RedirectAttributes rttr, AddressForm addressform) {
		log.info("※※※※※※※※※※※※join 성공※※※※※※※※※※※※");
		
		String address = addressform.getAddress();
		String detailaddress = addressform.getDetailaddress();
		
		corpinfo.setC_address(address + detailaddress);
		
		if (corpinfo.getC_type() == 100) {
			log.info(corpinfo.getC_type());
			corpinfo.setC_type(corpinfo.getC_type());
		}else {
			corpinfo.setC_aircode("");
		}
		cm_service.joinCorp(corpinfo);
		rttr.addFlashAttribute("result", "okay");
		return "redirect:/Member/login";
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
		log.info("기업회원 아이디 중복체크 : " + c_id);
		return cm_service.corpIdCheck(c_id);
	}

	// 기업 회원가입시 이메일 중복체크
	@GetMapping(value = "/corp/demailCheckC", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public int corpemailCheck(@RequestParam("c_demail") String c_demail) {
		log.info("기업회원 이메일 중복체크 : " + c_demail);
		return cm_service.corpEmailCheck(c_demail);
	}

	// 기업 회원가입시 번호 중복체크
	@GetMapping(value = "/corp/dphoneCheckC", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public int corpphoneCheck(@RequestParam("c_dphone") String c_dphone) {
		log.info("기업회원 휴대폰 중복체크 : " + c_dphone);
		return cm_service.corpPhoneCheck(c_dphone);
	}

}
