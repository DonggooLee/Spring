package org.kg.service;

import org.kg.domain.B_CorpMemberVO;

public interface B_corpMemberService {

	public int joinCorp(B_CorpMemberVO vo);
	public int corpIdCheck(String c_id);
	
}
