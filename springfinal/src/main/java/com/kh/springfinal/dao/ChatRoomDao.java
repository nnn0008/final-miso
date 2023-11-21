package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.MeetingDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.vo.ChatListVO;
import com.kh.springfinal.vo.ChatMemberListVO;
import com.kh.springfinal.vo.ChatOneMemberListVO;
import com.kh.springfinal.vo.ChatVO;

public interface ChatRoomDao {

	void insert(ChatRoomDto chatRoomDto);
	List<ChatRoomDto> list(); 
	ChatRoomDto selectOne(String memberId); 
	List<ChatRoomDto> chatRoomList(String memberId);
	List<MeetingDto> meetingRoomList(String memberId);
	
	List<Integer> selectRoomNoByMemberId(String memberId);
	
	List<ChatListVO> chatRoomList(int chatRoomNo);
	ChatListVO selectOne(int chatRoomNo);
	
	List<ChatRoomDto> chatRoomMemberList(int chatRoomNo);
	List<ChatVO> chatRoomMemberName(int chatRoomNo);
	List<ChatVO> meetingRoomMemberName(int chatRoomNo);
	
	List<MemberDto> selectMemberProfile();
	
	int sequence();
	
	List<ChatDto> getExistingChatRoom(String chatSender, String chatReceiver);
	
	List<ChatMemberListVO> chatMemberList(int chatRoomNo);
	List<ChatOneMemberListVO> chatOneMemberList(int chatRoomNo);
	List<ChatRoomDto> chatRoomAllList(String memberId);
}