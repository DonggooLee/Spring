package org.kg.service;


import java.util.List;

import org.kg.domain.B_PublicMemberVO;
import org.kg.mapper.B_PublicMemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class B_publicMemberServiceImpl implements B_publicMemberService{
	
	@Setter(onMethod_ = @Autowired)
	private B_PublicMemberMapper mapper;
	
	@Override
	public int joinPublic(B_PublicMemberVO vo) {
		log.info("public member join success ... !!!");
		return mapper.insertPublic(vo);
	}

	@Override
	public int publicIdCheck(String m_id) {
		log.info("아이디 중복체크");
		return mapper.checkIdPublic(m_id);
	}

	@Override
	public int publicEmailCheck(String m_email) {
		log.info("이메일 중복체크");
		return mapper.checkEmailPublic(m_email);
	}

	@Override
	public int publicPhoneCheck(String m_phone) {
		log.info("핸드폰 중복체크");
		return mapper.checkPhonePublic(m_phone);
	}
	
	@Override
	public B_PublicMemberVO loginPublic(String m_id, String m_pw) {
		log.info("※※※※※※※※logining※※※※※※※※");
		return mapper.getPmember(m_id, m_pw);
	}

	@Override
	public List<B_PublicMemberVO> publicList() {
		log.info("회원조회 나가신다");
		return mapper.getPmemberList();
	}
	
	
	

}
