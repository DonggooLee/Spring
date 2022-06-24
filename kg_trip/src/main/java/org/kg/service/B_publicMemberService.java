package org.kg.service;

import org.kg.domain.B_PublicMemberVO;

public interface B_publicMemberService {
	
	public int joinPublic(B_PublicMemberVO vo);
	public int publicIdCheck(String m_id);
	public int publicEmailCheck(String m_email);
	public int publicPhoneCheck(String m_phone);
	public B_PublicMemberVO loginPublic(String m_id, String m_pw);
	
}
