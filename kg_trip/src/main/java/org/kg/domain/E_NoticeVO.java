package org.kg.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class E_NoticeVO {

	private int n_num, m_idx;
	private String n_title, n_content;
	private Date n_regDate, n_updDate;
	
	// 이미지 파일 관련
	private String n_file, n_uploadPath, n_uuid;
	private MultipartFile UploadFile;
	private boolean image;
	
	
	
}
