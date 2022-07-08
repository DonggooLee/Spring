package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_bookInfo {

	private String tid, reservation_idx, flight_name, seat_name, passport_num, ticket_price, m_idx, date_idx, pg_token;
	private Date ticket_date; 
	
}
