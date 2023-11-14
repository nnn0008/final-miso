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
	
	//채팅룸 생성
	@Override
	public void insert(ChatRoomDto chatRoomDto) {
		sqlSession.insert("chatRoom.add", chatRoomDto);
	}
	
	//채팅룸 전체 조회
	@Override
	public List<ChatRoomDto> list() {
		return sqlSession.selectList("chatRoom.allList");
	}
	
	//회원 채팅방(동호회) 목록 조회
	@Override
	public List<ChatRoomDto> chatRoomList(String memberId) {
	    List<ChatRoomDto> chatRooms = sqlSession.selectList("chatRoom.find", memberId);
	    return chatRooms;
	}
	
	//회원 채팅방(동호회) 상세 조회
	@Override
	public ChatRoomDto selectOne(String memberId) {
		return sqlSession.selectOne("chatRoom.find", memberId);
	}
	
	//회원 채팅방(동호회) 상세조회(int)
	@Override
	public List<Integer> selectRoomNoByMemberId(String memberId) {
		return sqlSession.selectList("chatRoom.find2", memberId);
	}
	
	//동호회 채팅방 목록 조회
	@Override
	public List<ChatListVO> chatRoomLIst(int chatRoomNo) {
		return sqlSession.selectList("chatRoom.roomList", chatRoomNo);
	}
	
	//동호회 채팅방 상세 조회
	public ChatListVO selectOne(int chatRoomNo) {
		return sqlSession.selectOne("chatRoom.roomList", chatRoomNo);
	}
	
	//채팅방 시퀀스
	@Override
	public int sequence() {
		return sqlSession.selectOne("chatRoom.sequence");
	}
	
	//채팅방 멤버 조회
	@Override
	public List<ChatRoomDto> chatRoomMemberList(int chatRoomNo) {
		return sqlSession.selectList("chatRoom.roomMemberList", chatRoomNo);
	}
	
	//채팅방 멤버 이름 조회
	@Override
	public List<ChatVO> chatRoomMemberName(int chatRoomNo) {
		return sqlSession.selectList("chatRoom.roomMemberName", chatRoomNo);
	}
	
	//멤버 프로필 조회
	@Override
	public List<MemberDto> selectMemberProfile() {
		return sqlSession.selectList("chatRoom.roomMemberProfile");
	}
	
	//채팅방 발신자, 수신자 조회
	@Override
	public List<ChatDto> getExistingChatRoom(String chatSender, String chatReceiver) {	
		Map params = Map.of("chatSender", chatSender, "chatReceiver", chatReceiver);
		return sqlSession.selectList("chatRoom.getExistingChatRoom", params);

	}
}