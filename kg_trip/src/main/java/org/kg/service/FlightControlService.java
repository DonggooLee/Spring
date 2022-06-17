package org.kg.service;

import org.kg.domain.K_flightVO;
import org.kg.domain.K_seatVO;

public interface FlightControlService {

	// 항공편 추가
	public int flightInsert_(K_flightVO vo);
	
	// 좌석 추가
	public int seatInsert_(K_seatVO vo);
	
}
