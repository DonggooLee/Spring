package org.ddongq.controller;

import org.ddongq.domain.SampleVO;
import org.ddongq.domain.Ticket;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/sample")
@RestController 				// 데이터 전달용도로 많이 사용된다.
public class SampleController {

	// produces => 출력할 데이터 포맷
	@GetMapping(value = "/getText", produces = "text/plain; charset=utf-8")
	private String getText() {
		log.info("Mime Type : " + MediaType.TEXT_PLAIN_VALUE);
		// 기존 jsp 파일의 이름이 아닌 순수 데이터를 전달
		return "안녕하세요";
	}
	
	
	@GetMapping(value = "/getSample", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public SampleVO getSample() {
		return new SampleVO(112,"스타","로드");
	}
	
	
	@GetMapping(value = "/check", params = {"height", "weight"})
	private ResponseEntity<SampleVO> check(Double height, Double weight) {
		// Rest 방식으로 호출하는 경우에는 화면이 아닌 데이터 자체를 전송하는 방식으로 처리되기 때문에
		// 데이터를 요청하는 쪽에서는 정상적인 데이터인지, 비정상적인 데이터인지를 구분할 수 있는 확실한 방법을 제공해야 함
		// ResponseEntity는 데이터와 함께  HTTP 헤더의 상태 메세지등을 같이 전달하는 용도로 사용
		// HTTP의 상태 코드와 에러 메시지등을 함께 전달할 수 있기 때문에 받는 입장에서는 확실하게 결과를 알 수 있다.
		SampleVO vo = new SampleVO(0, ""+height, ""+weight);	// Double => String
		ResponseEntity<SampleVO> result = null;
		if(height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		}else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		return result;
	}
	
	
	/*
	 * {}에 적힌 부분을 변수로 처리가능(rest에서 주로 사용)
	 * @PathVariable 사용이유 : 파라미터로 데이터 전달을 간단하게 바꾸기 위해
	 * @PathVariable : product/bags/1234
	 * 기존에 변수를 전달받는 방법 : product?cat=bags&pid=1234
	 */
	@GetMapping("/product/{cat}/{pid}")
    public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") int pid) {
		return new String[] {"category : " + cat, "productid : " + pid};
    }
	
	
	/*
	 * http 요청의  body 부분을 java 객체로 받을 수 있게 해주는 어노테이션. 
	 * 주로 json을 받을 때 활용. @RequestBody와 함께 사용
	 * get 메소드 요청  => HTTP body 에 요청이 전달되는 것이 아니라
	 * URL의 파라미터로 전달되는 형식이라서 해당 어노테이션(getMapping)을 사용할 수 없음.
	 * 즉,@RequestBody가 말 그대로 요청한 내용을 처리하기 때문에 일반적인 파라미터 전달 방식을 사용할 수 없음
	 */
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert...." + ticket );
		return ticket;
	}
	
}
