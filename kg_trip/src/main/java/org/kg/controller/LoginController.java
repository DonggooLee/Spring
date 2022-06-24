package org.kg.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.LoginForm;
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
	
	// 로그인 페이지로 단순이동
	@GetMapping("/login")
	public String loginForm(@ModelAttribute LoginForm loginform) {
		log.info("로그인페이지로 슝슝");
		return "loginPage";
	}
	
	// 로그인 할거임
	@PostMapping("/login")
	public String login(@ModelAttribute LoginForm loginform,BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();                         // 세션이 있으면 있는 세션 반환, 없으면 신규 세션을 생성하여 반환
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
