package org.kg.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.kg.domain.K_WeatherData;
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
public class K_Weather {

	// 날씨 데이터 응답 정보를 받기 위한 객체
	private K_WeatherData K_WeatherData;
	
	private static final String HOST = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
	
	public K_WeatherData weather() {
		
		RestTemplate restTemplate = new RestTemplate();
		
		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		
		// 서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("serviceKey", "NHFhIisxElD2BgjmXeyANumURA4QJxn2QcH3FlMAt1be6m0um%2BycQ%2F4pbb8285JIcdl04LMK6bNW3UjS3r67rw%3D%3D");
        params.add("nx", "55");
        params.add("ny", "127");
        params.add("base_date", "20220713");
        params.add("base_time", "60");
        params.add("dataType", "JSON");
		
        HttpEntity<String> body = new HttpEntity<String>(params);
		
        try {
        	// 통신에 성공하면 각 종 Response 값 들이 kakaoPayReadyVO 라는 객체에 담긴다 => 내가 필요한 값  : tid, getNext_redirect_pc_url, created_at
        	K_WeatherData = restTemplate.postForObject(new URI(HOST), body, K_WeatherData.class);
        	log.info("K_WeatherData..." + K_WeatherData);
            return K_WeatherData;
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
        return null;
	}
	
}
