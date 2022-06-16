package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_airlineVO {

	private int air_idx, c_type;
	private String air_code, air_name;
	
}
