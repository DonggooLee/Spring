package org.kg.mapper;

import java.util.List;

import org.kg.domain.E_FreqVO;
import org.kg.domain.E_PageDTO;


public interface E_FreqMapper {
	
	// 리스트 (매퍼테스트용)
	public List<E_FreqVO> getFreqList(E_PageDTO vo);
	
	// 페이징 처리 전체 리스트
	public List<E_FreqVO> getFreqListWithPaging(E_PageDTO vo);
	
	// 총 게시글 수
	public int getFreqTotalCount(E_PageDTO vo);
	
	// view
	public E_FreqVO view(long fq_num);
	
	// insert
	public void insert(E_FreqVO vo);

	// delete
	public int remove(long fq_num);

	// update
	public int update(E_FreqVO vo);

	// update
	public int makeFileNullUpdate(E_FreqVO vo);

}
