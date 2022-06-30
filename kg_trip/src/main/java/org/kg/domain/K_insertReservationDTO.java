package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_insertReservationDTO {

	private int date_idx, m_idx, ticket_price;
	private String reservation_idx, flight_name, seat_name, passport_num; 
	private Date ticket_date;
	
}
