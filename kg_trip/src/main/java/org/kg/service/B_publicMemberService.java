package org.kg.service;

import java.util.List;

import org.kg.domain.B_PublicMemberVO;

public interface B_publicMemberService {
	
	public int joinPublic(B_PublicMemberVO vo);
	public int publicIdCheck(String m_id);
	public int publicNicknameCheck(String m_nickname);
	public int publicEmailCheck(String m_email);
	public int publicPhoneCheck(String m_phone);
	public B_PublicMemberVO loginPublic(String m_id, String m_pw);
	public List<B_PublicMemberVO> publicList();
	public int publicDelete(String m_idx);
	public int publicUpdate(String m_idx);
	public int nicknameUpdate(int m_idx, String m_nickname);
	public int introUpdate(int m_idx, String m_intro);
	public int birthUpdate(int m_idx, String m_birth);
	public int genderUpdate(int m_idx, String m_gender);
	public int imgUpdate(int m_idx, String m_img);
	public String passwordlogin(String m_id);
	
	
}
