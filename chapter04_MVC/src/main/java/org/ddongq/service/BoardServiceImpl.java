package org.ddongq.service;

import java.util.List;

import org.ddongq.domain.BoardVO;
import org.ddongq.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements BoardService{
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	public BoardServiceImpl() {}
	
	@Override
	public List<BoardVO> getList() {
		log.info("getList....");
		return mapper.getList();
	}

	@Override
	public BoardVO get(long bno) {
		log.info("get...." + bno);
		return mapper.read(bno);
	}

	@Override
	public void register(BoardVO vo) {
		log.info("register...." + vo);
		mapper.insert(vo);
	}

	@Override
	public boolean modify(BoardVO vo) {
		log.info("modify...." + vo);
		int result = mapper.update(vo);
		if(result == 1) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean remove(long bno) {
		log.info("remove...." + bno);
		return mapper.delete(bno) == 1;
	}
	
}
