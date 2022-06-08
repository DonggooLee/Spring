package org.ddongq.service;

import java.util.List;

import org.ddongq.domain.Criteria;
import org.ddongq.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo);
	public ReplyVO get(long rno);
	public int modify(ReplyVO vo);
	public int remove(long rno);
	public List<ReplyVO> getList(Criteria cri, long rno);
	
}
