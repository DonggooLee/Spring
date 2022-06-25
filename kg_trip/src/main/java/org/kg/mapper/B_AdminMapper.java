package org.kg.mapper;

import org.apache.ibatis.annotations.Param;
import org.kg.domain.B_AdminVO;

public interface B_AdminMapper {

	public B_AdminVO getAdmin(@Param("a_id") String a_id, @Param("a_pw") String a_pw);
	
}
