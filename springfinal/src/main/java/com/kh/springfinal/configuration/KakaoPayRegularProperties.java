package com.kh.springfinal.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix="custom.kakaopay")
public class KakaoPayRegularProperties {
	private String regularcid,key;
}
