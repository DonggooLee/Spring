package org.kg.controller;


import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kg.domain.D_BoardVO;
import org.kg.domain.D_ImageVO;
import org.kg.domain.D_likeDTO;
import org.kg.domain.D_likeNumDTO;
import org.kg.domain.D_likelistwhoDTO;
import org.kg.domain.D_likewhotfVO;
import org.kg.service.D_boardService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/content/")
public class D_subController {
	
	
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	D_boardService service;
	
	@ResponseBody
	@RequestMapping(value = "/like")
	public D_likeNumDTO like(@RequestParam HashMap<String,String> paramMap, Model model) {
		int result = 0;
		HashMap<String,String> msg = new HashMap<String,String>();
		
		D_likeDTO dto = new D_likeDTO();
		D_likeNumDTO dto2 = new D_likeNumDTO();
		
		String bno = paramMap.get("bno");
		String who = paramMap.get("who");
		String tf = paramMap.get("tf");
		
		int bno2=Integer.parseInt(bno);
		int tf2=Integer.parseInt(tf);
		int tf3=0;
		
		dto.setBno(bno2);
		dto.setLiketf(tf2);
		dto.setLikewho(who);
		
		
		result = service.likeInsert(dto);
		D_likeDTO dto1 = service.selectlike(bno2);
		int likeNum = service.selectlikeNum(bno2);
		String likeNum2 = Integer.toString(likeNum);
		
		dto2.setBno(bno2);
		dto2.setCount(likeNum);
		
		msg.put("bno", bno);
		msg.put("likeNum", likeNum2);
		
		if(dto1.getLiketf()==1) {
			tf3=1;
		}
		else {
			tf3=0;
		}
		log.info(dto2);
		log.info(likeNum);
		log.info(bno+who+tf);
		log.info(dto1);
		log.info(result);
		log.info("tf"+tf);
		
		model.addAttribute("bno3",bno2);
			
		return dto2;
	}
	
	@GetMapping("/likeNum")
	public int ajax(@RequestParam HashMap<String,String> paramMap) {

		String bno = paramMap.get("bno");
		int bno2=Integer.parseInt(bno);
		int likeNum = service.selectlikeNum(bno2);
		log.info(bno);
		log.info(likeNum);
	

		return likeNum;
	}
	
	@GetMapping("/likedelete")
	public D_likeNumDTO likedelete(@RequestParam HashMap<String,String> paramMap){
		
		int result=0;
		
		D_likewhotfVO vo = new D_likewhotfVO();
		D_likeNumDTO dto3 = new D_likeNumDTO();
		
		String bno = paramMap.get("bno");
		String who = paramMap.get("who");
		String tf = paramMap.get("tf");
		
		int bno2=Integer.parseInt(bno);
		int tf2=Integer.parseInt(tf);
		
		
		vo.setBno(bno2);
		vo.setLikewho(who);
		vo.setLiketf(tf2);
		
		result=service.likedelete(vo);
		
		int likeNum = service.selectlikeNum(bno2);
		
		dto3.setBno(bno2);
		dto3.setCount(likeNum);
		/* String likeNum2 = Integer.toString(likeNum); */
		

		return dto3;
	}
	
	@GetMapping("/alllike")
	public List<D_likelistwhoDTO>alllike(@RequestParam HashMap<String,String> paramMap) {
		
		D_likelistwhoDTO dto = new D_likelistwhoDTO();
		List<D_likelistwhoDTO>likewholist = new ArrayList<D_likelistwhoDTO>();
		
		dto.setCount(3);
		String bno = paramMap.get("bno");	
		int bno2=Integer.parseInt(bno);
		likewholist = service.alllikewho(bno2);
		
		
		
		if(likewholist.isEmpty()) {
			
			dto.setLikewho("0");
			likewholist.add(dto);
			log.info(dto);
			return likewholist;	

		}
		else
		{
			log.info(likewholist);
			return likewholist;
			
		}
		
	}
	
}


