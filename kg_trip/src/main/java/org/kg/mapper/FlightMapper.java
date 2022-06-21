package org.kg.mapper;

import java.util.List;

import org.kg.domain.K_airlineVO;
import org.kg.domain.K_airportVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_scheduleVO;
import org.kg.domain.K_seatVO;
import org.kg.domain.K_inputScheduleDTO;
import org.kg.domain.K_getScheduleVO;

public interface FlightMapper {
	
	// 항공사 추가
	public int airlineInsert(K_airlineVO vo);
	
	// 항공편 추가
	public int flightInsert(K_flightVO vo);
	
	// 좌석 추가
	public int seatInsert(K_seatVO vo);

	// 일정 추가
	public int scheduleInsert(K_scheduleVO vo);
	
	// 항공편 조회
	public List<K_flightVO> flightList();
	
	// 항공사 조회
	public List<K_airlineVO> airlineList();	
	
	// 공항 조회
	public List<K_airportVO> airportList();	
	
	// 일정 조회 : 조건 => 비행일자, 좌석등급
	public List<K_getScheduleVO> scheduleList(K_inputScheduleDTO inputSch);
	
}
