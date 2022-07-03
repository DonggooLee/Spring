package org.kg.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_getScheduleDTO {

	private int economyseatprice, businessseatprice, firstseatprice, date_idx;
	private String flight_name, boarding_time, depart_time, arrive_time, ap_name_d, ap_name_a,
					economyseat, businessseat, firstseat, c_name;
	private Date start_date;
	
}
