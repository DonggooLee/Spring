package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardVO_ {

	private long bno;
	private String title, content, writer;
	private Date regdate, updatedate;
	private int replycnt;
	
}
