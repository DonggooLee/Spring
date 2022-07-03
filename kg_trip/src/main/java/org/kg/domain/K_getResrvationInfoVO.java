package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_getResrvationInfoVO {

	private String m_name, m_gender, flight_name, start_date, boarding_time,
	depart_time, arrive_time, ap_name_d, ap_name_a, reservation_idx, seat_name;
	
}