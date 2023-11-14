package com.kh.springfinal.configuration;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

//JavaMailSenderImpl을 스프링에 등록해두기 위한 설정
//- Bean 등록을 하는 설정파일은 상속이 필요하지 않다
@Configuration
public class EmailConfiguration {
	
	@Autowired
	private EmailProperties emailProperties;
	
	//객체를 생성하여 반환하는 메소드를 만들고 상단에 @Bean 추가
	@Bean
	public JavaMailSender sender() {
		//전송 도구 - 업체와 계정관련 정보 설정
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost(emailProperties.getHost());//업체주소
		sender.setPort(emailProperties.getPort());//업체포트
		sender.setUsername(emailProperties.getUsername());
		sender.setPassword(emailProperties.getPassword());
		
		//통신과 관련된 추가 설정
		Properties props = new Properties();
		props.setProperty("mail.smtp.auth", "true");//인증 후 이용 설정(필수)
		props.setProperty("mail.smtp.debug", "true");//디버깅 기능 이용 설정(선택)
		props.setProperty("mail.smtp.starttls.enable", "true");//TLS 사용 설정(필수)
		props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");//TLS 버전 설정(필수)
		props.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");//신뢰할 수 있는 대상 설정(필수)
		sender.setJavaMailProperties(props);
		
		return sender;
	}
	
}








