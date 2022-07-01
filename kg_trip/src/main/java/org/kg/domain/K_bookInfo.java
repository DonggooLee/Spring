package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_bookInfo {

	private int date_idx, m_idx, ticket_price;
	private String reservation_idx, flight_name, ticket_date, seat_name, passport_num;
	
}
