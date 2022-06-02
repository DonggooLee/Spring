package org.ddongq.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class Criteria {

	private int pageNum;
	private int amount;
	
	public Criteria() {
		// 풀 생성자에 매개변수를 던진 후  호출
		this(1, 10);
	}
	
}
