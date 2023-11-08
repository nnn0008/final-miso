package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ChatUserDto;

@Repository
public class ChatUserDaoImpl implements ChatUserDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ChatUserDto chatUserDto) {
		sqlSession.insert("chatUser.add", chatUserDto);
	}
	
	@Override
	public List<ChatUserDto> list() {
		return sqlSession.selectList("chatUser.allList");
	}
}
