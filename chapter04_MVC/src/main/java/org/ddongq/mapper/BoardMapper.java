package org.ddongq.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.ddongq.domain.BoardVO;
import org.ddongq.domain.Criteria;

public interface BoardMapper {
	
	// @Select("select * from tbl_board")
	// 전체 리스트
	public List<BoardVO> getList();
	
	// 페이징 처리 전체 리스트
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	// 총 게시글 수
	public int getTotalCount(Criteria cri);
	
	// 한 개 데이터
	public BoardVO read(long bno);
	
	// 데이터 삽입
	public void insert(BoardVO board);
	
	// 데이터 삭제
	public int delete(long bno);
	
	// 데이터 수정
	public int update(BoardVO board);
	
}
