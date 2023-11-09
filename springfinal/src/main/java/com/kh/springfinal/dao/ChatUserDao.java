package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatUserDto;
import com.kh.springfinal.dto.ClubMemberDto;

public interface ChatUserDao {
	void insert(ChatUserDto chatUserDto);
	List<ChatUserDto> list();
	void insert(int chatRoomNo, String clubMemberId);
}
