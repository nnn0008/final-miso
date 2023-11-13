package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatOneDto;

public interface ChatOneDao {
	
	List<ChatOneDto> getExistingChatRoom(String chatSender, String chatReceiver);
	List<ChatOneDto> oneChatRoomList(String chatSender, String chatReceiver);

	void insert(ChatOneDto chatOneDto);


}
