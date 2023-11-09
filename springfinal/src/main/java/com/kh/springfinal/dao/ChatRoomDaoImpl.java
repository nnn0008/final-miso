package com.kh.springfinal.dao;

import java.util.List;

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
	public List<ChatRoomDto> chatRoomList(String memberId) {
		// 채팅방 목록을 가져오는 쿼리 실행
	    List<ChatRoomDto> chatRooms = sqlSession.selectList("chatRoom.find", memberId);
	    return chatRooms;
	}
	
	@Override
	public ChatRoomDto selectOne(String memberId) {
		return sqlSession.selectOne("chatRoom.find", memberId);
	}
	
	@Override
	public List<Integer> selectRoomNoByMemberId(String memberId) {
		return sqlSession.selectList("chatRoom.find2", memberId);
	}
	
	@Override
	public List<ClubMemberDto> chatRoomClubMembers(int clubNo, int chatRoomNo) {
		// TODO Auto-generated method stub
		return null;
	}


}
