package com.kh.springfinal.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.support.WebBindingInitializer;

@Configuration
public class SizeLimitConfiguration {
	@Bean
	public WebBindingInitializer configurableWebBindingInitializer() {
		SizeLimitBinder binder = new SizeLimitBinder();
		return binder;  
	}
}
