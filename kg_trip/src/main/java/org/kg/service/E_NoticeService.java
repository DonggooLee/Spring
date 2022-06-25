package org.kg.service;

import java.util.List;

import org.kg.domain.Criteria;
import org.kg.domain.E_NoticeVO;

public interface E_NoticeService {
	
	// 전체 글 조회 + 페이징
	public List<E_NoticeVO> getListWithPaging(Criteria cri);
	
	// 총 글 수 카운트
	public int getTotal(); 

	// 공지글 insert
	public void insert(E_NoticeVO vo);

	// 공지 view
	public E_NoticeVO view(long n_num);
	
	// 공지 delete
	public boolean remove (long n_num);
	
	// 공지 update
	public boolean modify(E_NoticeVO vo);

	
	
	
	
	
	

}
