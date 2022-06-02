package org.ddongq.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@WebAppConfiguration
public class BoardControllerTests {

	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;

	private MockMvc mockMvc;	// 가짜  Mvc를 이용할 수 있게끔 해준다. 가상 브라우저, url을 사용.

	@Before						// 어떤 객체가 실행되기 전에 실행되는 것을 의미
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception{
		log.info(
				"내가 테스트한 결과 : " +
					mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap()
				);
	}
	
	/*
	@Test
	public void testGet() throws Exception{
		log.info(
				"내가 테스트한 결과 : " +
					mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
				.param("bno", "1"))
				.andReturn()
				.getModelAndView()
				.getModelMap()
				);
	}
	*/
	
	/*
	@Test
    public void testRegister() throws Exception{
       String result = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
             .param("title", "controller_test_테스트_새글_제목")
             .param("content", "controller_test_테스트_새글_내용")
             .param("writer", "controller_test_user00"))
             .andReturn()
             .getModelAndView()
             .getViewName();
       log.info("내가 테스트한 결과 : " + result);
    }
	*/
	
	/*
	@Test
	public void testRemove() throws Exception{
		String result = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "29"))
				.andReturn()
				.getModelAndView()
				.getViewName();
		log.info("내가 테스트한 결과 : " + result);
	}
	*/
	
	/*
	@Test
	public void testModify() throws Exception{
	     String result = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
	       .param("bno", "33")
	       .param("title", "컨트롤러 수정 테스트 제목")
	       .param("content", "컨트롤러 수정 테스트 내용")
	       .param("writer", "컨트롤러 수정 테스트 작성자"))
	       .andReturn()
	       .getModelAndView()
	       .getViewName();
	     log.info("내가 테스트한 결과 : " + result);
	}
	*/
	
}
