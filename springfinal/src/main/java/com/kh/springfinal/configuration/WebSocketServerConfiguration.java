package com.kh.springfinal.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;

@EnableWebSocket //중요(기본적으로 잠겨있음)
@Configuration
public class WebSocketServerConfiguration implements WebSocketConfigurer{

}
