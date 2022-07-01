package org.kg.domain;

import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_getInfoDTO {

	private int date_idx;
	private String seat_grade, flight_name;
	
}
