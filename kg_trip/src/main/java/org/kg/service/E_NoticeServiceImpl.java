package org.kg.service;

import java.util.List;

import org.kg.domain.E_NoticeVO;
import org.kg.domain.E_PageDTO;
import org.kg.mapper.E_NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Repository
public class E_NoticeServiceImpl implements E_NoticeService {

	@Setter(onMethod_ = @Autowired)
	private E_NoticeMapper mapper;
	
	public E_NoticeServiceImpl() {}
	
	// 0627 페이징 처리한 E_list.jsp 뽑기
	@Override
	public List<E_NoticeVO> getListWithPaging(E_PageDTO vo) {
		return mapper.getListWithPaging(vo);
	}

	/* 주석처리 0627
	@Override
	public List<E_NoticeVO> getListWithPaging(Criteria cri) {
		log.info("getListWithPaging..." + cri);
		return mapper.getListWithPaging(cri);
	}
	*/

	@Override
	public int getTotal(E_PageDTO dto) {

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
