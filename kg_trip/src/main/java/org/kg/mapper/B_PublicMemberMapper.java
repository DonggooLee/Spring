package org.kg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kg.domain.B_PublicMemberVO;

public interface B_PublicMemberMapper {

	public List<B_PublicMemberVO> getPmemberList();
	public int insertPublic(B_PublicMemberVO vo);
	public int checkIdPublic(String m_id);
	public int checkNicknamePublic(String m_nickname);
	public int checkEmailPublic(String m_email);
	public int checkPhonePublic(String m_phone);
	public B_PublicMemberVO getPmember(@Param("m_id") String m_id, @Param("m_pw") String m_pw);
	public int deletePublic(String m_idx);
	public int updateAuthP(String m_idx);
	public int updateNickname(@Param("m_idx")int m_idx, @Param("m_nickname") String m_nickname);
	public int updateIntro(@Param("m_idx")int m_idx, @Param("m_intro") String m_intro);
	public int updateBirth(@Param("m_idx")int m_idx, @Param("m_birth") String m_birth);
	public int updateGender(@Param("m_idx")int m_idx, @Param("m_gender") String m_gender);
	public int updateImg(@Param("m_idx")int m_idx, @Param("m_img") String m_img);
	public String loginpassword(String m_id);
	
	
}
