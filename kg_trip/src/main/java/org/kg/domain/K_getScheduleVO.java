package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_getScheduleVO {

	private int seat_price;
	private String flight_name, ap_name_s, ap_name_d, air_name, seat_grade,
					boarding_time, depart_time, arrive_time, start_date;
	
}
