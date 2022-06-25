package org.kg.controller;

import java.io.File;
import java.util.Locale;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.P_Pakage_info_VO;
import org.kg.domain.P_Pakage_list_VO;
import org.kg.domain.P_Pakage_reser_VO;
import org.kg.domain.P_Review_VO;
import org.kg.service.P_PakageService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/pakage/*")
public class P_Controller {

	// P_pakageMain 메인페이지 이동
	private P_PakageService service;

	@GetMapping("/P_pakageMain")
	public String main(HttpServletRequest request, Model model) {
		
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

		model.addAttribute("listWeu", service.getListWeu()); // 서유럽 리스트 목록
		model.addAttribute("listSai", service.getListSai()); // 사이판 리스트 목록
		model.addAttribute("listkos", service.getListKos()); // 국내섬 리스트 목록
		

		return "pakage/P_pakageMain";
	}

	// P_get 상세페이지 이동, 후기
	@GetMapping("/P_get")
	public String get(HttpServletRequest request, @RequestParam("p_num") String p_num, Model model) {
		
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
		
		model.addAttribute("board", service.get(p_num));		// 상세 내용
		model.addAttribute("review", service.getReview(p_num));	// 후기 리스트 목록
		model.addAttribute("star", service.star(p_num));		// 평균 별점
		
		log.info(service.getReview(p_num));
		
		return "/pakage/P_get";
	}
	
	// P_rinsert 후기 등록페이지 이동
	@GetMapping("/P_rinsert")
	public String rinsert(Model model) {
	
		return "pakage/P_rinsert";
	}
	
	// 후기 등록
	@PostMapping("/uploadFormAction") 
	public String uploadFormAction(MultipartFile[] uploadFile, P_Review_VO rboard, Model model) {
		
		String uploadFolder = "C:\\dev\\workspace\\workspace_spring\\kg_trip\\src\\main\\webapp\\resources\\images";
		
		for(MultipartFile multipartFile : uploadFile) {
		
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile.getOriginalFilename());
			log.info("upload File Size : " +multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try { 
				multipartFile.transferTo(saveFile);
			 } catch(Exception e) {
				log.error(e.getMessage());
			 }
			
			rboard.setP_reviewimg(multipartFile.getOriginalFilename());	// 파일 업로드
			
			log.info(rboard);
			
			service.rregister(rboard);									// 후기 등록
		}
		return "/pakage/P_pakageMain";
	}
	

	// P_reservation 예약페이지 이동
	@RequestMapping(value = "people", method = RequestMethod.POST)
	public String reservation(HttpServletRequest request, Locale locale, Model model, String p_num, int people) {
		
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
		
		log.info("---------------" + p_num);
		log.info("---------------" + people);

		model.addAttribute("board", service.get(p_num));
		model.addAttribute("p_rpeople", people);
		model.addAttribute("p_totalfee", service.get(p_num).getP_fee() * people);

		return "/pakage/P_reservation";
	}

	// 예약하기 P_pakage_reser_tbl 추가, P_pakage_list_VO 수정
	@PostMapping("/P_preservation")
	public String register(P_Pakage_reser_VO board, P_Pakage_list_VO liboard, RedirectAttributes rttr) {
		
		String p_num = board.getP_num();
		liboard = service.getp(p_num);
		
		log.info(liboard.getP_available());
		log.info(board.getP_rpeople());
		log.info(liboard.getP_max());
		
		/* (liboard.getP_available() + board.getP_rpeople() < liboard.getP_max()) */
			Random ran = new Random();
			int num = ran.nextInt(999+1);
			board.setP_rnum(board.getP_num()+board.getM_idx()+num);
			service.register(board);
			
			liboard.setP_people(liboard.getP_people() + board.getP_rpeople());
			liboard.setP_available(liboard.getP_available() - board.getP_rpeople());

			service.update(liboard);
			
			rttr.addFlashAttribute("result", "ok");
	
		
		return "redirect:/pakage/P_pakageMain";
	}
	
	// P_allList 전체 리스트 페이지 이동
	@GetMapping("/P_allList")
	public String allList(HttpServletRequest request, Model model) {
		
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
		
		model.addAttribute("list", service.getList()); // 전체 리스트 목록

		return "pakage/P_allList";
	}
	
	// P_search 검색 결과 페이지 이동
	@PostMapping("/P_search")
	public String search(HttpServletRequest request, String region, P_Pakage_info_VO board, Model model) {
		
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
		
		region = "%"+region+"%";
		model.addAttribute("list", service.search(region));
		return "pakage/P_search";
	}
	
	/////////////////////////////////////////////////////////////
	
	
	// P_mlist 개인 구매 패키지 리스트 페이지 이동
	@GetMapping("/P_mlist")
	public String mlist(HttpServletRequest request, Model model) {
		
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
		
		int m_idx = loginvo.getM_idx();
		
		model.addAttribute("mlist", service.getmList(m_idx));
		
		log.info(service.getmList(m_idx));
		
		return "pakage/P_mlist";
	}
	
	
	
	
	
	
	
	
	/////////////////////////////////////////////////////////////
	
	// P_clist 기업 패키지 리스트 페이지 이동
	@GetMapping("/P_clist")
	public String clist(Model model) {
		int c_idx = 4; // 로그인 연동 예정 임시 숫자
		
		model.addAttribute("clist", service.getcList(c_idx));
		
		log.info(service.getcList(c_idx));
		
		return "pakage/P_clist";
	}
	
	
	// P_cinsert 기업 패키지 등록 페이지 이동
	@GetMapping("/P_cinsert")
	public String cinsert(Model model) {

		return "pakage/P_cinsert";
	}
	
	// 패키지 등록
	@PostMapping("/uploadFormGo") 
	public String uploadFormGo(MultipartFile[] uploadFilea, MultipartFile[] uploadFileb,
			 MultipartFile[] uploadFilec, MultipartFile[] uploadFiled, MultipartFile[] uploadFilee,
			 P_Pakage_list_VO liboard, P_Pakage_info_VO board, Model model) {
		

		log.info("--------------------" + liboard);
		
		String uploadFolder = "C:\\dev\\workspace\\workspace_spring\\kg_trip\\src\\main\\webapp\\resources\\images";
		
		for(MultipartFile multipartFile1 : uploadFilea) {
		
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile1.getOriginalFilename());
			log.info("upload File Size : " +multipartFile1.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile1.getOriginalFilename());
			
			try { 
				multipartFile1.transferTo(saveFile);
			 } catch(Exception e) {
				log.error(e.getMessage());
			 }
			board.setP_mainimg(multipartFile1.getOriginalFilename());
		}
		
		for(MultipartFile multipartFile2 : uploadFileb) {
			
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile2.getOriginalFilename());
			log.info("upload File Size : " +multipartFile2.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile2.getOriginalFilename());
			
			try { 
				multipartFile2.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
			board.setP_img1(multipartFile2.getOriginalFilename());
		}
		for(MultipartFile multipartFile3 : uploadFilec) {
			
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile3.getOriginalFilename());
			log.info("upload File Size : " +multipartFile3.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile3.getOriginalFilename());
			
			try { 
				multipartFile3.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
			board.setP_img2(multipartFile3.getOriginalFilename());
		}
		
		for(MultipartFile multipartFile4 : uploadFiled) {
			
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile4.getOriginalFilename());
			log.info("upload File Size : " +multipartFile4.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile4.getOriginalFilename());
			
			try { 
				multipartFile4.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
			board.setP_img3(multipartFile4.getOriginalFilename());
		}
		
		for(MultipartFile multipartFile5 : uploadFilee) {
			
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile5.getOriginalFilename());
			log.info("upload File Size : " +multipartFile5.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile5.getOriginalFilename());
			
			try { 
				multipartFile5.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
			board.setP_img4(multipartFile5.getOriginalFilename());
		}
		
		service.cinserta(board);
		
		liboard.setP_people(0);
		liboard.setP_available(0);
		
		service.cinsertb(liboard);
		
		int c_idx = board.getC_idx();
		model.addAttribute("clist", service.getcList(c_idx));
	
		return "/pakage/P_clist";
	}

	// 패키지 수정 페이지 이동
	@GetMapping("/P_cmodify")
	public String cmodify(@RequestParam("p_num") String p_num, Model model) {

		model.addAttribute("board", service.get(p_num));

		return "/pakage/P_cmodify";
	}
	
	// 패키지 수정
	@PostMapping("/uploadFormMo") 
	public String uploadFormMo(MultipartFile[] uploadFilea, MultipartFile[] uploadFileb,
			 MultipartFile[] uploadFilec, MultipartFile[] uploadFiled, MultipartFile[] uploadFilee,
			 P_Pakage_list_VO liboard, P_Pakage_info_VO board, Model model) {
		

		log.info("--------------------" + liboard);
		
		String uploadFolder = "C:\\dev\\workspace\\workspace_spring\\kg_trip\\src\\main\\webapp\\resources\\images";
		
		for(MultipartFile multipartFile1 : uploadFilea) {
		
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile1.getOriginalFilename());
			log.info("upload File Size : " +multipartFile1.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile1.getOriginalFilename());
			
			try { 
				multipartFile1.transferTo(saveFile);
			 } catch(Exception e) {
				log.error(e.getMessage());
			 }
			board.setP_mainimg(multipartFile1.getOriginalFilename());
		}
		
		for(MultipartFile multipartFile2 : uploadFileb) {
			
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile2.getOriginalFilename());
			log.info("upload File Size : " +multipartFile2.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile2.getOriginalFilename());
			
			try { 
				multipartFile2.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
			board.setP_img1(multipartFile2.getOriginalFilename());
		}
		for(MultipartFile multipartFile3 : uploadFilec) {
			
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile3.getOriginalFilename());
			log.info("upload File Size : " +multipartFile3.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile3.getOriginalFilename());
			
			try { 
				multipartFile3.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
			board.setP_img2(multipartFile3.getOriginalFilename());
		}
		
		for(MultipartFile multipartFile4 : uploadFiled) {
			
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile4.getOriginalFilename());
			log.info("upload File Size : " +multipartFile4.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile4.getOriginalFilename());
			
			try { 
				multipartFile4.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
			board.setP_img3(multipartFile4.getOriginalFilename());
		}
		
		for(MultipartFile multipartFile5 : uploadFilee) {
			
			log.info("--------------------------");
			log.info("upload File Name : " + multipartFile5.getOriginalFilename());
			log.info("upload File Size : " +multipartFile5.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile5.getOriginalFilename());
			
			try { 
				multipartFile5.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
			board.setP_img4(multipartFile5.getOriginalFilename());
		}
		
		service.cupdatea(board);
		
		liboard.setP_people(0);
		liboard.setP_available(0);
		
		service.cupdateb(liboard);
		
		int c_idx = board.getC_idx();
		
		model.addAttribute("clist", service.getcList(c_idx));
	
		return "/pakage/P_clist";
	}
	
	// 패키지 삭제
	@GetMapping("/P_cdelete")
	public String cdelete(@RequestParam("p_num") String p_num, Model model) {

		service.cdeletea(p_num);
		service.cdeleteb(p_num);
		
		
		return "/pakage/P_clist";
	}
	
}
