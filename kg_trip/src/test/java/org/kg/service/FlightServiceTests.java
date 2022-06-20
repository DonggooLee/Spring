package org.kg.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kg.domain.K_flightVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class FlightServiceTests {

	@Setter(onMethod_ = @Autowired)
	private FlightService service;
	
//	@Test
//	public void testInsert() {
//		K_flightVO vo = new K_flightVO();
//		vo.setFlight_name("ttt");
//		vo.setFlight_people(22);
//		int result = service.flightInsert_(vo);
//		log.info("내가 출력한 결과물 : " + result);
//	}
	
//	@Test
//	public void test() {
//		log.info("내가 출력한 결과물 : " + service.airlineList_());
//	}
	
}
