package org.kg.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.kg.domain.K_bookInfo;
import org.kg.domain.KakaoPayApprovalVO;
import org.kg.domain.KakaoPayReadyVO;
import org.kg.domain.KakaoPayDTO;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class KakaopayPay {

	private static final String HOST = "https://kapi.kakao.com";
	
	// 결제 정보 요청을 위한 객체
	private KakaoPayReadyVO kakaoPayReadyVO;
	
	// 결제 승인을 위한 객체
	private KakaoPayApprovalVO kakaoPayApprovalVO;
	
	// 결제 정보 요청
	public String kakaoPayReady(K_bookInfo bookInfo) {
		
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
        params.add("item_name", bookInfo.getFlight_name()+"_"+bookInfo.getSeat_name());
        params.add("quantity", "1");
        params.add("total_amount", Integer.toString(bookInfo.getTicket_price()));
        params.add("tax_free_amount", "100");
        params.add("approval_url", "http://localhost:8080/flight/kakaoPaySuccess?ticket_price="+bookInfo.getTicket_price()
        +"&seat_name="+bookInfo.getSeat_name()+"&date_idx="+bookInfo.getDate_idx()+"&flight_name="+bookInfo.getFlight_name()
        +"&m_idx="+bookInfo.getM_idx());
        params.add("cancel_url", "http://localhost:8080/kakaoPayCancel");
        params.add("fail_url", "http://localhost:8080/kakaoPaySuccessFail");
		
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
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

	// 결제 승인 요청
	public KakaoPayApprovalVO kakaopayInfo(KakaoPayDTO dto) {
        
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
        params.add("pg_token", dto.getPg_token());
        params.add("total_amount", dto.getTicket_price());
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
        	// 결제 승인 후 response 데이터  객체 담기
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            kakaoPayApprovalVO.setM_idx(dto.getM_idx());
            kakaoPayApprovalVO.setPg_token(dto.getPg_token());
            kakaoPayApprovalVO.setDate_idx(dto.getDate_idx());
            kakaoPayApprovalVO.setFlight_name(dto.getFlight_name());
            kakaoPayApprovalVO.setTicket_price(dto.getTicket_price());
            kakaoPayApprovalVO.setSeat_name(dto.getSeat_name());
            log.info("kakaoPayApprovalVO..." + kakaoPayApprovalVO);
            log.info("tid : " + kakaoPayApprovalVO.getTid());
            return kakaoPayApprovalVO;
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
        return null;
	}
	
}
