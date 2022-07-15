package org.kg.service;

import java.util.List;

import org.kg.domain.E_OboVO;
import org.kg.domain.E_PageDTO;
import org.kg.mapper.E_OboMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Repository
public class E_OboServiceImpl implements E_OboService{
	
	@Setter(onMethod_ = @Autowired)
	private E_OboMapper mapper;

	@Override
	public List<E_OboVO> getOboList(E_PageDTO vo) {
		return mapper.getOboList(vo);
	}

	@Override
	public int getOboTotalCount(E_PageDTO vo) {
		return mapper.getOboTotalCount(vo);
	}

	@Override
	public E_OboVO view(long o_num) {
		return mapper.view(o_num);
	}

	@Override
	public void insertOrigin(E_OboVO vo) {
		mapper.insertOrigin(vo);
	}

	@Override
	public void insertRe(E_OboVO vo) {
		mapper.insertRe(vo);
	}

	@Override
	public int remove(long o_num) {
		return mapper.remove(o_num) ;
	}

	@Override
	public int update(E_OboVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int makeFileNullUpdate(long o_num) {
		return mapper.makeFileNullUpdate(o_num);
	}

	
}
