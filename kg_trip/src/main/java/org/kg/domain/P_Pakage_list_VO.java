package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class P_Pakage_list_VO {

	private int p_max, p_people, p_available;
	private String p_num, p_period;
	private double p_star;
}
