package org.ddongq.service;

import java.util.List;

import org.ddongq.domain.BoardVO;

public interface BoardService {
	
	public List<BoardVO> getList();
	public BoardVO get(long bno);
	public void register(BoardVO vo);
	public boolean modify(BoardVO vo);
	public boolean remove(long bno);
	
}
