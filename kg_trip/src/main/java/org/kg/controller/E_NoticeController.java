package org.kg.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.E_Criteria;
import org.kg.domain.E_NoticeVO;
import org.kg.domain.E_PageDTO;
import org.kg.service.E_NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor         // 보드컨트롤러는 보드서비스에 대해 의존적 > 어노테이션 이용해 생성자 만들고 자동 주입하도록
@RequestMapping("/notice/*")
public class E_NoticeController {
   
   private E_NoticeService service;
   
   @GetMapping("/list")
   // 리스트를 가져와서 화면단에 던져주기 그런데 여기서 어떻게 jsp에 아래 메소드를 태우나?
   // -> 26번줄에서 get,post방식으로 던질 건지 정해서 던져준다. 그럼 19번줄의 urlmapping 값에 매칭된다.
   public String list(Model model, E_PageDTO dto, HttpServletRequest request,
		   @RequestParam(value="nowPage", required = false)String nowPage,
		   @RequestParam(value="cntPerPage", required = false)String cntPerPage,
		   @RequestParam(value="searchType", required = false)String searchType,
		   @RequestParam(value="searchName", required = false)String searchName
		   ) {
	   
	   int total = service.getTotal(dto);
      
	   HttpSession session = request.getSession(false);
	   // request.getSession()에서 파라미터 false로 전달하면
	   // 이미 생성된 세션이 있을 때 그 세션을 반환하고 없으면 null 반환한다
	   
	   if (session == null) {
	      return "home";
	   }
	   
	   // 관리자로 로그인해야 게시글 등록 버튼 보이게
	   B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");
	   
	   if (loginPublicvo == null) {
	      model.addAttribute("loginPublicInfo", null);
	      log.info("loginPublicInfo??" + loginPublicvo);
	      
	   }else {
	      model.addAttribute("loginPublicInfo", loginPublicvo);
	      log.info("loginPublicInfo??" + loginPublicvo);
	   }
	   
	    if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
	    
		model.addAttribute("total", total);
		// pageMaker라는 이름으로 pageDTO 객체 만들어서 model에 담아주기
		dto = new E_PageDTO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		dto.setSearchName(searchName);
		dto.setSearchType(searchType);
		
		model.addAttribute("pageMaker", dto);
		
	    // model.addAttribute("list", service.getListWithPaging(vo)); 랑 같은 애
	    model.addAttribute("list", service.getListWithPaging(dto));
		
		log.info("현재 페이지 넘버? nowPage? >> " + nowPage);
		log.info("페이지당 글 개수? cntPerPage? >> " + cntPerPage);
		log.info("PageDTO는? >> "+dto);
		log.info("searchName >> " + searchName);
		log.info("searchType >> " + searchType);
		
	   return "/notice/E_list";
   }
   
   // view
   @GetMapping("/view")
      public String view(@RequestParam("n_num") long n_num, Model model,
    		  E_PageDTO dto, HttpServletRequest request) {
	   
	   HttpSession session = request.getSession(false);
	   // request.getSession()에서 파라미터 false로 전달하면
	   // 이미 생성된 세션이 있을 때 그 세션을 반환하고 없으면 null 반환한다
	   
	   if (session == null) {
	      return "home";
	   }
	   
	   // 관리자로 로그인해야 게시글 등록 버튼 보이게
	   B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");
	   
	   if (loginPublicvo == null) {
	      model.addAttribute("loginPublicInfo", null);
	      log.info("loginPublicInfo??" + loginPublicvo);
	      
	   }else {
	      model.addAttribute("loginPublicInfo", loginPublicvo);
	      log.info("loginPublicInfo??" + loginPublicvo);
	   }
		/*
		 * // 파일 띄우기 E_NoticeVO vo = new E_NoticeVO(); String n_file = vo.getN_file();
		 * log.info("n_file?" + n_file);
		 * 
		 * MultipartFile uploadFile = vo.getUploadFile(); File thumbnail = new
		 * File("C:\\upload\\"+n_file);
		 * 
		 * if(!uploadFile.isEmpty()) { String originalFileName =
		 * uploadFile.getOriginalFilename(); log.info("originalFileName은?! >> " +
		 * originalFileName); String ext = FilenameUtils.getExtension(originalFileName);
		 * // 확장자 구하기 log.info("ext(확장자)은?! >> " + ext); UUID uuid = UUID.randomUUID();
		 * // uuid 구하기
		 * 
		 * uploadFile.of() }
		 */
         log.info("선택된 글의 n_num"+n_num);
         model.addAttribute("notice", service.view(n_num));
         model.addAttribute("dto" , dto);
         
         return "notice/E_view";
      }

