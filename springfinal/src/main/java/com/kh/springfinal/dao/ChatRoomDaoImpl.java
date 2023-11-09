package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.ClubMemberDto;

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
	
	@Override
	public ChatRoomDto selectOne(String memberId) {
		return sqlSession.selectOne("chatRoom.find", memberId);
	}
	
	@Override
	public List<ClubMemberDto> chatRoomClubMembers(int clubNo, int chatRoomNo) {
		   Map<String, Object> params = new HashMap<>();
		    params.put("clubNo", clubNo);
		    params.put("chatRoomNo", chatRoomNo);
		    return sqlSession.selectList("chatRoomClubMembers", params);
	}
}
