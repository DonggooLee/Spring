package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class testVO {
	
	private String m_name, m_gender, flight_name, seat_name, seat_grade, ap_name;
	private Date depart_time, arrive_time, boarding_time;
	
}
