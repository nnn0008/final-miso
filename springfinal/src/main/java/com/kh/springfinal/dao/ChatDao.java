package com.kh.springfinal.dao;

import java.time.LocalDateTime;
import java.util.List;

import com.kh.springfinal.dto.ChatDto;

public interface ChatDao {
	void insert(ChatDto dto); 
	List<ChatDto> list(); //채팅 전체 리스트 
	List<ChatDto> getChatHistory(int chatRoomNo); //채팅 내역

	ChatDto chatLastMsg(int chatRoomNo); //채팅방 마지막 메세지
	
	List<ChatDto> getChatHistoryDetail(int chatRoomNo, String chatSender); //멤버별 채팅방 메시지
	
	List<ChatDto> getChatHistoryAfterDate(int chatRoomNo, String chatSender, LocalDateTime targetTime); //초기화 이후 내역 조회

	boolean chatBlindUpdate(int chatNo);
	
	int sequence();
	
	boolean chatBlindCheck(int chatNo); //채팅 블라인드 처리 확인
}
