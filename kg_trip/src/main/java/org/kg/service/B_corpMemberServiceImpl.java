package org.kg.service;

import java.util.List;

import org.kg.domain.B_CorpMemberVO;
import org.kg.mapper.B_CorpMemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class B_corpMemberServiceImpl implements B_corpMemberService {
	
	@Setter(onMethod_ = @Autowired)
	private B_CorpMemberMapper mapper;
	
	@Override
	public int joinCorp(B_CorpMemberVO vo) {
		log.info("※※※※※※※※joining※※※※※※※※");
		return mapper.insertCorp(vo);
	}

	@Override
	public int corpIdCheck(String c_id) {
		log.info("중복체크");
		return mapper.checkIdCorp(c_id);
	}

	@Override
	public B_CorpMemberVO loginCorp(String c_id, String c_pw) {
		log.info("※※※※※※※※logining※※※※※※※※");
		return mapper.getCmember(c_id, c_pw);
	}

	@Override
	public List<B_CorpMemberVO> corpList() {
		log.info("회원 조회 중");
		return mapper.getCmemberList();
	}

	@Override
	public int corpEmailCheck(String c_demail) {
		log.info("중복체크");
		return mapper.checkEmailCorp(c_demail);
	}

	@Override
	public int corpPhoneCheck(String c_dphone) {
		log.info("중복체크");
		return mapper.checkPhoneCorp(c_dphone);
	}

	@Override
	public int corpDelete(String c_idx) {
		log.info("회원 탈퇴 나가신다");
		return mapper.deleteCorp(c_idx);
	}

	
	
	
}
