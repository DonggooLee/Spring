package org.kg.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class E_FreqVO {
	
	private int fq_num, m_idx;
	private String fq_cat, fq_title, fq_content;
	private Date fq_regDate, fq_updDate;
	
	// 카테고리 관련
	private String cat; // list에서 선택 카테고리 글만 뽑을 때 
	
	
	// 이미지 파일 관련
	private String fq_file, fq_uploadPath, fq_uuid;
	private MultipartFile UploadFile;
	private boolean image;

	// 이미지 수정 관련
	private String oldFileName;
	// private String oldFileSize;
		
}
