package org.kg.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KakaoPayCancelVO {

	// 응답정보
	private String aid, cid, tid, status, partner_order_id, partner_user_id, payment_method_type;
	
}
