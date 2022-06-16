package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_seatVO {
	
	private int seat_idx, seat_price;
	private String flight_name, seat_grade, seat_name;
	
}
