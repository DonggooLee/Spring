package org.kg.controller;

import java.io.File;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.E_FreqVO;
import org.kg.domain.E_PageDTO;
import org.kg.service.E_FreqService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.http.MediaType;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor         // 보드컨트롤러는 보드서비스에 대해 의존적 > 어노테이션 이용해 생성자 만들고 자동 주입하도록
@RequestMapping("/freq/*")
public class E_FreqController {
   
	private E_FreqService service;
   
   @GetMapping("/list")
   public String list(Model model, E_PageDTO dto, HttpServletRequest request,
		   @RequestParam(value="nowPage", required = false)String nowPage,
		   @RequestParam(value="cntPerPage", required = false)String cntPerPage,
		   @RequestParam(value="searchType", required = false)String searchType,
		   @RequestParam(value="searchName", required = false)String searchName,
		   @RequestParam(value="cat", required = false)String cat
		   ) {
	   
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
	    
	    // total 구하기
	    int total = service.getFreqTotalCount(dto);
		model.addAttribute("total", total);
		
		// 카테고리 리스트
	   List<String> catList = new ArrayList<String>(List.of("여행","항공권","패키지","계정","신뢰센터","기타"));
	   model.addAttribute("catList", catList);
		
		// pageMaker라는 이름으로 pageDTO 객체 만들어서 model에 담아주기
		dto = new E_PageDTO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		dto.setSearchName(searchName);
		dto.setSearchType(searchType);
		
		model.addAttribute("pageMaker", dto);
		
	    // model.addAttribute("list", service.getListWithPaging(vo)); 랑 같은 애
	    model.addAttribute("list", service.getFreqListWithPaging(dto));
		
		log.info("현재 페이지 넘버? nowPage? >> " + nowPage);
		log.info("페이지당 글 개수? cntPage? >> " + dto.getCntPage());
		log.info("페이지당 글 개수? cntPerPage? >> " + cntPerPage);
		log.info("PageDTO는? >> "+dto);
		log.info("searchName >> " + searchName);
		log.info("searchType >> " + searchType);
		
	   return "/freq/E_fq_list";
   }
   
   // view
   @GetMapping("/view")
   public String view(@RequestParam("fq_num") long fq_num, Model model,
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

	   log.info("선택된 글의 fq_num"+fq_num);
      model.addAttribute("freq", service.view(fq_num));
      model.addAttribute("dto" , dto);
      
         return "/freq/E_fq_view";
      }
   
