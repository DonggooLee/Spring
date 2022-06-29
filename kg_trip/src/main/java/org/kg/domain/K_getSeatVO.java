package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_getSeatVO {

	private int economyseatprice, businessseatprice, firstseatprice, date_idx;
	private String economyseat, businessseat, firstseat;
	
}
