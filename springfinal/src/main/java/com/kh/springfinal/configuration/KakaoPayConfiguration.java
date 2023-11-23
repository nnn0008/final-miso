package com.kh.springfinal.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.web.client.RestTemplate;


//카카오페이 서버와 통신을 위해 필요한 객체를 등록해두는 파일(RestTemplate, HttpHeaders)
@Configuration
public class KakaoPayConfiguration {
	@Autowired
	private KakaoPayProperties kakaoPayProperties;
	
	@Bean
	public RestTemplate template() {
		RestTemplate template = new RestTemplate();
		return template;
	}
	
	@Bean
	public HttpHeaders headers() {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+kakaoPayProperties.getKey());
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=UTF-8");
		return headers;
	}
}
