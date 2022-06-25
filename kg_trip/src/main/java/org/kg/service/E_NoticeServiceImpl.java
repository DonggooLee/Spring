package org.kg.service;

import java.util.List;

import org.kg.domain.Criteria;
import org.kg.domain.E_NoticeVO;
import org.kg.domain.PageDTO;
import org.kg.mapper.E_NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class E_NoticeServiceImpl implements E_NoticeService {

	@Setter(onMethod_ = @Autowired)
	private E_NoticeMapper mapper;
	
	public E_NoticeServiceImpl() {}

	@Override
	public List<E_NoticeVO> getListWithPaging(Criteria cri) {

		log.info("getListWithPaging..." + cri);

		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal() {

		return mapper.getTotalCount();
	}

	@Override
	public void insert(E_NoticeVO vo) {
		log.info("삽입중");
		mapper.insert(vo);
	}

	@Override
	public E_NoticeVO view(long n_num) {
		log.info("view 뽑는 중!");
		return mapper.view(n_num);
	}

	@Override
	public boolean remove(long n_num) {
		log.info("delete 중. n_num은? " + n_num);
		
		return mapper.remove(n_num) == 1;
	}

	@Override
	public boolean modify(E_NoticeVO vo) {
		log.info("modify..." + vo);
		int result = mapper.update(vo);
		
		if(result == 1) {
			return true;
		}else {
			return false;
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
}
