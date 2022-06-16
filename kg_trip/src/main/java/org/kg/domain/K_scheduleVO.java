package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_scheduleVO {

	private int date_idx, air_idx, ap_idx_s, ap_idx_d;
	private String flight_name;
	private Date start_date, boarding_time, depart_time, arrive_time;
	
}
