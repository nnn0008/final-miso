package com.kh.springfinal.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ChatOneDto;

@Repository
public class ChatOneDaoImpl implements ChatOneDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ChatOneDto> getExistingChatRoom(String chatSender, String chatReceiver) {
		
		Map params = Map.of("chatSender", chatSender, "chatReceiver", chatReceiver);
		return sqlSession.selectList("chatOne.getExistingChatRoom", params);
		
	}
	
	@Override
	public void insert(ChatOneDto chatOneDto) {
		sqlSession.insert("chatOne.add", chatOneDto);
	}
	
	@Override
	public List<ChatOneDto> oneChatRoomList(String chatSender, String chatReceiver) {
		Map params = Map.of("chatSender", chatSender, "chatReceiver", chatReceiver);
		return sqlSession.selectList("chatOne.roomList", params);
	}
}
