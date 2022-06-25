package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class P_Pakage_reser_VO {
	
	private String p_rnum, p_num, p_name, p_period, m_id, m_name, m_phone;
	private int m_idx, p_rpeople, p_totalfee;
	private Date p_rdate;
}
