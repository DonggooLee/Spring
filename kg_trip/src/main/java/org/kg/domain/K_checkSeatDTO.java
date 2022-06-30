package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_checkSeatDTO {

	private int economyseatprice, businessseatprice, firstseatprice;
	private String flight_name, economyseat, businessseat, firstseat;
	
}
