package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatOneDto;
import com.kh.springfinal.vo.ChatOneMemberVO;
import com.kh.springfinal.vo.ChatOneVO;

public interface ChatOneDao {
	
	List<ChatOneDto> getExistingChatRoom(String chatSender, String chatReceiver); //이미 존재하는 1:1룸 조회
	List<ChatOneDto> oneChatRoomList(String chatSender, String chatReceiver); //1:1룸 조회
	List<ChatOneMemberVO> oneChatRoomList2(String chatSender, String chatReceiver); //1:1룸 조회
	List<ChatOneDto> chatOneMemberInfo(String chatSender, String chatReceiver); //1:1룸 회원 정보 조회
	List<ChatOneVO> chatOneMemberList(int chatRoomNo); //1:1룸 번호별 회원 정보 조회
	List<ChatOneVO> chatOneMemberName(int chatRoomNo); //1:1룸 번호별 회원 닉네임 조회
	
	List<ChatDto> getChatOnetHistory(int chatRoomNo); //1:1룸 번호별 채팅 이력 조회
	
	void insert(ChatOneDto chatOneDto); //1:1룸 생성


}
