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
import org.kg.domain.E_OboVO;
import org.kg.domain.E_PageDTO;
import org.kg.service.E_OboService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor         // 보드컨트롤러는 보드서비스에 대해 의존적 > 어노테이션 이용해 생성자 만들고 자동 주입하도록
@RequestMapping("/obo/*")
public class E_OboController {
	
	private E_OboService service;
	
	@GetMapping("/list")
	public String list(Model model, E_PageDTO dto, HttpServletRequest request,
			   @RequestParam(value="nowPage", required = false)String nowPage,
			   @RequestParam(value="cntPerPage", required = false)String cntPerPage,
			   @RequestParam(value="searchType", required = false)String searchType,
			   @RequestParam(value="searchName", required = false)String searchName,
			   @RequestParam(value="cat", required = false)String cat
			   ) {
	   
		HttpSession session = request.getSession(false);
	   
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
	    int total = service.getOboTotalCount(dto);
		model.addAttribute("total", total);
		log.info("총 글 수 ? >> " + dto.getTotal());
	    
		// 카테고리 리스트
	   List<String> catList = new ArrayList<String>(List.of("여행","항공권","패키지","계정","신뢰센터","기타"));
	   model.addAttribute("catList", catList);
		
		// pageMaker라는 이름으로 pageDTO 객체 만들어서 model에 담아주기
		dto = new E_PageDTO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		model.addAttribute("pageMaker", dto);
		
	    // model.addAttribute("list", service.getListWithPaging(vo)); 랑 같은 애
	    model.addAttribute("list", service.getOboList(dto));
		
		log.info("현재 페이지 넘버? nowPage? >> " + nowPage);
		log.info("페이지당 글 개수? cntPage? >> " + dto.getCntPage());
		log.info("페이지당 글 개수? cntPerPage? >> " + cntPerPage);
		log.info("PageDTO는? >> "+dto);
		
	   return "/obo/E_obo_list";
	}
	
	// view
   @GetMapping("/view")
   public String view(@RequestParam("o_num") long o_num, Model model,
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

	   log.info("선택된 글의 o_num"+o_num);
	   model.addAttribute("obo", service.view(o_num));
	   model.addAttribute("dto" , dto);
      
         return "/obo/E_obo_view";
      }
   
   // 원글 register 페이지 가기
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
		
