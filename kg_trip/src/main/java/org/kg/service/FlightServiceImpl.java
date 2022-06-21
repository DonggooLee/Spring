package org.kg.service;

import java.util.List;

import org.kg.domain.K_airlineVO;
import org.kg.domain.K_airportVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_scheduleVO;
import org.kg.domain.K_seatVO;
import org.kg.domain.K_inputScheduleDTO;
import org.kg.domain.K_getScheduleVO;
import org.kg.mapper.FlightMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FlightServiceImpl implements FlightService{

	@Setter(onMethod_ = @Autowired)
	FlightMapper mapper;
	
	// 항공사 추가
	@Override
	public int airlineInsert_(K_airlineVO vo) {
		log.info("vo..." + vo);
		return mapper.airlineInsert(vo);
	}
	
	// 항공편 추가
	@Override
	public int flightInsert_(K_flightVO vo) {
		log.info("vo..." + vo);
		return mapper.flightInsert(vo);
	}
	
	// 좌석 추가
	@Override
	public int seatInsert_(K_seatVO vo) {
		log.info("vo..." + vo);
		return mapper.seatInsert(vo);
	}
	
	// 일정 추가
	@Override
	public int scheduleInsert_(K_scheduleVO vo) {
		log.info("vo..."+vo);
		return mapper.scheduleInsert(vo);
	}
	
	// 항공편 조회
	@Override
	public List<K_flightVO> flightList_() {
		return mapper.flightList();
	}

	// 항공사 조회
	@Override
	public List<K_airlineVO> airlineList_() {
		return mapper.airlineList();
	}
	
	// 공항 조회
	@Override
	public List<K_airportVO> airportList_() {
		return mapper.airportList();
	}

	// 일정 조회
	@Override
	public List<K_getScheduleVO> scheduleList_(K_inputScheduleDTO inputSch) {
		return mapper.scheduleList(inputSch);
	}
	
}
