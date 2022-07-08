package org.kg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kg.domain.B_PublicMemberVO;

public interface B_PublicMemberMapper {

	public List<B_PublicMemberVO> getPmemberList();
	public int insertPublic(B_PublicMemberVO vo);
	public int checkIdPublic(String m_id);
	public int checkEmailPublic(String m_email);
	public int checkPhonePublic(String m_phone);
	public B_PublicMemberVO getPmember(@Param("m_id") String m_id, @Param("m_pw") String m_pw);
	public int deletePublic(String m_idx);
	public int updatePublic(String m_idx);
	
}
