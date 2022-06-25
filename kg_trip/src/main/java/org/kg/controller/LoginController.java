package org.kg.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_AdminVO;
import org.kg.domain.B_CorpMemberVO;
import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.LoginForm;
import org.kg.service.B_adminService;
import org.kg.service.B_corpMemberService;
import org.kg.service.B_publicMemberService;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class LoginController {

	private B_publicMemberService pm_serivce;
	private B_corpMemberService cm_service;
	private B_adminService a_service;
	
	// 로그인 페이지로 단순이동
	@GetMapping("/userP/login")
	public String loginForm(@ModelAttribute LoginForm loginform) {
		log.info("로그인페이지로 슝슝");
		return "loginPage";
	}
	
	// 로그인 할거임
	@PostMapping("/userP/login")
	public String loginPublic(@ModelAttribute LoginForm loginform,BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();                    // 세션이 있으면 있는 세션 반환, 없으면 신규 세션을 생성하여 반환
		// 오류나면 로그인페이지로 다시 감.
		if (bindingResult.hasErrors()) {
			session.setAttribute("public", null);
            return "loginPage";
        }
		
		B_PublicMemberVO loginvo = pm_serivce.loginPublic(loginform.getM_id(), loginform.getM_pw());
		
		if (loginvo == null) {
			session.setAttribute("public", null);
            bindingResult.reject("loginFail", "아이디 또는 비밀번호가 맞지 않습니다.");
            return "loginPage";
        }
	    session.setAttribute("public", loginvo);   // 세션에 로그인 회원 정보 보관

	    log.info(session.getAttribute("public"));
		
		return "redirect:/KingTrip/main";
////		// 쿠키에 저장할거임
//		Cookie idCookie = new Cookie("m_id", String.valueOf(loginvo.getM_id()));
//		response.addCookie(idCookie);
		
//		// 로그인 성공 처리
	}
	@PostMapping("/userC/login")
	public String loginCorp(@ModelAttribute LoginForm loginform,BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();                    // 세션이 있으면 있는 세션 반환, 없으면 신규 세션을 생성하여 반환
		// 오류나면 로그인페이지로 다시 감.
		if (bindingResult.hasErrors()) {
			session.setAttribute("corp", null);
            return "loginPage";
        }
		
		B_CorpMemberVO loginvo = cm_service.loginCorp(loginform.getC_id(), loginform.getC_pw());
		
		if (loginvo == null) {
			session.setAttribute("corp", null);
            bindingResult.reject("loginFail", "아이디 또는 비밀번호가 맞지 않습니다.");
            return "loginPage";
        }
	    session.setAttribute("corp", loginvo);   // 세션에 로그인 회원 정보 보관

	    log.info(session.getAttribute("corp"));
		
		return "redirect:/KingTrip/main";
////		// 쿠키에 저장할거임
//		Cookie idCookie = new Cookie("m_id", String.valueOf(loginvo.getM_id()));
//		response.addCookie(idCookie);
		
//		// 로그인 성공 처리
	}
	
	@GetMapping("/admin/login")
	public String adminloginForm(@ModelAttribute LoginForm loginform) {
		log.info("로그인페이지로 슝슝");
		return "admin/adminLoginPage";
	}
	@PostMapping("/admin/login")
	public String loginadmin(@ModelAttribute LoginForm loginform,BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();                    // 세션이 있으면 있는 세션 반환, 없으면 신규 세션을 생성하여 반환
		// 오류나면 로그인페이지로 다시 감.
		if (bindingResult.hasErrors()) {
			session.setAttribute("admin", null);
            return "admin/adminLoginPage";
        }
		
		B_AdminVO adminlogin = a_service.loginAdmin(loginform.getA_id(), loginform.getA_pw());
		
		if (adminlogin == null) {
			session.setAttribute("admin", null);
            bindingResult.reject("loginFail", "아이디 또는 비밀번호가 맞지 않습니다.");
            return "admin/adminLoginPage";
        }
	    session.setAttribute("admin", adminlogin);   // 세션에 로그인 회원 정보 보관

	    log.info(session.getAttribute("admin"));
		
		return "redirect:/KingTrip/main";
////		// 쿠키에 저장할거임
//		Cookie idCookie = new Cookie("m_id", String.valueOf(loginvo.getM_id()));
//		response.addCookie(idCookie);
		
//		// 로그인 성공 처리
	}

	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession(false); 
		if(session != null) {
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
	
	
	
}
