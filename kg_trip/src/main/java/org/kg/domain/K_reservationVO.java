package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_reservationVO {

	private int ticket_idx, date_idx, air_idx, seat_idx, m_idx, ticket_price;
	private String flight_name, passport_num;
	private Date ticket_date;
	
}