      log.info("/registerOrigin 가는 중");
         return "/obo/E_obo_registerOrigin";
      }
   
   // 답글 register 페이지 가기
   @GetMapping("/registerRe")
   public String registerRe(@RequestParam("o_num") long o_num,HttpServletRequest request, Model model, E_PageDTO dto) {
	   log.info("registerRe 페이지 가는 중");
	   
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
		
		// o_num 넣어주기
		model.addAttribute("o_num", o_num);
		log.info("o_num? >> " + o_num);
		log.info("/registerRe 가는 중");
       
	   return "/obo/E_obo_registerRe";
   }

   // 원글 insert (파일 업로드 O)
   @PostMapping("/registerOrigin")
   public String registerOrigin(E_OboVO vo, RedirectAttributes rttr, HttpServletRequest request) throws IOException {
      
      log.info("register 중");
      
      // 세션 처리
      HttpSession session = request.getSession(false);
      
      if (session == null) {
         return "home";
      }

      B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
      vo.setM_idx(loginPublicvo.getM_idx());                        // 관리자 식별번호 넣어주기 
      
            
      // 파일 업로드
      String o_file = null;
      MultipartFile uploadFile = vo.getUploadFile();
      
      
      if(!uploadFile.isEmpty()) {
         String originalFileName = uploadFile.getOriginalFilename();
         log.info("originalFileName은?! >> " + originalFileName);
         String ext = FilenameUtils.getExtension(originalFileName);   // 확장자 구하기
         log.info("ext(확장자)은?! >> " + ext);
         UUID uuid = UUID.randomUUID();   // uuid 구하기
         
         o_file = uuid + "." + ext ;
         uploadFile.transferTo(new File("C:\\upload\\"+o_file));

         vo.setO_file(o_file);
      }
      
      log.info("파일 업로드 준비 완!");

      // 카테고리 넣어주기
      
      vo.setO_cat(request.getParameter("o_cat"));
      
      // insert
      service.insertOrigin(vo);
      rttr.addFlashAttribute("result", "success");
      
      return "redirect:/obo/list"; 
   }
   
   // 답글 insert (파일 업로드 O)
   @PostMapping("/registerRe")
   public String registerRe(E_OboVO vo, RedirectAttributes rttr, Model model, HttpServletRequest request) throws IOException {
	   
	   log.info("register 중");
	   
	   // 세션 처리
	   HttpSession session = request.getSession(false);
	   
	   if (session == null) {
		   return "home";
	   }
	   
	   B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
	   vo.setM_idx(loginPublicvo.getM_idx());                        // 관리자 식별번호 넣어주기 
	   
	   
	   // 파일 업로드
	   String o_file = null;
	   MultipartFile uploadFile = vo.getUploadFile();
	   
	   
	   if(!uploadFile.isEmpty()) {
		   String originalFileName = uploadFile.getOriginalFilename();
		   log.info("originalFileName은?! >> " + originalFileName);
		   String ext = FilenameUtils.getExtension(originalFileName);   // 확장자 구하기
		   log.info("ext(확장자)은?! >> " + ext);
		   UUID uuid = UUID.randomUUID();   // uuid 구하기
		   
		   o_file = uuid + "." + ext ;
		   uploadFile.transferTo(new File("C:\\upload\\"+o_file));
		   
		   vo.setO_file(o_file);
	   }
	   
	   log.info("파일 업로드 준비 완!");
	   
	   // o_num 넣어주기
	   model.addAttribute("o_num", vo.getO_num());
	   log.info("답글 register중) o_num ?? >> " + vo.getO_num());
	   
	   // 카테고리 넣어주기
	   vo.setO_cat(request.getParameter("o_cat"));
	   
	   // 답글에 필요한 정보들 확인
	   log.info("originNo? >> " + vo.getO_originNo());
	   log.info("groupOrd? >> " + vo.getO_groupOrd());
	   log.info("groupLayer? >> " + vo.getO_groupLayer());
	   
	   log.info(vo);
	   // insert
	   service.insertRe(vo);
	   rttr.addFlashAttribute("result", "success");
	   
	   return "redirect:/obo/list"; 
   }
   
   // remove
	/* @PostMapping("/remove") 
   public String remove(@RequestParam("o_num") long o_num, RedirectAttributes rttr) {
      log.info("remove..." + o_num);
      
      if(service.remove(o_num)) {
         rttr.addAttribute("result", "success");
      }
      return "redirect:/obo/list";
   }*/

   @DeleteMapping(value="/{o_num}", produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> remove(@PathVariable("o_num") Long o_num, E_OboVO vo, HttpServletRequest request){
   //public int remove(E_OboVO vo, HttpServletRequest request) throws Exception{
	   
	   log.info("삭제할 거야.");
	   
	   
	   // 세션 처리
	   HttpSession session = request.getSession(false);
	   B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
	   vo.setM_idx(loginPublicvo.getM_idx());                        						// 관리자 식별번호 넣어주기
	   
	   // 로그인한 유저와 글 작성자가 일치할 경우 글 삭제
	   long usersIdx = loginPublicvo.getM_idx(); // 유저의 idx
	   long writersIdx = vo.getM_idx();			// 글쓴이의 idx
	   
	   int result = 0 ;
	   
	   if(usersIdx == writersIdx) {
		   service.remove(vo.getO_num());
		   
		   result = 1 ;
	   }else {
		   log.info("작성자가 일치하지 않습니다.");
	   }
	   
	   //return result;
	   return service.remove(o_num) == 1
	            ? new ResponseEntity<>("success", HttpStatus.OK)
	                  : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   // modify 페이지 가기
   @GetMapping("/modify")
   public String modify(@RequestParam("o_num") long o_num, Model model,E_OboVO vo, E_PageDTO dto, HttpServletRequest request) {
	   log.info("modify 페이지 가는 중");
	   
	   // 세션 처리
	   HttpSession session = request.getSession(false);
	   B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
	   vo.setM_idx(loginPublicvo.getM_idx());                        						// 관리자 식별번호 넣어주기
	   
	   // 카테고리 리스트
	   List<String> catList = new ArrayList<String>(List.of("여행","항공권","패키지","계정","신뢰센터","기타"));
	   model.addAttribute("catList", catList); 
	   
       model.addAttribute("obo", service.view(o_num));
       log.info("/modify 타고 있느뇽?");
       
	   return "/obo/E_obo_modify";
   }

// modify ing(파일값 빼고 수정됨 ;)
   @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, 
         value = "/{o_num}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> update(@RequestBody E_OboVO vo, @PathVariable("o_num") int o_num,
		   RedirectAttributes rttr, HttpServletRequest request) throws IOException{
      
	   log.info("update" + vo);
	      
	   // 세션 처리
	   HttpSession session = request.getSession(false);
  
	   B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");	// 세션에 저장되어있는 관리자 정보 꺼내오기 
	   vo.setM_idx(loginPublicvo.getM_idx());                        						// 관리자 식별번호 넣어주기
  
	   log.info("좋은 말로 할 때 vo값 내놔라.(이미지 삭제 전.) " + vo.toString());
	     
//	   // 파일 업로드
//      String o_file = null;
//      MultipartFile uploadFile = vo.getUploadFile();
//      
//      
//      if(!uploadFile.isEmpty()) {
//         String originalFileName = uploadFile.getOriginalFilename();
//         log.info("originalFileName은?! >> " + originalFileName);
//         String ext = FilenameUtils.getExtension(originalFileName);   // 확장자 구하기
//         log.info("ext(확장자)은?! >> " + ext);
//         UUID uuid = UUID.randomUUID();   // uuid 구하기
//         
//         o_file = uuid + "." + ext ;
//         uploadFile.transferTo(new File("C:\\upload\\"+o_file));
//
//         vo.setO_file(o_file);
//      }
//	      
//      log.info("파일 업로드 준비 완!");
	   
	   vo.setO_num(o_num);
	   log.info("o_num : " + o_num);
	   log.info("modify vo ? : " + vo);
      
	   int modifyCount = service.update(vo);
      
	   log.info("MODIFY COUNT ???? >> " + modifyCount);
      
	   return modifyCount == 1 ?
            new ResponseEntity<>("success", HttpStatus.OK)
               : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, 
		   value="/removeImg/{o_num}", produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> removeImg(@PathVariable("o_num") Long o_num, HttpServletRequest request){
	   
	   log.info("삭제할 거야.~~");
	   
	   // 세션 처리
//	   HttpSession session = request.getSession(false);
//	   B_PublicMemberVO loginPublicvo = (B_PublicMemberVO)session.getAttribute("public");   // 세션에 저장되어있는 관리자 정보 꺼내오기 
//	   vo.setM_idx(loginPublicvo.getM_idx());                        						// 관리자 식별번호 넣어주기

	   //	   // 로그인한 유저와 글 작성자가 일치할 경우 글 삭제
//	   long usersIdx = loginPublicvo.getM_idx(); // 유저의 idx
//	   long writersIdx = vo.getM_idx();			// 글쓴이의 idx
//	   
	   int result = 0 ;
	   
	   log.info("삭제할 거야.2");
//	   if(usersIdx == writersIdx) {
//		   service.makeFileNullUpdate(vo.getO_num());
//		   
//		   result = 1 ;
//	   }else {
//		   log.info("음 실패 !");
//	   }
	   
	   log.info("삭제할 거야.3");

	   return service.makeFileNullUpdate(o_num) == 1
	            ? new ResponseEntity<>("success", HttpStatus.OK)
	                  : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
   }
}
