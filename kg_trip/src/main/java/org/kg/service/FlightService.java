package org.kg.service;

import java.util.List;

import org.kg.domain.K_flightVO;
import org.kg.domain.testVO;

public interface FlightService {
	
	// 항공권 예매 조회
	public List<testVO> reservationList_();
		
}
