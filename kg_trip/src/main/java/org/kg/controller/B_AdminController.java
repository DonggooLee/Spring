package org.kg.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_CorpMemberVO;
import org.kg.domain.B_PublicMemberVO;
import org.kg.service.B_corpMemberService;
import org.kg.service.B_publicMemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/Admin/*")
public class B_AdminController {
	
	private B_publicMemberService pm_service;
	private B_corpMemberService cm_service;

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
	public String sdf(HttpServletRequest request, Model model) {
	
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
		
		model.addAttribute("publicList", pm_service.publicList()); // 전체 리스트 목록
		
		return "admin/publicmemberlist";
	}
	
	@GetMapping("/manageCorp")
	public String gpep(HttpServletRequest request, Model model) {
		
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
		
		model.addAttribute("corpList", cm_service.corpList()); // 전체 리스트 목록
		
		return "admin/corpmemberlist";
	}
	
	// 계정관리
	@GetMapping("/adminaccount")
	public String trew(HttpServletRequest request, Model model) {

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
		log.info("마이페이지로 갑니다");
		return "admin/adminAccountPage";
	}
	
	@ResponseBody
	@PostMapping(value = "/pmemberDelete")
	public Object rjdaf(HttpSession session, HttpServletRequest req) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String[] arr = req.getParameterValues("m_idx");
		
		try {
			if(arr != null && arr.length > 0) {
				for(int i=0; i<arr.length; i++) {
					System.out.println(i + ":" + arr[i]);
					System.out.println(arr[i]);
					pm_service.publicDelete(arr[i]);
				}
				resultMap.put("result", "success");
			}else {
				resultMap.put("result", "false");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@ResponseBody
	@PostMapping(value = "/pmemberUpdate")
	public Object sldfk(HttpSession session, HttpServletRequest req) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String[] arr = req.getParameterValues("m_idx");
		
		try {
			if(arr != null && arr.length > 0) {
				for(int i=0; i<arr.length; i++) {
					System.out.println(i + ":" + arr[i]);
					System.out.println(arr[i]);
					pm_service.publicUpdate(arr[i]);
				}
				resultMap.put("result", "success");
			}else {
				resultMap.put("result", "false");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@ResponseBody
	@PostMapping(value = "/corpDelete")
	public Object awed(HttpSession session, HttpServletRequest req) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String[] arr = req.getParameterValues("c_idx");
		
		try {
			if(arr != null && arr.length > 0) {
				for(int i=0; i<arr.length; i++) {
					System.out.println(i + ":" + arr[i]);
					System.out.println(arr[i]);
					cm_service.corpDelete(arr[i]);
				}
				resultMap.put("result", "success");
			}else {
				resultMap.put("result", "false");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@GetMapping("/cal")
	public String asdf() {
			
		return "join/cal";
	}
}
