package org.kg.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kg.domain.K_getInfoDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class K_FlightMapperTests {

	@Setter(onMethod_ = @Autowired)
	private K_FlightMapper mapper;
	
	
	// 항공편 테스트
//	@Test
//	public void test() {
//		log.info("테스트 결과 : " + mapper.flightList("AAR"));
//	}
	
	// 좌석 테스트
//	@Test
//	public void test() {
//		log.info("테스트 결과 : " + mapper.getSeatEco(1));
//	}	
	
	// 예약 좌석 테스트
//	@Test
//	public void test() {
//		K_getInfoDTO info = new K_getInfoDTO();
//		info.setDate_idx(2);
//		info.setFlight_name("AA978");
//		log.info("테스트 결과 : " + mapper.getReservationSeatList(info));
//	}	
	
}
