package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatRoomDto;

public interface ChatRoomDao {

	void insert(ChatRoomDto chatRoomDto);
	List<ChatRoomDto> list();
	ChatRoomDto selectOne(String memberId);
}
