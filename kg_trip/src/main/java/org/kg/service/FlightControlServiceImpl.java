package org.kg.service;

import org.kg.domain.K_flightVO;
import org.kg.domain.K_seatVO;
import org.kg.mapper.FlightMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FlightControlServiceImpl implements FlightControlService {

	@Setter(onMethod_ = @Autowired)
	FlightMapper mapper;
	
	@Override
	public int flightInsert_(K_flightVO vo) {
		return mapper.flightInsert(vo);
	}

	@Override
	public int seatInsert_(K_seatVO vo) {
		return mapper.seatInsert(vo);
	}
	
}
