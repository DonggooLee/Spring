package org.kg.service;

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

	
	
}
