package org.kg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kg.domain.K_airlineVO;
import org.kg.domain.K_airportVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_scheduleVO;
import org.kg.domain.K_seatVO;
import org.kg.domain.K_choiceSeatVO;
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
	
	// 일정 선택 : 조건 => 일정번호, 좌석등급
	public K_getScheduleVO getSchedule(@Param("date_idx") int date_idx, @Param("seat_grade") String seat_grade);
	
	// 좌석 조회 : 조건 => 일정번호, 항공편명
	public List<K_choiceSeatVO> choiceSeat(@Param("date_idx") int date_idx, @Param("flight_name") String flight_name);
	
	// 좌석 조회 : 조건 => 좌석번호
	public K_seatVO getSeat(@Param("seat_idx") int seat_idx);
	
}
