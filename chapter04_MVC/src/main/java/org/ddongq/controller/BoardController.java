package org.ddongq.controller;

import org.ddongq.domain.BoardVO;
import org.ddongq.domain.Criteria;
import org.ddongq.domain.PageDTO;
import org.ddongq.service.BoardService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/board/*")
public class BoardController {

	// @AllArgsConstructo를 통해 받아왔기 때문에  @Setter를 사용하지 않아도 된다! (선택사항)
	private BoardService service;
	
	@GetMapping("/list")
	// 리턴 타입 String 으로 만들어야 한다. 뷰를 리턴하기 때문에...
	// 리턴 타입 void 로 만든경우에는 URL과 동일한 .jsp 로 이동한다.(Spring 에서 지원하는 기능)
	public String list(Model model, Criteria cri) {
		log.info("/list");
		log.info("cri.............." + cri);
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotal(cri);
		log.info("total.............." + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		return "board/list";
	}
	
	@PreAuthorize("isAuthenticated()")	// 인증된 사용자라면 true => 권한은 상관없이 로그인이 되어있냐 안되어 있냐만 판단
	@GetMapping("/register")
	public String register() {
		log.info("/register");
		return "board/register";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register.............." + board);
		// Redirect 는 경로가 보이지만 데이터를 못가지고 넘어가는 문제점을 보완한 방법
		// rttr 데이터를 가지고 넘어간다.(forwarding 은 경로 문제로...)
		service.register(board);
		rttr.addFlashAttribute("result", "ok");
		// redirect: 순수 화면이동  => getMapping(/board/list) 
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public String get(@RequestParam("bno") long bno, Model model, Criteria cri) {
		log.info("/get");
		log.info("bno.............." + bno);
		log.info("cri.............." + cri);
		model.addAttribute("board", service.get(bno));
		model.addAttribute("cri", cri);
		return "board/get";
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam("bno") long bno, Model model, Criteria cri) {
		log.info("/modify");
		log.info("bno.............." + bno);
		log.info("cri.............." + cri);
		model.addAttribute("board", service.get(bno));
		model.addAttribute("cri", cri);
		return "board/modify";
	}
	
	// 메소드 실행 전 , 로그인한 사용자와 파라미터로 전달되는 작성자가 일치하는지 체크
	// # = 매개변수로 넘어온걸 표현식으로 사용할 때 필수로 붙여주기!!!
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		log.info("modify.............." + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") long bno, RedirectAttributes rttr) {
		log.info("remove.............." + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
}
