package org.ddongq.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sample")  // 경로 구분짖기위한 용도로 많이 사용된다.
public class SampleController {

	@GetMapping("/ex01")	// 이런건 get 방식으로만 보내야지만 탈 수 있다.
	public String sample01() {

		return "sample/sample";
		
	}
	
}
