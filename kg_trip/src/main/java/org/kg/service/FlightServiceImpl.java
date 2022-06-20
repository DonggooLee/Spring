package org.kg.service;

import java.util.List;

import org.kg.domain.K_airlineVO;
import org.kg.domain.K_flightVO;
import org.kg.domain.K_seatVO;
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

	// 항공편 조회
	@Override
	public List<K_flightVO> flightList() {
		return mapper.flightList();
	}
	
	// 좌석 추가
	@Override
	public int seatInsert_(K_seatVO vo) {
		log.info("vo..." + vo);
		return mapper.seatInsert(vo);
	}
	
}
