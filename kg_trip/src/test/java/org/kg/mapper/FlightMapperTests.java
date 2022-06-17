package org.kg.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_reservationVO;
import org.kg.domain.K_seatVO;
import org.kg.domain.testVO;
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
//	public void getListWithPaging() {
//		List<testVO> list = mapper.reservationList();
//		log.info("내가 출력한 결과물 : " + list);
//	}
	
//	@Test
//	public void Test0() {
//		K_flightVO vo = new K_flightVO();
//		vo.setFlight_name("TEST");
//		vo.setFlight_people(99);
//		log.info("내가 출력한 결과물 : " + mapper.flightInsert(vo));
//	}
	
}
