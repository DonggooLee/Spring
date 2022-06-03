package org.ddongq.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ddongq.domain.Criteria;
import org.ddongq.domain.ReplyVO;

public interface ReplyMapper {
	
	// 댓글 추가
	public int insert(ReplyVO vo);
	
	// 댓글 목록 (페이징 처리)
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") long bno);
	
	// 댓글 읽기
	public ReplyVO read(long rno);
	
	// 댓글 삭제
	public int delete(long bno);
	
	// 댓글 수정
	public int update(ReplyVO vo);
	
}
