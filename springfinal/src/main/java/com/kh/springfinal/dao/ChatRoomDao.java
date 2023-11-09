package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.ClubMemberDto;

public interface ChatRoomDao {

	void insert(ChatRoomDto chatRoomDto);
	List<ChatRoomDto> list();
	ChatRoomDto selectOne(String memberId);
	List<ClubMemberDto> chatRoomClubMembers(int clubNo, int chatRoomNo);
	List<ChatRoomDto> chatRoomList(String memberId);
	List<Integer> selectRoomNoByMemberId(String memberId);
}
