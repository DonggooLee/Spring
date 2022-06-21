package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class testVO {

	private int seat_price;
	private Date start_date;
	private String flight_name, ap_name_s, ap_name_d, air_name, seat_grade;
	
}
