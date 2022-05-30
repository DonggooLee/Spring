package org.ddongq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data				// getter, setter
@NoArgsConstructor	// 기본생성자 만들기
@AllArgsConstructor // 풀생성자 
public class StudentDto {
	private String name, dept;
	private int gradeNo, classNo;
}
