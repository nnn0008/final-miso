package com.kh.springfinal.dao;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ChatDto;

@Repository
public class ChatDaoImpl implements ChatDao{

	@Autowired
	private SqlSession sqlSession;
	
	//채팅 추가
	@Override
	public void insert(ChatDto dto) {
		sqlSession.insert("chat.add", dto);
	}
	
	//채팅 전체 조회
	@Override
	public List<ChatDto> list() {
		return sqlSession.selectList("chat.allList");
	}

	//채팅 내역 조회
	@Override
	public List<ChatDto> getChatHistory(int chatRoomNo) {
		return sqlSession.selectList("chat.getChatHistory", chatRoomNo);
	}
	
	//채팅방 마지막 메세지
	@Override
	public ChatDto chatLastMsg(int chatRoomNo) {
		return sqlSession.selectOne("chat.chatLastMsg", chatRoomNo);
	}
	
	//동호회 멤버별 채팅방 메시지
	@Override
	public List<ChatDto> getChatHistoryDetail(int chatRoomNo, String chatSender) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("chatSender", chatSender);
	    params.put("chatRoomNo", chatRoomNo);
	    
	    return sqlSession.selectList("chat.getChatHistoryDetail", params);
	}
	
	//정모 멤버별 채팅방 메시지
	@Override
	public List<ChatDto> getMeetingHistory(int chatRoomNo, String chatSender){
		Map<String, Object> params = new HashMap<>();
		params.put("chatSender", chatSender);
		params.put("chatRoomNo", chatRoomNo);
		return sqlSession.selectList("chat.getMeetingHistory", params);
	}
	
	@Override
	public List<ChatDto> getChatHistoryAfterDate(int chatRoomNo, String chatSender, LocalDateTime targetTime) {
		 Map<String, Object> params = new HashMap<>();
		params.put("chatSender", chatSender);
		params.put("chatRoomNo", chatRoomNo);
		 params.put("targetTime", targetTime); 
		return sqlSession.selectList("chat.getChatHistoryReset", params);
	}

	@Override
	public boolean chatBlindUpdate(int chatNo) {
		return sqlSession.update("chat.chatBlindUpdate", chatNo) > 0;
	}
	
	public int sequence() {
		return sqlSession.selectOne("chat.sequence");
	}

	@Override
	public boolean chatBlindCheck(int chatNo) {
		return sqlSession.selectOne("chat.chatBliindCheck", chatNo);
	}

}
