package com.kh.springfinal.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
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
		.withSockJS();
	}
}
