package org.kg.service;

import java.util.List;

import org.kg.domain.E_FreqVO;
import org.kg.domain.E_PageDTO;

public interface E_FreqService {

	public List<E_FreqVO> getFreqListWithPaging(E_PageDTO vo);
	
	// 총 게시글 수
	public int getFreqTotalCount(E_PageDTO vo);
	
	// view
	public E_FreqVO view(long fq_num);

	// insert
	public void insert(E_FreqVO vo);
	
	// delete
	public boolean remove(long fq_num);		
	
	// update
	public boolean modify(E_FreqVO vo);

	// makeFileNullUpdate
	public boolean makeFileNullUpdate(E_FreqVO vo);
}
