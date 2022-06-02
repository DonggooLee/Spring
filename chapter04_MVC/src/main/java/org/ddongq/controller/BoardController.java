package org.ddongq.controller;

import org.ddongq.domain.BoardVO;
import org.ddongq.domain.Criteria;
import org.ddongq.domain.PageDTO;
import org.ddongq.service.BoardService;
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
	// 리턴 타입 String 으로 만들어야 한다. 뷰를 리턴하기 때문에..
	// 리턴 타입 void 로 만든경우에는 메소드 명과 동일한 곳으로 .jsp 파일로 이동한다. 
	// (Spring 에서 지원하는 기능)
	public String list(Model model, Criteria cri) {
		log.info("list..." + cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total.............." + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		return "board/list";
	}
	
	@GetMapping("/register")
	public String register() {
		return "board/register";
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register..." + board);
		// Redirect 는 경로가 보이지만 데이터를 못가지고 넘어가는 문제점을 보완한 방법
		// 데이터를 가지고 넘어간다.(forwarding 은 경로 문제로...)
		rttr.addFlashAttribute("result","ok");
		service.register(board);
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")	
	public String get(@RequestParam("bno") long bno, Model model, Criteria cri) {
		log.info("/get");
		model.addAttribute("board", service.get(bno));
		model.addAttribute("cri", cri);
		return "board/get";
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam("bno") long bno, Model model, Criteria cri) {
		log.info("/modify");
		model.addAttribute("board", service.get(bno));
		model.addAttribute("cri", cri);
		return "board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		log.info("modify..." + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") long bno, RedirectAttributes rttr) {
		log.info("remove..." + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
	
}
