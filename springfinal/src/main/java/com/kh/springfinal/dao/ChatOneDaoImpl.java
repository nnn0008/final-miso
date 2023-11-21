package com.kh.springfinal.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatOneDto;
import com.kh.springfinal.vo.ChatOneMemberVO;
import com.kh.springfinal.vo.ChatOneVO;

@Repository
public class ChatOneDaoImpl implements ChatOneDao{
	
	@Autowired
	private SqlSession sqlSession;

	//이미 존재하는 1:1룸 조회
	@Override
	public List<ChatOneDto> getExistingChatRoom(String chatSender, String chatReceiver) {		
		Map params = Map.of("chatSender", chatSender, "chatReceiver", chatReceiver);
		return sqlSession.selectList("chatOne.getExistingChatRoom", params);	
	}
	
	///1:1룸 생성
	@Override
	public void insert(ChatOneDto chatOneDto) {
		sqlSession.insert("chatOne.add", chatOneDto);
	}
	
	//1:1룸 조회
	@Override
	public List<ChatOneDto> oneChatRoomList(String chatSender, String chatReceiver) {
		Map params = Map.of("chatSender", chatSender, "chatReceiver", chatReceiver);
		return sqlSession.selectList("chatOne.roomList", params);
	}
	//이미지 조회
	@Override
	public List<ChatOneMemberVO> oneChatRoomList2(String chatSender, String chatReceiver) {
		Map params = Map.of("chatSender", chatSender, "chatReceiver", chatReceiver);
		return sqlSession.selectList("chatOne.roomList2", params);
	}
	
	//1:1룸 회원 정보 조회
	@Override
	public List<ChatOneDto> chatOneMemberInfo(String chatSender, String chatReceiver) {
		Map params = Map.of("chatSender", chatSender, "chatReceiver", chatReceiver);
		return sqlSession.selectList("chatOne.oneChatMemberInfo", params);
	}
	
	///1:1룸 번호별 회원 정보 조회
	@Override
	public List<ChatOneVO> chatOneMemberList(int chatRoomNo) {
		return sqlSession.selectList("chatOne.oneChatMemberList", chatRoomNo);
	}
	
	//1:1룸 번호별 회원 닉네임 조회
	public List<ChatOneVO> chatOneMemberName(int chatRoomNo){
		return sqlSession.selectList("chatOne.oneChatMemberName", chatRoomNo);
	}
	
	@Override
	public List<ChatDto> getChatOnetHistory(int chatRoomNo) {
		return sqlSession.selectList("chatOne.oneChatHistory", chatRoomNo);
	}
	
}
