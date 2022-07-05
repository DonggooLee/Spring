package org.kg.service;

import java.util.List;

import org.kg.domain.K_getScheduleDTO;
import org.kg.domain.K_getSeatVO;
import org.apache.ibatis.annotations.Param;
import org.kg.domain.K_airportVO;
import org.kg.domain.K_bookInfo;
import org.kg.domain.K_checkSeatVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_getInfoDTO;
import org.kg.domain.K_getReservationIdxDTO;
import org.kg.domain.K_getResrvationInfoVO;
import org.kg.domain.K_inputScheduleDTO;
import org.kg.domain.K_insertScheduleDTO;

public interface K_FlightService {
	
	// 공항조회
	public List<K_airportVO> airportList_();
	
	// 항공편 조회
	public List<K_flightVO> flightList_(String c_aircode);
	
	// 항공일정 추가
	public int insertSchedule_(K_insertScheduleDTO insertSch);

	// 일정조회 (이코노미)
	public List<K_getScheduleDTO> searchScheduleEco_(K_inputScheduleDTO inputSch);
	
	// 일정조회 (비즈니스)
	public List<K_getScheduleDTO> searchSchedulBis_(K_inputScheduleDTO inputSch);
	
	// 일정조회 (퍼스트)
	public List<K_getScheduleDTO> searchScheduleFir_(K_inputScheduleDTO inputSch);
	
	// 좌석출력 : 이코노미 
	public K_getSeatVO getSeatEco_(int date_idx);
	
	// 좌석출력 : 비즈니스
	public K_getSeatVO getSeatBis_(int date_idx);
	
	// 좌석출력 : 퍼스트
	public K_getSeatVO getSeatFir_(int date_idx);
	
	// 일반회원 : 일정선택
	public K_getScheduleDTO getSchedule_(@Param("date_idx") int date_idx);
	
	// 예약하기
	public int insertReservation_(K_bookInfo info);
	
	// 예약 좌석 조회
	public List<K_checkSeatVO> getReservationSeatList_(K_getInfoDTO info);
	
	// 예약조회
	public K_getResrvationInfoVO getResrvationInfo_(String reservation_idx);
	
	// 예약번호 조회
	public K_getReservationIdxDTO getReservationIdx_(K_bookInfo info);
	
	// 항공권 환불
	public int refundReservation_(String reservation_idx);
	
	// 항공권 예약 내역 (회원별)
	public List<K_getResrvationInfoVO> getBookingList_(int m_idx);
	
}
