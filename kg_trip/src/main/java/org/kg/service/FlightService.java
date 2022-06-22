package org.kg.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kg.domain.K_airlineVO;
import org.kg.domain.K_airportVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_scheduleVO;
import org.kg.domain.K_seatVO;
import org.kg.domain.test;
import org.kg.domain.K_inputScheduleDTO;
import org.kg.domain.K_getScheduleVO;

public interface FlightService {
	
	// 항공사 추가
	public int airlineInsert_(K_airlineVO vo);

	// 항공편 추가
	public int flightInsert_(K_flightVO vo);
	
	// 좌석 추가
	public int seatInsert_(K_seatVO vo);
	
	// 일정 추가
	public int scheduleInsert_(K_scheduleVO vo);
	
	// 항공편 조회
	public List<K_flightVO> flightList_();
	
	// 항공사 조회
	public List<K_airlineVO> airlineList_();
	
	// 공항 조회
	public List<K_airportVO> airportList_();	
	
	// 일정 조회 : 조건 => 비행일자, 좌석등급
	public List<K_getScheduleVO> scheduleList_(K_inputScheduleDTO inputSch);
	
	// 일정 조회 : 조건 => 일정번호, 좌석등급
	public K_getScheduleVO getSchedule_(@Param("date_idx") int date_idx, @Param("seat_grade") String seat_grade);

	// 좌석 조회
	public List<test> choiceSeat_(@Param("date_idx") int date_idx, @Param("flight_name") String flight_name);
	
}
