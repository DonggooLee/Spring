package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_insertScheduleDTO {

	private int date_idx, ap_idx_d, ap_idx_a;
	private String flight_name, start_date, boarding_time, depart_time, arrive_time;
	
}