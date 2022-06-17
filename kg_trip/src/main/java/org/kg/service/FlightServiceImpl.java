package org.kg.service;

import java.util.List;

import org.kg.domain.K_flightVO;
import org.kg.domain.testVO;
import org.kg.mapper.FlightMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FlightServiceImpl implements FlightService {

	@Setter(onMethod_ = @Autowired)
	FlightMapper mapper;
	
	// 항공권 예매 조회
	@Override
	public List<testVO> reservationList_() {
		return mapper.reservationList();
	}

}
