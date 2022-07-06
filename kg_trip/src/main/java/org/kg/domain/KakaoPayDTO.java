package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KakaoPayDTO {
	
	private String pg_token, ticket_price, seat_name, flight_name, date_idx, m_idx, reservation_idx;
 
}
