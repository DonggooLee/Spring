package org.ddongq.controller;

import java.util.List;

import org.ddongq.domain.Criteria;
import org.ddongq.domain.ReplyVO;
import org.ddongq.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/replies")
@AllArgsConstructor
public class ReplyController {

	/*
	 * 동작에 따른 url 방법 (http 전송방식)
	 * 1. 등록 - /replies/new - POST
	 * 2. 조회 - /replies/:rno - GET
	 * 3. 삭제 - /replies/:rno - DELETE
	 * 4. 수정 - /replies/:rno - PUT or PATCH
	 * 5. 페이지 - /replies/pages/:rno/:page - GET
	 * 
	 * == REST 방식으로 설계할 땐 PK 기준으로 작성하는 것이 좋다. PK만으로 CRUD 가능하기 때문
	 * == 다만 댓글목록은 PK 만으론 안되고 BNO와 페이지 번호가 필요
	 */
	
	private ReplyService service;

	// 1. 등록
	// consumes = 수신할 데이터 포맷
	// produces = 출력할 데이터 포맷 
	@PostMapping(value = "/new", 
			consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	// MediaType.TEXT_PLAIN_VALUE = String 타입 
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		
		log.info("ReplyVO........." + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply Insert Count........." + insertCount);
		
		return insertCount == 1 ?
				// 성공하면  success 문자열과 정상코드를 보내준다
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	// 2. 조회
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") long bno,
			@PathVariable("page") int page){
		
		log.info("getList.......");
		
		Criteria cri = new Criteria(page,10);
		
		log.info(cri);
		
		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
	}
	
	// 3. 댓글 하나 조회
	@GetMapping(value = "/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		log.info("get... : " + rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	// 4. 댓글 삭제
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		log.info("remove : " + rno);
		return service.remove(rno) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 5. 댓글 수정
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, 
			value = "/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno){
		vo.setRno(rno);
		log.info("rno : " + rno);
		log.info("modify : " + vo);
		
		int modifyCount = service.modify(vo);
		
		log.info("Reply MODIFY COUNT : " + modifyCount);
		
		return modifyCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
