package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class E_Criteria {
	// criteria : 페이징처리할 때 (보통 쓰는) 명칭 / 다른 거 써도 됨
		
	private int pageNum, amount;
	// pageNum: 현재 페이지 번호, amount : 페이지당 출력할 데이터 개수
	
	public E_Criteria() {
		this(1,15);
	}
	
}
