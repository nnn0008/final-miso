package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.vo.ChatListVO;

public interface ChatRoomDao {

	void insert(ChatRoomDto chatRoomDto);
	List<ChatRoomDto> list();
	ChatRoomDto selectOne(String memberId);
	List<ChatRoomDto> chatRoomList(String memberId);
	List<Integer> selectRoomNoByMemberId(String memberId);
	
	List<ChatListVO> chatRoomLIst(int chatRoomNo);
	ChatListVO selectOne(int chatRoomNo);
	
	int sequence();
}