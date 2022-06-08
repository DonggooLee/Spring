package org.ddongq.service;

import java.util.List;

import org.ddongq.domain.Criteria;
import org.ddongq.domain.ReplyVO;
import org.ddongq.mapper.BoardMapper;
import org.ddongq.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService{
	
		@Setter(onMethod_ = @Autowired)
		private ReplyMapper mapper;
		
		@Setter(onMethod_ = @Autowired)
		private BoardMapper boardMapper;

		@Transactional
		@Override
		public int register(ReplyVO vo) {
			log.info("register...." + vo);
			
			// replycnt 컬럼 값 증가
			boardMapper.updateReplyCnt(vo.getBno(), 1);
			
			return mapper.insert(vo);
		}

		@Override
		public ReplyVO get(long rno) {
			log.info("get...." + rno);
			return mapper.read(rno);
		}

		@Override
		public int modify(ReplyVO vo) {
			log.info("modify...." + vo);
			return mapper.update(vo);
		}

		@Transactional
		@Override
		public int remove(long rno) {
			log.info("remove...." + rno);
			
			// replycnt 컬럼 값 다운
			boardMapper.updateReplyCnt(mapper.read(rno).getBno(), -1);
			
			return mapper.delete(rno);
		}

		@Override
		public List<ReplyVO> getList(Criteria cri, long rno) {
			log.info("getList...." + rno);
			return mapper.getListWithPaging(cri, rno);
		}

}
