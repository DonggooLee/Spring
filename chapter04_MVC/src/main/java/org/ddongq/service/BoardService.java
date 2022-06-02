package org.ddongq.service;

import java.util.List;

import org.ddongq.domain.BoardVO;
import org.ddongq.domain.Criteria;

public interface BoardService {
	
	public List<BoardVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	public BoardVO get(long bno);
	public void register(BoardVO vo);
	public boolean remove(long bno);
	public boolean modify(BoardVO vo);
	
}