   // insert 페이지 가기
   @GetMapping("/register")
      public String register(HttpServletRequest request, Model model) {
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
		
         log.info("/register");
         return "/notice/E_register";
      }
   
   // insert (파일 업로드 O)
   @PostMapping("/register")
   public String register(E_NoticeVO vo, RedirectAttributes rttr, HttpServletRequest request) throws IOException {
      
      log.info("register 중");
      
      // 세션 처리
      HttpSession session = request.getSession(false);
      
      if (session == null) {
         return "home";
      }

      B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
      vo.setM_idx(loginPublicvo.getM_idx());                        // 관리자 식별번호 넣어주기 
      
            
      // 파일 업로드
      String n_file = null;
      MultipartFile uploadFile = vo.getUploadFile();
      
      
      if(!uploadFile.isEmpty()) {
         String originalFileName = uploadFile.getOriginalFilename();
         log.info("originalFileName은?! >> " + originalFileName);
         String ext = FilenameUtils.getExtension(originalFileName);   // 확장자 구하기
         log.info("ext(확장자)은?! >> " + ext);
         UUID uuid = UUID.randomUUID();   // uuid 구하기
         
         n_file = uuid + "." + ext ;
         /* uploadFile.transferTo(new File("src\\"+n_file)); */
         uploadFile.transferTo(new File("C:\\upload\\"+n_file));
         /* uploadFile.transferTo(new File("C:\\dev\\workspace\\workspace_spring\\kg_trip\\src\\main\\webapp\\resources\\images\\"+n_file)); */

         vo.setN_file(n_file);         // 있으면 넣어주기
      }

      
      log.info("파일 업로드 준비 완!");
      
      // insert
      service.insert(vo);
      rttr.addFlashAttribute("result", "success");
      
      return "redirect:/notice/list"; 
   }
   
   // 저장하면 연 월 일 폴더로 저장됨~!/
   private String getFolder() { 
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      Date date = new Date();
      String str = sdf.format(date);
      // separator : 구분자
      return str.replace("-", File.separator);
   }
   
   // remove
   @PostMapping("/remove")
   public String remove(@RequestParam("n_num") long n_num, RedirectAttributes rttr) {
      log.info("remove..." + n_num);
      
      if(service.remove(n_num)) {
         rttr.addAttribute("result", "success");
      }
      return "redirect:/notice/list";
   }
   
   // modify 페이지 가기
   @GetMapping("/modify")
   public String modify(@RequestParam("n_num") long n_num, Model model,
            E_Criteria cri) {
         log.info("modify 페이지 가는 중");
            
         model.addAttribute("notice", service.view(n_num));
         model.addAttribute("cri" , cri);
         
         log.info("/modify 타고 있느뇽?");
         
         return "notice/E_modify";
   }

   
   // modify
   @PostMapping("/modify")
      public String modify(E_NoticeVO vo, RedirectAttributes rttr, E_Criteria cri, HttpServletRequest request) throws IOException {
         log.info("modify" + vo);
         
         // 세션 처리
         HttpSession session = request.getSession(false);
         
         if (session == null) {
            return "home";
         }

         B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
         vo.setM_idx(loginPublicvo.getM_idx());                        // 관리자 식별번호 넣어주기 
         
            
         
         // 파일 업로드
            String n_file = null;
            MultipartFile uploadFile = vo.getUploadFile();
            
            if(!uploadFile.isEmpty()) {
               String originalFileName = uploadFile.getOriginalFilename();
               log.info("originalFileName은?! >> " + originalFileName);
               String ext = FilenameUtils.getExtension(originalFileName);   // 확장자 구하기
               log.info("ext은?! >> " + ext);
               UUID uuid = UUID.randomUUID();   // uuid 구하기
               
               n_file = uuid + "." + ext ;
               uploadFile.transferTo(new File("C:\\dev\\workspace\\workspace_spring\\kg_trip\\src\\main\\webapp\\resources\\images\\"+n_file));


               vo.setN_file(n_file);         // 있으면 넣어주기
            }
                  
         log.info("파일 업로드 준비 완!");
         
         if(service.modify(vo)) {
            rttr.addFlashAttribute("result", "success");   //
         }
         
         return "redirect:/notice/list";   // redirect : 모델 안 쓰고 (따로 값 저장해서 페이지 이동해서) 쓰려고 
      }

   
   

}