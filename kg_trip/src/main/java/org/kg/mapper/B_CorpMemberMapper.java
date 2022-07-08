package org.kg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kg.domain.B_CorpMemberVO;

public interface B_CorpMemberMapper {
	
	public List<B_CorpMemberVO> getCmemberList();
	public int insertCorp(B_CorpMemberVO CorpMember);
	public int checkIdCorp(String c_id);
	public int checkEmailCorp(String c_demail);
	public int checkPhoneCorp(String c_dphone);
	public B_CorpMemberVO getCmember(@Param("c_id") String c_id, @Param("c_pw") String c_pw);
	public int deleteCorp(String c_idx);
}
