package org.kg.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_getResrvationInfoVO {

	private String m_name, m_gender, flight_name, boarding_time, ticket_price,
	depart_time, arrive_time, ap_name_d, ap_name_a, reservation_idx, seat_name, tid, completion;
	
	private Date start_date;
	
}
