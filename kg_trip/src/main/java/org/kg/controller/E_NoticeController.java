package org.kg.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.kg.domain.B_AdminVO;
import org.kg.domain.B_CorpMemberVO;
import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.Criteria;
import org.kg.domain.E_NoticeVO;
import org.kg.domain.PageDTO;
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
      public String list(Model model, Criteria cri, HttpServletRequest request) {
         
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
	   
       log.info("list..."+cri);
       model.addAttribute("list", service.getListWithPaging(cri));
      
        int total = service.getTotal();
         
        log.info("total : " + total);
        log.info("cri.amount : " + cri.getAmount());
        log.info("cri.pageNum : " + cri.getPageNum());
        
        model.addAttribute("total", total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));
         // pageMaker라는 이름으로 pageDTO 객체 만들어서 model에 담아주기
         
      return "/notice/E_list";
      }
   
   // view
   @GetMapping("/view")
      public String view(@RequestParam("n_num") long n_num, Model model,
            Criteria cri, HttpServletRequest request) {
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
	   
         log.info("선택된 글의 n_num"+n_num);
         model.addAttribute("notice", service.view(n_num));
         model.addAttribute("cri" , cri);
         
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
   
   // insert (파일 업로드 X)
   @PostMapping("/register")
   public String register(E_NoticeVO vo, RedirectAttributes rttr, HttpServletRequest request) throws IOException {
      
      log.info("register 중");
      
      // 세션 처리
      HttpSession session = request.getSession(false);
      
      if (session == null) {
         return "home";
      }

      B_AdminVO loginAdminvo = (B_AdminVO)session.getAttribute("admin");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
      vo.setA_idx(loginAdminvo.getA_idx());                        // 관리자 식별번호 넣어주기 
      
            
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
         /* uploadFile.transferTo(new File("src\\"+n_file)); */
         uploadFile.transferTo(new File("C:\\dev\\workspace\\workspace_spring\\kg_trip\\src\\main\\webapp\\resources\\images\\"+n_file));

         vo.setN_file(n_file);         // 있으면 넣어주기
      }

      
      log.info("파일 업로드 준비 완!");
      
      // insert
      service.insert(vo);
      rttr.addFlashAttribute("result", "success");
      
      return "redirect:/notice/list"; 
   }
   
   
   
   /*
   // insert (파일 업로드 X)
   @PostMapping("/register")
   public String register(E_NoticeVO vo, RedirectAttributes rttr) throws IOException {
      
      log.info("register 중");
      
      // 관리자 식별번호 임의로 넣어주기 
      vo.setA_idx("2342342");
      
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
         uploadFile.transferTo(new File("C:\\uploadNotice\\"+n_file));
         
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
    */
   
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
            Criteria cri) {
         log.info("modify 페이지 가는 중");
            
         model.addAttribute("notice", service.view(n_num));
         model.addAttribute("cri" , cri);
         
         log.info("/modify 타고 있느뇽?");
         
         return "notice/E_modify";
   }

   
   // modify
   @PostMapping("/modify")
      public String modify(E_NoticeVO vo, RedirectAttributes rttr, Criteria cri, HttpServletRequest request) throws IOException {
         log.info("modify" + vo);
         
         // 세션 처리
         HttpSession session = request.getSession(false);
         
         if (session == null) {
            return "home";
         }

         B_AdminVO loginAdminvo = (B_AdminVO)session.getAttribute("admin");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
         vo.setA_idx(loginAdminvo.getA_idx());                        // 관리자 식별번호 넣어주기 
         
            
         
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