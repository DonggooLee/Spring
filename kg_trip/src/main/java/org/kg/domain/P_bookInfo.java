package org.kg.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class P_bookInfo {

	// 카카오정보
    private String aid, tid, cid, sid;
    private String partner_order_id, partner_user_id, payment_method_type;
    private AmountVO amount;
    private CardVO card_info;
    private String item_name, item_code, payload;
    private Integer quantity, tax_free_amount, vat_amount;
    private Date created_at, approved_at;
    
    // 예약정보
	private String P_rnum, p_num, p_name, p_period, m_id, m_name, m_phone, p_tid, p_completion,
	m_idx, p_rpeople, p_totalfee, pg_token;
	private Date p_rdate; 
	
}
