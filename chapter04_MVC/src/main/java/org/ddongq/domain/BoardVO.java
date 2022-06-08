package org.ddongq.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardVO {

	private long bno;
	private String title, content, writer;
	private Date regdate, updatedate;
	private int replycnt;
	
}
