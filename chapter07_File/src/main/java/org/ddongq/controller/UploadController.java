package org.ddongq.controller;

import java.io.File;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.ddongq.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class UploadController {

		@GetMapping("/uploadForm")
		public String uploadForm() {
			log.info("upload form");
			return "/uploadForm";
		}
		
		/*
		 * MultipartFile의 메소드
		 * String getName() 			=> 파라미터의 이름 <input> 태그의 이름
		 * String getOriginalFilename() => 업로드 되는 파일의 이름
		 * boolean isEmpty()			=> 파일이 존재하지 않는 경우 true
		 * long getSize()				=> 업로드 파일의 크기
		 * byte[] getBytes()			=> byte[]로 파일 데이터 변환
		 * InputStream getInputStream() => 파일데이터와 연결된 InputStream 반환
		 * transferTo(File file)		=> 파일저장
		 */
		
		@PostMapping("/uploadFormAction")
		public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
			
			// 업로드 파일이 여러개 일 수 있기 때문에 포문 사용
			for(MultipartFile multipartFile : uploadFile) {
				
				String uploadFolder = "C:\\upload";
				
				log.info("================================");
				log.info("Upload File Name : " + multipartFile.getOriginalFilename());
				log.info("Upload File Size : " + multipartFile.getSize());
				
				File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
				
				try {
					multipartFile.transferTo(saveFile);
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				
			}
		}
		
		/*====================================================================================*/
		
		@GetMapping("/uploadAjax")
		public String uploadAjax() {
			log.info("upload ajax");
			return "/uploadAjax";
		}
		
		@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
			
			log.info("uploadAjaxAction post.........");
			
			List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
			String uploadFolder = "C:\\upload";
			
			// make folder
			File uploadpath = new File(uploadFolder, getFolder());
			log.info("upload path : " + uploadpath);
			
			// folder가 존재하지 않는 다면 폴더 생성
			if(!uploadpath.exists()) {
				uploadpath.mkdirs();
			}
			
			// make yyyy/MM/dd folder
			for(MultipartFile multipartFile : uploadFile) {
				
				AttachFileDTO attachDto = new AttachFileDTO();
				String uploadFileName = multipartFile.getOriginalFilename();
				// Dto 에 넣을 때는 굳이 uuid를 붙일 필요 없다
				attachDto.setFileName(uploadFileName);
				// UUID 클래스 랜덤값 생성 (동일한 이름의 파일인 경우 랜덤한 값을 _ 앞에 붙여주기 위함)
				UUID uuid = UUID.randomUUID();
				uploadFileName = uuid.toString() + "_" + uploadFileName;
				
				try {
					// File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
					File saveFile = new File(uploadpath, uploadFileName);
					// transferTo : 파일저장
					multipartFile.transferTo(saveFile);
					attachDto.setUuid(uuid.toString());
					attachDto.setUploadPath(getFolder());
					list.add(attachDto);
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				
			}
			
			return new ResponseEntity<>(list, HttpStatus.OK);
			
		}
		
		private String getFolder() {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			String str = sdf.format(date);
			// separator : 구분자
			return str.replace("-", File.separator);
		}
		
		// 파일 다운받을 때  => 매개변수로 던질땐 /download?fileName=폴더에있는 파일명.확장자 붙이면된다
		@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
		@ResponseBody
		public ResponseEntity<Resource> downloadFile(String fileName){
			
			log.info("download file : " + fileName);
			
			Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
			
			log.info("resource : " + resource);
			
			String resourceName = resource.getFilename();
			log.info("resourceName : " + resourceName);
			
			String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
			log.info("resourceOriginalName : " + resourceOriginalName);
			
			// HTTP헤더는 클라이언트와 서버가 요청 또는 응답으로 부가적인 정보를 전송을 할 수 있게 한다.
			HttpHeaders headers = new HttpHeaders();
			
			try {
				headers.add("Content-Disposition", "attachment; filename=" + 
			               new String(resourceOriginalName.getBytes("utf-8"),"ISO-8859-1"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
			
		}
		
		@PostMapping("/deleteFile")
		@ResponseBody
		public ResponseEntity<String> deleteFile(String fileName){
			
			// fileName 에 담긴값을 사용하기 위해서는 decoder를 사용
			// 로그 찍힌 것을 확인해 보면 특수 문자 등 다양한 문자가 깨져 있는 것을 확인  가능 (172번 줄 log와 비교)
			log.info(" 디코딩 안한 경우 => deleteFile : " + fileName);
			File file;
			try {
				file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "utf-8"));
				log.info(" 디코딩 실행한 경우 => deleteFile : " + URLDecoder.decode(fileName, "utf-8"));
				file.delete();
			} catch (Exception e) {
				e.printStackTrace();
				// 파일 삭제 실패시 NOT_FOUND 코드를 보내준다
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			return new ResponseEntity<>("Delted", HttpStatus.OK);
			
		}
		
}
