package org.kg.mapper;

import java.util.List;

import org.kg.domain.K_flightVO;
import org.kg.domain.K_seatVO;
import org.kg.domain.testVO;

public interface FlightMapper {

	// 항공편 추가
	public int flightInsert(K_flightVO vo);
	
	// 좌석 추가
	public int seatInsert(K_seatVO vo);
	
	// 항공권 예매 조회
	public List<testVO> reservationList();
	
}
