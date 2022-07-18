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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/text/")
public class D_maincontroller {
	
	
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	D_boardService service;
	
	@GetMapping("/input")
	public String test() {
		
		return "board/test";
	}
	
	@RequestMapping(value="/boardlist", method=RequestMethod.GET)
	public String goList(@RequestParam HashMap<String,String> paramMap, Model model)
	{
		
		int tf=0;
		String bno2 = paramMap.get("bno");
		String writer = paramMap.get("writer");
		
		
		int bno = Integer.parseInt(bno2);
		
		log.info(bno);
		log.info(writer);
		
		
		D_BoardVO vo = service.selectCard(bno);
		
		 D_likeDTO dto = service.selectlike(bno);
		  
		 log.info(dto.getLiketf());
		  
		 if(dto.getLiketf()==1) { tf=1; } else { tf=0; }
		 
		
		 log.info("tf"+tf);
		model.addAttribute("vo", vo);
		model.addAttribute("tf", tf);
		
		return "board/heart";
	}
	
	//카드 정보 삽입
	@Transactional
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String getGoodsRegister(D_BoardVO vo, D_ImageVO vo2, HttpSession session) throws Exception {
		log.info("get goods register");
		
		log.info(vo2.getUploadPath());
		log.info(vo.getContent());
		log.info(vo2.getFileName());
		log.info(vo2.getUuid());
		
		log.info("테스트");
		
		service.insertContent(vo);
		vo2.setBno(vo.getBno());
		service.insertImg(vo2);
		
		
		
		return "redirect:/text/list";
	
	}
	
    @ResponseBody
	@RequestMapping(value = "/listt", method = RequestMethod.POST)
	public List<D_likeNumDTO> testJson(Model model) throws Exception {
		
		
    	List<D_likeNumDTO>like = service.likeNum();  
    	model.addAttribute("like", like);
		
		return like;
	}
	
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String getGoodsList(Model model) throws Exception {
		log.info("get goods list");
		
		
		
		List<D_BoardVO> list = service.contentlist();  // GoodsVO형태의 List형 변수 list 선언
		List<D_ImageVO> list2 = service.imageData();
		List<D_likeNumDTO>like = service.likeNum();
		List<D_likewhotfVO>likevo = service.likewhotf();
		
		model.addAttribute("list1", list);  // 변수 list의 값을 list 세션에 부여
		model.addAttribute("list2", list2);
		model.addAttribute("like", like);
		model.addAttribute("likevo", likevo);
		
		log.info(likevo);
		
		return "board/list";
	}

	/* 첨부 파일 업로드 */
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public  ResponseEntity<D_ImageVO>uploadAjaxActionPOST(MultipartFile uploadFile, HttpSession session) {
		
		String uploadFolder = "C:\\upload";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		String datePath = str.replace("-", File.separator);
		
		File uploadPath = new File(uploadFolder, datePath);
		
		String uuid = UUID.randomUUID().toString();
		
		D_ImageVO vo = new D_ImageVO();
		
		vo.setUploadPath(datePath);
		vo.setUuid(uuid);
		
		/* 파일 이름 */
		String uploadFileName = uploadFile.getOriginalFilename();	
		vo.setFileName(uploadFileName);
		/*파일 이름 uuid 합치기*/
		uploadFileName = uuid + "_" + uploadFileName;
		/* 파일 위치, 파일 이름을 합친 File 객체 */
		File saveFile = new File(uploadPath, uploadFileName);
		/* 파일 저장 */
		try {
			uploadFile.transferTo(saveFile);
			
			File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
			
			BufferedImage bo_image = ImageIO.read(saveFile);
			
			double ratio = 3;
			/*넓이 높이*/
			int width = /*(int) (bo_image.getWidth() / ratio)*/384;
			int height = /*(int) (bo_image.getHeight() / ratio)*/264 ;
			
			BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
							
			Graphics2D graphic = bt_image.createGraphics();
			
			graphic.drawImage(bo_image, 0, 0,width,height, null);
				
			ImageIO.write(bt_image, "jpg", thumbnailFile);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		log.info("uploadAjaxActionPOST..........");
		log.info("파일 이름 : " + vo.getFileName());
		log.info("파일 이름 : " + uploadFile.getOriginalFilename());
		log.info("파일 타입 : " + uploadFile.getContentType());
		log.info("파일 크기 : " + uploadFile.getSize());
		
		

		
		ResponseEntity<D_ImageVO> result = new ResponseEntity<D_ImageVO>(vo, HttpStatus.OK);
		
		return result;
	}
	
	/*이미지 출력*/
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){
		
		log.info("getimage()"+fileName);
		
		File file = new File("c:\\upload\\" + fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
		
		
	
	}
	
	//이미지 삭제
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		File file = null;
		
		try {
			
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			String originFileName = file.getAbsolutePath().replace("s_", "");
			
			log.info("originFileName : " + originFileName);
			
			file = new File(originFileName);
			
			file.delete();
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
			
		}
	
		log.info("deleteFile........" + fileName);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
}


