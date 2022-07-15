package org.kg.mapper;

import java.util.List;

import org.kg.domain.E_FreqVO;
import org.kg.domain.E_OboVO;
import org.kg.domain.E_PageDTO;

public interface E_OboMapper {
	
	// 리스트 (매퍼테스트용)
	public List<E_OboVO> getOboList(E_PageDTO vo);
	
	// 총 게시글 수
	public int getOboTotalCount(E_PageDTO vo);

	// view
	public E_OboVO view(long o_num);
	
	// insert 원글
	public void insertOrigin(E_OboVO vo);

	// insert 답글
	public void insertRe(E_OboVO vo);
	
	// remove
	public int remove(long o_num);
	
	// update
	public int update(E_OboVO vo);

	// update
	public int makeFileNullUpdate(long o_num);
	
}
