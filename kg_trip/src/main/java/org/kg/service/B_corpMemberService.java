package org.kg.service;

import java.util.List;

import org.kg.domain.B_CorpMemberVO;

public interface B_corpMemberService {

	public int joinCorp(B_CorpMemberVO vo);
	public int corpIdCheck(String c_id);
	public B_CorpMemberVO loginCorp(String c_id, String c_pw);
	public List<B_CorpMemberVO> corpList();
	
}
