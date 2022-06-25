package org.kg.service;

import org.kg.domain.B_AdminVO;
import org.kg.mapper.B_AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class B_adminServiceImpl implements B_adminService{
	
	@Setter(onMethod_ = @Autowired)
	private B_AdminMapper mapper;

	@Override
	public B_AdminVO loginAdmin(String a_id, String a_pw) {
		log.info("※※※※※※※※logining※※※※※※※※");
		return mapper.getAdmin(a_id, a_pw);
	}

	
	
	
}
