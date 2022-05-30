package org.ddongq.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.ddongq.dto.StudentDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	// @RequestMapping : url-mapping
	// ★ 메소드를 대상으로 하는 어노테이션을 붙인다
	// value = "/" : 컨텍스트 패스를 의미, 서버 : 포트/디폴트패키지
	// method = RequestMethod.GET : get/post 방식
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "member/input";
	}
	
	@RequestMapping(value = "/member/result", method = RequestMethod.POST)
	public String login(@RequestParam("id") String id, @RequestParam("pw") String pw, Model model) {
		// request로 받아서 model 객체에 저장한 후 보낸다
		model.addAttribute("id",id);
		model.addAttribute("pw",pw);
		return "member/output";
	}
	
	// 주소에 http://localhost:8080/controller/a/b/c/d/e 를 입력 시 view01.jsp로 이동가능
	@RequestMapping(value = "/a/b/c/d/e")
	// @RequestMapping("/a/b/c/d/e") // value 생략 가능  but 매개변수가 2개 이상일 때는 생략 XX
	public String goView01(){
		
		// 1. 리턴타입 : 뷰(view)를 리턴하기 때문에 언제나 String을 리턴한다.
		// 2. 메소드명 : goView01은 아무런 의미가 없다 (메소드 끼리 이름만 다르면 된다.)
		// 3. 리턴 : "/view01", "view01"의 차이점은 없다.
		return "/view01";
	}                                 
	
	@RequestMapping(value = "admin/vidw02")
	public String goView02(Model model) {
		
		// Model 클래스
		// 1. request의  attribute 역할을 수행하는 클래스
		// 2. addAttribute("속성명", "값")방식으로 Attribute를 저장
		//  	model.addAttribute : request.setAttribute (model==request)
		// 3. controller가 jsp에게 파라미터를 전달하려면 무조건 model를 사용한다.
		// 		(spring 2 버전에는 ModelandView를 사용했다.)
		// 4. Model model을 매개변수로 선언한다
		
		model.addAttribute("id","admin");
		model.addAttribute("pw",1234);
		return "/admin/view02";
	}
	
	@RequestMapping("index")
	public String goIndex() {
		return "index";
	}
	
	@RequestMapping(value = "v01")
	public String goResult1(StudentDto sDto, Model model) {
		model.addAttribute("sDto",sDto);
		return "result";
	}
	
	@RequestMapping(value = "v02")
	public String goResult2(@ModelAttribute("s") StudentDto dto) {
		return "result";
	}
	
}
