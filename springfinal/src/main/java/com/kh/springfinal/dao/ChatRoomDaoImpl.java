package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ChatRoomDto;

@Repository
public class ChatRoomDaoImpl implements ChatRoomDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ChatRoomDto chatRoomDto) {
		sqlSession.insert("chatRoom.add", chatRoomDto);
	}
	
	@Override
	public List<ChatRoomDto> list() {
		return sqlSession.selectList("chatRoom.allList");
	}
}
