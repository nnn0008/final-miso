package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MeetingDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.vo.ChatListVO;
import com.kh.springfinal.vo.ChatMemberListVO;
import com.kh.springfinal.vo.ChatOneMemberListVO;
import com.kh.springfinal.vo.ChatVO;
import com.kh.springfinal.vo.MeetingVO;
import com.kh.springfinal.vo.MemberVO;

public interface ChatRoomDao {

	void insert(ChatRoomDto chatRoomDto);
	List<ChatRoomDto> list(); 
	ChatRoomDto selectOne(String memberId); 
	List<ChatRoomDto> chatRoomList(String memberId);
	List<MeetingDto> meetingRoomList(String memberId);
	List<MeetingVO> meetingRoomList2(String memberId);
	List<MeetingDto> fineMeetingRoomList(int chatRoomNo);
	
	List<Integer> selectRoomNoByMemberId(String memberId);
	
	List<ChatListVO> chatRoomList(int chatRoomNo);
	ChatListVO selectOne(int chatRoomNo);
	
	List<ChatRoomDto> chatRoomMemberList(int chatRoomNo);
	List<ChatVO> chatRoomMemberName(int chatRoomNo);
	List<ChatVO> meetingRoomMemberName(int chatRoomNo);
	
	List<MemberDto> selectMemberProfile();
	List<MemberVO> selectMemberProfile2();
	
	int sequence();
	
	List<ChatDto> getExistingChatRoom(String chatSender, String chatReceiver);
	
	List<ChatMemberListVO> chatMemberList(int chatRoomNo);
	List<ChatOneMemberListVO> chatOneMemberList(int chatRoomNo);
	List<ChatMemberListVO> meetingMemberList(int chatRoomNo);
	List<ChatRoomDto> chatRoomAllList(String memberId);
	
	ClubDto clubInfo(int chatRoomNo);
	ChatOneMemberListVO oneMembers(int chatRoomNo);
	
	String clubMemberRank(String memberId, int clubNo);
	String meetingclubMemberRank(String memberId, int clubNo);
	
	int isChatRoomMember( String memberId, int chatRoomNo);
	int isMeetingRoomMember(String memberId, int chatRoomNo);
	int isOneChatRoomMember(String memberId, int chatRoomNo);
}