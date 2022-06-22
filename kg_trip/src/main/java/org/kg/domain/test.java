package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class test {

	private int seat_price, seat_idx, seat_choice;
	private String seat_grade, seat_name, flight_name;

}
