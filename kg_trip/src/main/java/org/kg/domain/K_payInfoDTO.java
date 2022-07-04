package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_payInfoDTO {

	private String reservation_idx, flight_name, seat_name, passport_num, 
	ticket_date, date_idx, m_idx, ticket_price;
	
}
