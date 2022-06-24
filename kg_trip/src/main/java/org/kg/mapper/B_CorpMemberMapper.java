package org.kg.mapper;

import java.util.List;

import org.kg.domain.B_CorpMemberVO;

public interface B_CorpMemberMapper {
	
	public List<B_CorpMemberVO> getMemberList();
	public int insertCorp(B_CorpMemberVO CorpMember);
	public int checkIdCorp(String c_id);

}
