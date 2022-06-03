package org.ddongq.service;

import java.util.List;

import org.ddongq.domain.Criteria;
import org.ddongq.domain.ReplyVO;
import org.ddongq.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService{
	
		@Setter(onMethod_ = @Autowired)
		private ReplyMapper mapper;

		@Override
		public int register(ReplyVO vo) {
			log.info("register...." + vo);
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

		@Override
		public int remove(long bno) {
			log.info("remove...." + bno);
			return mapper.delete(bno);
		}

		@Override
		public List<ReplyVO> getList(Criteria cri, long bno) {
			log.info("getList...." + bno);
			return mapper.getListWithPaging(cri, bno);
		}

}
