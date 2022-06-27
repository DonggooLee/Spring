package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_getReservationVO {

	private int ticket_price;
	private String flight_name, air_name, ticket_date, ap_name_d, ap_name_s, passport_num,
	seat_name, boarding_time, depart_time, arrive_time, m_name, m_phone, m_email, m_gender;
	
}
