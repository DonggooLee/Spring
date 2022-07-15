package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class K_WeatherData {

	private String numOfRows, pageNo, totalCount, resultCode, resultMsg, dataType,
	baseDate, baseTime, nx, ny, category, fcstDate, fcstTime, fcstValue;
    
}
