package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class P_Review_VO {

	private String p_num, m_id, p_reviewcontent, p_reviewimg;
	private int p_renum, m_idx;
	private double p_star;
	private Date p_reviewdate; 
	
}
