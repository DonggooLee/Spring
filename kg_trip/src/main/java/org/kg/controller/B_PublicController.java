package org.kg.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kg.domain.B_PublicMemberVO;
import org.kg.domain.BirthForm;
import org.kg.service.B_corpMemberService;
import org.kg.service.B_publicMemberService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.net.aso.l;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/Traveler/*")
public class B_PublicController {

	private B_publicMemberService pm_service;
	
	// 마이페이지
	@GetMapping("/myPage")
	public String trew(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession(false);
		if (session == null) {
			return "home";
		}

		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		String birth_year = "";
		String birth_month = "";
		String birth_date = "";
		
		if (loginvo == null) {
			model.addAttribute("loginPublicInfo", null);
		} else{
			birth_year = loginvo.getM_birth().substring(0, 4);
			birth_month = loginvo.getM_birth().substring(4, 6);
			birth_date = loginvo.getM_birth().substring(6);
			
			model.addAttribute("loginPublicInfo", loginvo);
			model.addAttribute("birthYear", birth_year);
			model.addAttribute("birthMonth", birth_month);
			model.addAttribute("birthDate", birth_date);
			log.info(loginvo);
		}
		log.info("마이페이지로 갑니다");
		return "public/publicAccountPage";
	}
	
	@GetMapping(value = "/nicknameUpdate", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public int publicNicknameUpdate(@RequestParam("m_idx") int m_idx,@RequestParam("m_nickname") String m_nickname, Model model,HttpServletRequest request) {
		
		HttpSession session = request.getSession(false);
		if (session == null) {
			return 0;
		}
		
		if(pm_service.nicknameUpdate(m_idx, m_nickname) != 1) {
			B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
			return pm_service.nicknameUpdate(m_idx, m_nickname);
		}
		
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		
		loginvo.setM_nickname(m_nickname);
		
		session.setAttribute("public", loginvo);
		
		log.info(m_idx + m_nickname);
		
		return pm_service.nicknameUpdate(m_idx, m_nickname);
	}
	
	@PostMapping(value = "/introUpdate", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> publicIntroUpdate(@RequestBody B_PublicMemberVO vo, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		
		loginvo.setM_intro(vo.getM_intro());
		
		session.setAttribute("public", loginvo);
		
		log.info(vo.getM_idx() + vo.getM_intro());
		
		return pm_service.introUpdate(vo.getM_idx(), vo.getM_intro()) == 1 ? 
				new ResponseEntity<String> ("success", HttpStatus.OK) : 
					new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/birthUpdate", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> publicBirthUpdate(@RequestBody B_PublicMemberVO vo, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		
		loginvo.setM_birth(vo.getBirthYear() + vo.getBirthMonth() + vo.getBirthDate());
		
		session.setAttribute("public", loginvo);
		
		vo.setM_birth(vo.getBirthYear() + vo.getBirthMonth() + vo.getBirthDate());
		
		log.info(vo.getM_idx() + loginvo.getM_birth());
		
		return pm_service.birthUpdate(vo.getM_idx(), vo.getM_birth()) == 1 ? 
				new ResponseEntity<String> ("success", HttpStatus.OK) : 
					new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/genderUpdate", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> publicGenderUpdate(@RequestBody B_PublicMemberVO vo, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		
		loginvo.setM_gender(vo.getM_gender());
		
		session.setAttribute("public", loginvo);
		
		log.info(vo.getM_idx() + vo.getM_gender());
		
		return pm_service.genderUpdate(vo.getM_idx(), vo.getM_gender()) == 1 ? 
				new ResponseEntity<String> ("success", HttpStatus.OK) : 
					new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/imgUpdate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<B_PublicMemberVO> publicImgUpdate(Model model,HttpServletRequest request,HttpSession session, MultipartFile uploadFile,@RequestParam("m_idx") int m_idx) {
		
		log.info("file upload success..............!!!!!"+uploadFile+"와 "+m_idx);
		
		B_PublicMemberVO vo = new B_PublicMemberVO();
		
		String uploadFolder = "C:\\upload";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    String str = sdf.format(date);
	    String datePath = str.replace("-", File.separator);
	      
	    File uploadPath = new File(uploadFolder, datePath);
	    log.info("uploadPath : "+uploadPath);
	    
	    if(! uploadPath.exists()) {
			uploadPath.mkdirs();
			log.info(uploadPath.mkdirs());
		}

	    String uploadFileName = uploadFile.getOriginalFilename();
	    String uuid = UUID.randomUUID().toString();
	    uploadFileName = uuid.toString() + "_" + uploadFileName;
	    vo.setM_img("\\"+datePath+"\\"+uploadFileName);
	    vo.setM_idx(m_idx);
	    log.info(vo.getM_img());
	    
	    File saveFile = new File(uploadPath, uploadFileName);

	    try {
	    	uploadFile.transferTo(saveFile);
	    	
		} catch (Exception e) {
			e.printStackTrace();
		}
	    //-------------------
	    session = request.getSession(false);
		
		B_PublicMemberVO loginvo = (B_PublicMemberVO) session.getAttribute("public");
		
		loginvo.setM_img(vo.getM_img());
		
		session.setAttribute("public", loginvo);
		
		log.info(vo.getM_idx() + vo.getM_img());
		
		pm_service.imgUpdate(vo.getM_idx(), vo.getM_img());
	    
	    ResponseEntity<B_PublicMemberVO> result = new ResponseEntity<B_PublicMemberVO>(vo,HttpStatus.OK);
	    log.info(result);
		
		return result;
	}
}
