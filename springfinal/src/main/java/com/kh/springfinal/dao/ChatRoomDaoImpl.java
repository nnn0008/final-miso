package com.kh.springfinal.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.vo.ChatListVO;
import com.kh.springfinal.vo.ChatVO;

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
	public List<ChatListVO> chatRoomLIst(int chatRoomNo) {
		return sqlSession.selectList("chatRoom.roomList", chatRoomNo);
	}

	public ChatListVO selectOne(int chatRoomNo) {
		return sqlSession.selectOne("chatRoom.roomList", chatRoomNo);
	}
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("chatRoom.sequence");
	}
	
	@Override
	public List<ChatRoomDto> chatRoomMemberList(int chatRoomNo) {
		return sqlSession.selectList("chatRoom.roomMemberList", chatRoomNo);
	}
	
	@Override
	public List<ChatVO> chatRoomMemberName(int chatRoomNo) {
		return sqlSession.selectList("chatRoom.roomMemberName", chatRoomNo);
	}
	
	@Override
	public List<MemberDto> selectMemberProfile() {
		return sqlSession.selectList("chatRoom.roomMemberProfile");
	}
	

	@Override
	public List<ChatDto> getExistingChatRoom(String chatSender, String chatReceiver) {
		
		Map params = Map.of("chatSender", chatSender, "chatReceiver", chatReceiver);
		return sqlSession.selectList("chatRoom.getExistingChatRoom", params);

	}
}