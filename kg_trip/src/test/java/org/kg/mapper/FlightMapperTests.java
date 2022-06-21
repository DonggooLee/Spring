package org.kg.mapper;

import java.sql.Date;

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
public class FlightMapperTests {

	@Setter(onMethod_ = @Autowired)
	private FlightMapper mapper;
	
//	@Test
//	public void flightInsert() {
//		K_flightVO vo = new K_flightVO();
//		vo.setFlight_name("TEST_06/20");
//		vo.setFlight_people(999);
//		log.info("내가 출력한 결과물 : " + mapper.flightInsert(vo));
//	}
	
//	@Test
//	public void test() {
//		String start_date = "2022-06-21";
//		log.info("내가 출력한 결과물 : " + mapper.getSchedule(start_date));
//	}
	
}
