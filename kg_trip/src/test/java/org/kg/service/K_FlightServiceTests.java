package org.kg.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kg.domain.K_inputScheduleDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class K_FlightServiceTests {

	@Setter(onMethod_ = @Autowired)
	private K_FlightService service;
	
//	@Test
//	public void test() {
//		K_inputScheduleDTO inputSch = new K_inputScheduleDTO();
//		inputSch.setAp_name_d("인천(ICN)");
//		inputSch.setAp_name_a("제주(CJU)");
//		inputSch.setStart_date("2022-07-28");
//		log.info("테스트 결과 : " + service.searchScheduleEcoPrice_(inputSch));
//	}	
	
}
