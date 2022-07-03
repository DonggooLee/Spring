package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class P_Pakage_info_VO {

	private int c_idx, p_max, p_fee, m_idx, p_rpeople, p_totalfee, rcount, p_available, p_renum;
	private String p_num, p_period, p_country, p_region1, p_region2, p_name, p_mainimg, p_img1, p_img2, p_img3, p_img4,
			p_information, p_guide, p_division, region, p_rnum, m_id, m_name, m_phone;
	private double p_star;
	private Date p_rdate;
	
}
