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
	public int publicNicknameCheck(String m_nickname) {
		log.info("닉네임 중복체크");
		return mapper.checkNicknamePublic(m_nickname);
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

	@Override
	public int publicDelete(String m_idx) {
		log.info("회원 탈퇴 나가신다");
		return mapper.deletePublic(m_idx);
	}

	@Override
	public int publicUpdate(String m_idx) {
		log.info("회원을 관리자로 변경합니다");
		return mapper.updateAuthP(m_idx);
	}

	@Override
	public int nicknameUpdate(int m_idx, String m_nickname) {
		log.info("닉네임을 변경합니다");
		return mapper.updateNickname(m_idx, m_nickname);
	}

	@Override
	public int introUpdate(int m_idx, String m_intro) {
		log.info("자기소개를 변경합니다");
		return mapper.updateIntro(m_idx, m_intro);
	}

	@Override
	public int birthUpdate(int m_idx, String m_birth) {
		log.info("생일을 변경합니다");
		return mapper.updateBirth(m_idx, m_birth);
	}

	@Override
	public int genderUpdate(int m_idx, String m_gender) {
		log.info("성별을 변경합니다");
		return mapper.updateGender(m_idx, m_gender);
	}

	@Override
	public int imgUpdate(int m_idx, String m_img) {
		log.info("이미지를 변경합니다");
		return mapper.updateImg(m_idx, m_img);
	}

	@Override
	public String passwordlogin(String m_id) {
		log.info("비밀번호를 갖고옵니다");
		return mapper.loginpassword(m_id);
	}
	
	

}
