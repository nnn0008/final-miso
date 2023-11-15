package com.kh.springfinal.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.springfinal.websocket.WebSocketServer;


@EnableWebSocket //중요(기본적으로 잠겨있음)
@Configuration
public class WebSocketServerConfiguration implements WebSocketConfigurer{

	@Autowired
	private WebSocketServer websocketServer;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(websocketServer, "/ws/chat")
		.addInterceptors(new HttpSessionHandshakeInterceptor())
		.withSockJS(); //spring 표준

	}
	
	//웹소켓 허용량을 늘리는 도구 추가
	@Bean
	public ServletServerContainerFactoryBean containerFactoryBean() {
		ServletServerContainerFactoryBean bean = new ServletServerContainerFactoryBean();
		bean.setMaxTextMessageBufferSize(Integer.MAX_VALUE);//허용 최대 사이즈
//		bean.setMaxTextMessageBufferSize(8192);//자바 표준 사이즈
		return bean;
	}
	
	
}
