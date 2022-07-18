package org.kg.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class D_BoardVO {

	private int bno;
	private String title,content,writer;
	private Date regdate;
	private D_ImageVO imageVO;

	
}
