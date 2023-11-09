package com.kh.springfinal.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dao.ChatUserDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dto.ClubDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class WebsocketController {
	
	@Autowired
	private ChatRoomDao chatRoomDao;	
	
	@Autowired
	private ChatUserDao chatUserDao;
		
	@Autowired
	private ClubDao clubDao;
	
	@RequestMapping("/chat")
	public String chat() {
		return "chat/sockjs";
	}

}
