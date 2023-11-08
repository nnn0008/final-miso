package com.kh.springfinal.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix="custom.kakaopay")
public class KakaoPayProperties {
	private String cid, key;
}
