package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatUserDto;

public interface ChatUserDao {
	void insert(ChatUserDto chatUserDto);
	List<ChatUserDto> list();
}
