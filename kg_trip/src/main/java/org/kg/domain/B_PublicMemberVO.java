package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class B_PublicMemberVO {

	private int m_idx, m_connect;
	private String m_id,m_pw,m_nickname, m_name, m_gender, m_email, m_phone, m_birth , m_intro, m_mbti,m_img,m_auth,
			birthYear, birthMonth, birthDate;
	private Date m_regdate;
	
}
