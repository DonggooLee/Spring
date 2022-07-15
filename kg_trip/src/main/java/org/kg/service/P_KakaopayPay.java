package org.kg.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Random;

import org.kg.domain.KakaoPayApprovalVO;
import org.kg.domain.KakaoPayCancelVO;
import org.kg.domain.KakaoPayReadyVO;
import org.kg.domain.P_Pakage_list_VO;
import org.kg.domain.P_Pakage_reser_VO;
import org.kg.domain.P_bookInfo;
import org.kg.mapper.P_PakageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class P_KakaopayPay {

	@Setter(onMethod_ = @Autowired)
	P_PakageMapper mapper;
	
	private static final String HOST = "https://kapi.kakao.com";
	
	// 결제 요청을 위한 객체
	private KakaoPayReadyVO kakaoPayReadyVO;
	// 결제 승인을 위한 객체
	private KakaoPayApprovalVO kakaoPayApprovalVO;
	// 결제 취소를 위한 객체
	private KakaoPayCancelVO kakaoPayCancelVO;

	
	// 결제 정보 요청
	public String kakaoPayReady(P_bookInfo bookInfo) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK 7f0d70eee3a169f9c0b2267692ce2ac9");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
		
		// 서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "1001");
        params.add("partner_user_id", "gorany");
        params.add("item_name", bookInfo.getP_name());
        params.add("quantity", "1");
        params.add("total_amount", bookInfo.getP_totalfee());
        params.add("tax_free_amount", "100");
        params.add("approval_url", "http://localhost:8080/pakage/P_kakaoPaySuccess?p_num="+bookInfo.getP_num()
        +"&p_name="+bookInfo.getP_name()+"&p_period="+bookInfo.getP_period()
        +"&m_name="+bookInfo.getM_name()+"&m_phone="+bookInfo.getM_phone()+"&p_rpeople="+bookInfo.getP_rpeople()
        +"&p_totalfee="+bookInfo.getP_totalfee()+"&m_idx="+bookInfo.getM_idx()+"&m_id="+bookInfo.getM_id()+"&");
        params.add("cancel_url", "http://localhost:8080/kakaoPayCancel");
        params.add("fail_url", "http://localhost:8080/kakaoPaySuccessFail");
		
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
        	// 통신에 성공하면 각 종 Response 값 들이 kakaoPayReadyVO 라는 객체에 담긴다 => 내가 필요한 값  : tid, getNext_redirect_pc_url, created_at
        	kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
        	log.info("kakaoPayReadyVO..." + kakaoPayReadyVO);
            return kakaoPayReadyVO.getNext_redirect_pc_url();
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
        return null;
	}

	// 결제 승인 요청 응답정보
	public KakaoPayApprovalVO kakaoPayInfo(P_bookInfo bookInfo) {
        
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
 		HttpHeaders headers = new HttpHeaders();
 		headers.add("Authorization", "KakaoAK 7f0d70eee3a169f9c0b2267692ce2ac9");
 		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
 		headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
        
 		// 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", "1001");
        params.add("partner_user_id", "gorany");
        params.add("pg_token", bookInfo.getPg_token());
        params.add("total_amount", bookInfo.getP_totalfee());
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
    		
    		// 통신에 성공하면 각 종 Response 값 들이 kakaoPayApprovalVO 라는 객체에 담김
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            // 결제 성공 시 scheduleReservationComplete.jsp 에서 비동기 방식으로 DB에 값을 집어 넣기 위함
            Random ran = new Random();
            int num = ran.nextInt(999+1);
            kakaoPayApprovalVO.setP_rnum(bookInfo.getP_num()+bookInfo.getM_idx()+num);
            kakaoPayApprovalVO.setM_idx(bookInfo.getM_idx());
            kakaoPayApprovalVO.setPg_token(bookInfo.getPg_token());
            kakaoPayApprovalVO.setP_num(bookInfo.getP_num());
            kakaoPayApprovalVO.setP_name(bookInfo.getP_name());
            kakaoPayApprovalVO.setP_period(bookInfo.getP_period());
            kakaoPayApprovalVO.setM_id(bookInfo.getM_id());
            kakaoPayApprovalVO.setM_name(bookInfo.getM_name());
            kakaoPayApprovalVO.setM_phone(bookInfo.getM_phone());
            kakaoPayApprovalVO.setP_rpeople(bookInfo.getP_rpeople());
            kakaoPayApprovalVO.setP_totalfee(bookInfo.getP_totalfee());
            log.info("kakaoPayApprovalVO..." + kakaoPayApprovalVO);
            return kakaoPayApprovalVO;
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
        return null;
	}
	
	
	// 결제 취소 요청 응답정보
	public KakaoPayCancelVO kakaoPayCancel(P_bookInfo bookInfo) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK 7f0d70eee3a169f9c0b2267692ce2ac9");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
		
		// 서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
        params.add("tid", bookInfo.getTid());
        params.add("cancel_amount", bookInfo.getP_totalfee());
        params.add("cancel_tax_free_amount", "100");
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
        	// 통신에 성공하면 각 종 Response 값 들이 kakaoPayCancelVO 라는 객체에 담김
        	kakaoPayCancelVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/cancel"), body, KakaoPayCancelVO.class);
        	// 항공권 환불 
        	
    		P_Pakage_reser_VO board = new P_Pakage_reser_VO();
    		board = mapper.mread(bookInfo.getP_rnum());
    		
    		
    		P_Pakage_list_VO liboard = new P_Pakage_list_VO();
    		liboard = mapper.readp(bookInfo.getP_num());
    		
    		log.info(liboard);
    		
    		liboard.setP_people(liboard.getP_people() - board.getP_rpeople());
    		liboard.setP_available(liboard.getP_available() + board.getP_rpeople());
    		int result1 = mapper.mupdatea(liboard);
    		
    		
    		// 개인 예약취소 delete
    		int result2 = mapper.mdeletea(bookInfo.getP_rnum());
        			
        	log.info("항공권 환불 결과 : " + result1 + result2);
        	log.info("kakaoPayCacelVO..." + kakaoPayCancelVO);
            return kakaoPayCancelVO;
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
        return null;
	}
	
}
