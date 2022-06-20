package org.kg.service;

import java.util.List;

import org.kg.domain.K_airlineVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_seatVO;

public interface FlightService {
	
	// 항공사 추가
	public int airlineInsert_(K_airlineVO vo);

	// 항공편 추가
	public int flightInsert_(K_flightVO vo);
	
	// 항공편 조회
	public List<K_flightVO> flightList_();
	
	// 좌석 추가
	public int seatInsert_(K_seatVO vo);
	
}
