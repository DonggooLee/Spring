package org.kg.service;

import java.util.List;

import org.kg.domain.E_FreqVO;
import org.kg.domain.E_PageDTO;
import org.kg.mapper.E_FreqMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Repository
public class E_FreqServiceImpl implements E_FreqService{
	
	/*
	 * 	@Setter(onMethod_ = @Autowired)
	private E_NoticeMapper mapper;
	
	public E_NoticeServiceImpl() {}
	 * */
	
	@Setter(onMethod_ = @Autowired)
	private E_FreqMapper mapper;
	
	@Override
	public List<E_FreqVO> getFreqListWithPaging(E_PageDTO vo) {
		return mapper.getFreqListWithPaging(vo);
	}

	@Override
	public int getFreqTotalCount(E_PageDTO vo) {
		return mapper.getFreqTotalCount(vo);
	}

	@Override
	public E_FreqVO view(long fq_num) {
		return mapper.view(fq_num);
	}

	@Override
	public void insert(E_FreqVO vo) {
		mapper.insert(vo);
	}

	@Override
	public boolean remove(long fq_num) {
		return mapper.remove(fq_num) == 1;
	}

	@Override
	public boolean modify(E_FreqVO vo) {
	
		int result = mapper.update(vo);
		
		if(result == 1) {
			return true;
		}else {
			return false;
		}
		
	}

	@Override
	public boolean makeFileNullUpdate(E_FreqVO vo) {
		
		int result = mapper.makeFileNullUpdate(vo);
		
		if(result == 1) {
			return true;
		}else {
			return false;
		}
	}
	
	
}
