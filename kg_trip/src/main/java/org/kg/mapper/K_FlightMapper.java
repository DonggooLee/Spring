package org.kg.mapper;

import java.util.List;

import org.kg.domain.K_getScheduleDTO;
import org.kg.domain.K_getSeatVO;
import org.kg.domain.K_airportVO;
import org.kg.domain.K_bookInfo;
import org.kg.domain.K_checkSeatVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_getInfoDTO;
import org.kg.domain.K_getReservationIdxDTO;
import org.kg.domain.K_getResrvationInfoVO;
import org.kg.domain.K_inputScheduleDTO;
import org.kg.domain.K_insertScheduleDTO;
import org.kg.domain.K_scheduleDTO;

public interface K_FlightMapper {
	
	// 공항 조회
	public List<K_airportVO> airportList();
	
	// 항공편 조회
	public List<K_flightVO> flightList(String c_aircode);
	
	// 항공일정 추가
	public int insertSchedule(K_insertScheduleDTO insertSch);
	
	// 일정조회 : 이코노미 좌석 (비행일자순)
	public List<K_getScheduleDTO> searchScheduleEco(K_inputScheduleDTO inputSch);
	
	// 일정조회 : 이코노미 좌석 (최저가순)
	public List<K_getScheduleDTO> searchScheduleEcoPrice(K_inputScheduleDTO inputSch);
	
	// 일정조회 : 비즈니스 좌석 (비행일자순)
	public List<K_getScheduleDTO> searchSchedulBis(K_inputScheduleDTO inputSch);
	
	// 일정조회 : 비즈니스 좌석 (최저가순)
	public List<K_getScheduleDTO> searchSchedulBisPrice(K_inputScheduleDTO inputSch);
	
	// 일정조회 : 퍼스트 좌석 (비행일자순)
	public List<K_getScheduleDTO> searchScheduleFir(K_inputScheduleDTO inputSch);
	
	// 일정조회 : 퍼스트 좌석 (최저가순)
	public List<K_getScheduleDTO> searchScheduleFirPrice(K_inputScheduleDTO inputSch);
	
	// 항공편 일정선택
	public K_getScheduleDTO getSchedule(int date_idx);
	
	// 좌석출력 : 이코노미
	public K_getSeatVO getSeatEco(int date_idx);
	
	// 좌석출력 : 비즈니스
	public K_getSeatVO getSeatBis(int date_idx);
	
	// 좌석출력 : 퍼스트
	public K_getSeatVO getSeatFir(int date_idx);
	
	// 예약 좌석 조회
	public List<K_checkSeatVO> getReservationSeatList(K_getInfoDTO info);
	
	// 예약하기
	public int insertReservation(K_bookInfo info);
	
	// 예약조회
	public K_getResrvationInfoVO getResrvationInfo(String reservation_idx);
	
	// 예약번호 조회
	public K_getReservationIdxDTO getReservationIdx(K_bookInfo info);
	
	// 항공권 환불
	public int refundReservation(String reservation_idx);
	
	// 항공권 예약 내역 (회원별)
	public List<K_getResrvationInfoVO> getBookingList(int m_idx);
	
	// 항공권 일정 조회
	public List<K_scheduleDTO> scheduleList(String c_aircode);
	
	// 항공편 일정 삭제
	public int deleteSchedule(String date_idx);
	
	// 항공편 수정을 위한 조회
	public K_scheduleDTO getFlight(String date_idx);
	
	// 항공편 수정
	public int updateSchdule(K_insertScheduleDTO input);
	
}
