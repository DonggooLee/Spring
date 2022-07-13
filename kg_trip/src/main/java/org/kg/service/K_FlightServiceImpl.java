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
import org.kg.domain.K_scheduleDTO;
import org.kg.mapper.K_FlightMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class K_FlightServiceImpl implements K_FlightService{

	@Setter(onMethod_ = @Autowired)
	K_FlightMapper mapper;
	
	// 공항조회
	@Override
	public List<K_airportVO> airportList_() {
		return mapper.airportList();
	}
	
	// 항공편 조회 
	@Override
	public List<K_flightVO> flightList_(String c_aircode) {
		return mapper.flightList(c_aircode);
	}
	
	// 항공일정 추가
	@Override
	public int insertSchedule_(K_insertScheduleDTO insertSch) {
		return mapper.insertSchedule(insertSch);
	}
	
	// 일정조회 (이코노미 / 비행일자)
	@Override
	public List<K_getScheduleDTO> searchScheduleEco_(K_inputScheduleDTO inputSch) {
		return mapper.searchScheduleEco(inputSch);
	}
	
	// 일정조회(이코노미 / 최저가)
	@Override
	public List<K_getScheduleDTO> searchScheduleEcoPrice_(K_inputScheduleDTO inputSch) {
		return mapper.searchScheduleEcoPrice(inputSch);
	}
	
	// 일정조회 (비즈니스 / 비행일자)
	@Override
	public List<K_getScheduleDTO> searchSchedulBis_(K_inputScheduleDTO inputSch) {
		return mapper.searchSchedulBis(inputSch);
	}
	
	// 일정조회(비즈니스 / 최저가)
	@Override
	public List<K_getScheduleDTO> searchSchedulBisPrice_(K_inputScheduleDTO inputSch) {
		return mapper.searchSchedulBisPrice(inputSch);
	}
	
	// 일정조회 (퍼스트 / 비행일자)
	@Override
	public List<K_getScheduleDTO> searchScheduleFir_(K_inputScheduleDTO inputSch) {
		return mapper.searchScheduleFir(inputSch);
	}
	
	// 일정조회(퍼스트 / 최저가)
	@Override
	public List<K_getScheduleDTO> searchScheduleFirPirce_(K_inputScheduleDTO inputSch) {
		return mapper.searchScheduleFirPrice(inputSch);
	}

	// 항공편 일정선택
	@Override
	public K_getScheduleDTO getSchedule_(int date_idx) {
		return mapper.getSchedule(date_idx);
	}
	
	// 좌석출력 : 이코노미
	@Override
	public K_getSeatVO getSeatEco_(int date_idx) {
		return mapper.getSeatEco(date_idx);
	}

	// 좌석출력 : 비즈니스
	@Override
	public K_getSeatVO getSeatBis_(int date_idx) {
		return mapper.getSeatBis(date_idx);
	}

	// 좌석출력 : 퍼스트
	@Override
	public K_getSeatVO getSeatFir_(int date_idx) {
		return mapper.getSeatFir(date_idx);
	}

	// 예약 좌석 조회
	@Override
	public List<K_checkSeatVO> getReservationSeatList_(K_getInfoDTO info) {
		return mapper.getReservationSeatList(info);
	}
	
	// 예약하기
	@Override
	public int insertReservation_(K_bookInfo info) {
		return mapper.insertReservation(info);
	}
	
	// 예약조회
	@Override
	public K_getResrvationInfoVO getResrvationInfo_(String reservation_idx) {
		return mapper.getResrvationInfo(reservation_idx);
	}

	// 예약 번호 조회
	@Override
	public K_getReservationIdxDTO getReservationIdx_(K_bookInfo info) {
		return mapper.getReservationIdx(info);
	}

	// 항공권 환불
	@Override
	public int refundReservation_(String reservation_idx) {
		return mapper.refundReservation(reservation_idx);
	}

	// 항공권 예약 내역 (회원별)
	@Override
	public List<K_getResrvationInfoVO> getBookingList_(int m_idx) {
		return mapper.getBookingList(m_idx);
	}

	// 항공권 일정 조회
	@Override
	public List<K_scheduleDTO> scheduleList_(String c_aircode) {
		return mapper.scheduleList(c_aircode);
	}

	// 항공편 일정 삭제
	@Override
	public int deleteSchedule_(String date_idx) {
		return mapper.deleteSchedule(date_idx);
	}

	// 항공편 수정을 위한 조회
	@Override
	public K_scheduleDTO getFlight_(String date_idx) {
		return mapper.getFlight(date_idx);
	}

	// 항공편 수정
	@Override
	public int updateSchdule_(K_insertScheduleDTO input) {
		return mapper.updateSchdule(input);
	}
	
}
