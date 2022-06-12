package org.ddongq.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class SampleServiceTests {

	@Setter(onMethod_ = @Autowired)
	private SampleService service;
	
//	@Test
//	public void testClass() {
//		log.info("service : " + service);
//		log.info("service.getClass().getName() : " + service.getClass().getName());
//	}
	
//	@Test
//	public void testAdd() throws Exception {
//		// 위에서 예외를 던진 이유는 SampleService 에서 예외처리를 호출한 쪽으로 던지고 있기 때문 !
//		log.info("테스트 결과 : " + service.doAdd("123", "555"));
//	}
	
	@Test
	public void testAddError() throws Exception{
		log.info("테스트 결과 : " + service.doAdd("123", "asd"));
	}
	
}
