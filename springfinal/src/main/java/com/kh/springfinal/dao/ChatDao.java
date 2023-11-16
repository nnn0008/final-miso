package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatDto;

public interface ChatDao {
	void insert(ChatDto dto); 
	List<ChatDto> list(); //채팅 전체 리스트 
	List<ChatDto> getChatHistory(int chatRoomNo); //채팅 내역

	ChatDto chatLastMsg(int chatRoomNo); //채팅방 마지막 메세지
}
