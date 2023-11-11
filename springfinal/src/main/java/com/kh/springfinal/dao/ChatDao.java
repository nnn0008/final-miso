package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.vo.ChatVO;

public interface ChatDao {
	void insert(ChatDto dto);
	List<ChatDto> list();
	List<ChatDto> getChatHistory(int chatRoomNo);
}
