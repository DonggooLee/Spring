package org.kg.mapper;

import java.util.List;

import org.kg.domain.K_airlineVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_seatVO;

public interface FlightMapper {
	
	// 항공사 추가
	public int airlineInsert(K_airlineVO vo);
	
	// 항공편 추가
	public int flightInsert(K_flightVO vo);

	// 항공편 조회
	public List<K_flightVO> flightList();
	
	// 좌석 추가
	public int seatInsert(K_seatVO vo);
	
}
