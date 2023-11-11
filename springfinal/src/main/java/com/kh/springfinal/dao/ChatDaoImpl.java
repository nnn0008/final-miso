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
	
	@Override
	public void insert(ChatDto dto) {
		sqlSession.insert("chat.add", dto);
	}
	
	@Override
	public List<ChatDto> list() {
		return sqlSession.selectList("chat.allList");
	}

	@Override
	public List<ChatDto> getChatHistory(int chatRoomNo) {
		return sqlSession.selectList("chat.getChatHistory", chatRoomNo);
	}
	
}
