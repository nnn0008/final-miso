package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.vo.ChatVO;

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
	
	////채팅방 마지막 메세지
	@Override
	public ChatDto chatLastMsg(int chatRoomNo) {
		return sqlSession.selectOne("chat.chatLastMsg", chatRoomNo);
	}
}