   // register 페이지 가기
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
         return "/freq/E_fq_register";
      }
   
   // insert (파일 업로드 O)
   @PostMapping("/register")
   public String register(E_FreqVO vo, RedirectAttributes rttr, HttpServletRequest request) throws IOException {
      
      log.info("register 중");
      
      // 세션 처리
      HttpSession session = request.getSession(false);
      
      if (session == null) {
         return "home";
      }

      B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
      vo.setM_idx(loginPublicvo.getM_idx());                        // 관리자 식별번호 넣어주기 
      
            
      // 파일 업로드
      String fq_file = null;
      MultipartFile uploadFile = vo.getUploadFile();
      
      
      if(!uploadFile.isEmpty()) {
         String originalFileName = uploadFile.getOriginalFilename();
         log.info("originalFileName은?! >> " + originalFileName);
         String ext = FilenameUtils.getExtension(originalFileName);   // 확장자 구하기
         log.info("ext(확장자)은?! >> " + ext);
         UUID uuid = UUID.randomUUID();   // uuid 구하기
         
         fq_file = uuid + "." + ext ;
         uploadFile.transferTo(new File("C:\\upload\\"+fq_file));

         vo.setFq_file(fq_file);
      }
      
      log.info("파일 업로드 준비 완!");

      // 카테고리 넣어주기
      
      vo.setFq_cat(request.getParameter("fq_cat"));
      // vo.setFq_cat("기타");
      
      // insert
      service.insert(vo);
      rttr.addFlashAttribute("result", "success");
      
      return "redirect:/freq/list"; 
   }
   
   // remove
   @PostMapping("/remove")
   public String ntRemove(@RequestParam("fq_num") long fq_num, RedirectAttributes rttr) {
      log.info("remove..." + fq_num);
      
      if(service.remove(fq_num)) {
         rttr.addAttribute("result", "success");
      }
      return "redirect:/freq/list";
   }
   
   
   // modify 페이지 가기
   @GetMapping("/modify")
   public String modify(@RequestParam("fq_num") long fq_num, Model model, E_PageDTO dto) {
	   log.info("modify 페이지 가는 중");
	   
	   // 카테고리 리스트
	   List<String> catList = new ArrayList<String>(List.of("여행","항공권","패키지","계정","신뢰센터","기타"));
	   model.addAttribute("catList", catList); 
	   
       model.addAttribute("freq", service.view(fq_num));
       log.info("/modify 타고 있느뇽?");
       
	   return "/freq/E_fq_modify";
   }
   
   // modify 수정하기 
   @PostMapping("/modify")
   public String modify(E_FreqVO vo, RedirectAttributes rttr, HttpServletRequest request) throws IOException {
      log.info("modify" + vo);
      
      // 세션 처리
      HttpSession session = request.getSession(false);
      
      if (session == null) {
         return "home";
      }

      B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");	// 세션에 저장되어있는 관리자 정보 꺼내오기 
      vo.setM_idx(loginPublicvo.getM_idx());                        						// 관리자 식별번호 넣어주기
      
      log.info("좋은 말로 할 때 vo값 내놔라.(이미지 삭제 전.) " + vo.toString());
      
      // 파일 삭제
      if(service.makeFileNullUpdate(vo)) {
          rttr.addFlashAttribute("result", "success");   
       }
      log.info("좋은 말로 할 때 vo값 내놔라.(이미지 삭제 되냐?) " + vo.toString());
   
      // 파일 업로드
      String fq_file = null;
      MultipartFile uploadFile = vo.getUploadFile();
      
      
      if(!uploadFile.isEmpty()) {
         String originalFileName = uploadFile.getOriginalFilename();
         log.info("originalFileName은?! >> " + originalFileName);
         String ext = FilenameUtils.getExtension(originalFileName);   // 확장자 구하기
         log.info("ext(확장자)은?! >> " + ext);
         UUID uuid = UUID.randomUUID();   // uuid 구하기
         
         fq_file = uuid + "." + ext ;
         uploadFile.transferTo(new File("C:\\upload\\"+fq_file));

         vo.setFq_file(fq_file);
      }
      
      log.info("파일 업로드 준비 완!");
      
      log.info("수정 전 카테고리?" + vo.getFq_cat());
	
      if(service.modify(vo)) {
         rttr.addFlashAttribute("result", "success");   //
      }

      log.info("수정 후 카테고리?" + vo.getFq_cat());
      
      return "redirect:/freq/list";   // redirect : 모델 안 쓰고 (따로 값 저장해서 페이지 이동해서) 쓰려고 
   }
   
   
   // modify 수정하기 
   @PostMapping("/modifyImg")
   public String modifyImg(@RequestParam("fq_file") MultipartFile multi,E_FreqVO vo, 
		   RedirectAttributes rttr, HttpServletRequest request) throws IOException {
	   log.info("modify" + vo);
	   
	   log.info("modifyImg 타고 있느뇨???ㄴ");
	   
	   // 세션 처리
	   HttpSession session = request.getSession(false);
	   
	   if (session == null) {
		   return "home";
	   }
	   
	   B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");	// 세션에 저장되어있는 관리자 정보 꺼내오기 
	   vo.setM_idx(loginPublicvo.getM_idx());                        						// 관리자 식별번호 넣어주기
	   
	   log.info("좋은 말로 할 때 vo값 내놔라.(이미지 삭제 전.) " + vo.toString());
	   
	   // 파일 삭제
	   if(service.makeFileNullUpdate(vo)) {
		   rttr.addFlashAttribute("result", "success");   
	   }
	   log.info("좋은 말로 할 때 vo값 내놔라.(이미지 삭제 되냐?) " + vo.toString());
	   
	   // 복붙
	   
	   try {
		   String uploadpath = "C:\\upload\\" ;
		   String originFilename = multi.getOriginalFilename();
		   
	   if(!multi.isEmpty()){
           File file = new File(uploadpath, multi.getOriginalFilename());
          // uploadFile.transferTo(new File("C:\\upload\\"+fq_file));

           multi.transferTo(file);
           
           rttr.addAttribute("filename", multi.getOriginalFilename());
           rttr.addAttribute("uploadPath", file.getAbsolutePath());
           
           return "/freq/list";
		       };
	   }catch(Exception e){
	       System.out.println(e);
	   }
	   return "redirect:/freq/E_fq_modify";
	}
			   
   
   
}