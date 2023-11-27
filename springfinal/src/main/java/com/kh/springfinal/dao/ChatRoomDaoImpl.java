package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.MeetingDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.vo.ChatListVO;
import com.kh.springfinal.vo.ChatMemberListVO;
import com.kh.springfinal.vo.ChatOneMemberListVO;
import com.kh.springfinal.vo.ChatVO;
import com.kh.springfinal.vo.MeetingVO;
import com.kh.springfinal.vo.MemberVO;

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
	
	//회원 채팅방(정모) 목록 조회
	@Override
	public List<MeetingDto> meetingRoomList(String memberId) {
		List<MeetingDto> meetingRooms = sqlSession.selectList("chatRoom.findMeeting", memberId);
		return meetingRooms;
	}
	
	@Override
	public List<MeetingDto> fineMeetingRoomList(int chatRoomNo){
		List<MeetingDto> meetingRoomList = sqlSession.selectList("chatRoom.fineMeetingRoomList", chatRoomNo);
	return meetingRoomList;
	}
	
	@Override
	public List<MeetingVO> meetingRoomList2(String memberId) {
		List<MeetingVO> meetingRooms = sqlSession.selectList("chatRoom.findMeetingAttach", memberId);
		return meetingRooms;
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
	public List<ChatListVO> chatRoomList(int chatRoomNo) {
		return sqlSession.selectList("chatRoom.roomList", chatRoomNo);
	}
	
	//정모 채팅방 목록 조회
	
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
	
	//정모 채팅방 멤버 이름 조회
	@Override
	public List<ChatVO> meetingRoomMemberName(int chatRoomNo){
		return sqlSession.selectList("chatRoom.meetingRoomMemberName", chatRoomNo);
	}
	
	//멤버 프로필 조회
	@Override
	public List<MemberDto> selectMemberProfile() {
		return sqlSession.selectList("chatRoom.roomMemberProfile");
	}
	
	@Override
	public List<MemberVO> selectMemberProfile2(){
		return sqlSession.selectList("chatRoom.roomMemberProfile2");
	}
	
	//채팅방 발신자, 수신자 조회
	@Override
	public List<ChatDto> getExistingChatRoom(String chatSender, String chatReceiver) {	
		Map params = Map.of("chatSender", chatSender, "chatReceiver", chatReceiver);
		return sqlSession.selectList("chatRoom.getExistingChatRoom", params);

	}
	
	//동호회 회원 목록을 가져오기 위한 조회
	@Override
	public List<ChatMemberListVO> chatMemberList(int chatRoomNo) {
		return sqlSession.selectList("chatRoom.roomMemberListDetail", chatRoomNo);
	}
	
	//1:1 회원 목록을 가져오기 위한 조회
	@Override
	public List<ChatOneMemberListVO> chatOneMemberList(int chatRoomNo) {
		return sqlSession.selectList("chatRoom.chatOneMemberListDetail", chatRoomNo);
	}
	
	//정모 회원 목록을 가져오기 위한 조회
	@Override
	public List<ChatMemberListVO> meetingMemberList(int chatRoomNo){
		return sqlSession.selectList("chatRoom.meetingMemberList", chatRoomNo);
	}
	
	
	@Override
	public List<ChatRoomDto> chatRoomAllList(String memberId) {
		return sqlSession.selectList("chatRoom.chatRoomAllList", memberId);
	}

@Override
	public ClubDto clubInfo(int chatRoomNo) {
		return sqlSession.selectOne("chatRoom.clubInfo", chatRoomNo);
	}

@Override
public ChatOneMemberListVO oneMembers(int chatRoomNo) {
	return sqlSession.selectOne("chatRoom.chatOneMemberListDetail", chatRoomNo);
}

@Override
public String clubMemberRank(String memberId, int clubNo) {
    Map<String, Object> parameters = new HashMap<>();
    parameters.put("memberId", memberId);
    parameters.put("clubNo", clubNo);   
    return sqlSession.selectOne("chatRoom.clubMemberRank", parameters);
}

@Override
public int isChatRoomMember(String memberId, int chatRoomNo) {
    Map<String, Object> params = new HashMap<>();
    params.put("memberId", memberId);
    params.put("chatRoomNo", chatRoomNo);
    return sqlSession.selectOne("chatRoom.isChatRoomMember", params);
}

@Override
public int isMeetingRoomMember(String memberId, int chatRoomNo) {
    Map<String, Object> params = new HashMap<>();
    params.put("memberId", memberId);
    params.put("chatRoomNo", chatRoomNo);
    return sqlSession.selectOne("chatRoom.isMeetingRoomMember", params);
}

@Override
public int isOneChatRoomMember(String memberId, int chatRoomNo) {
    Map<String, Object> params = new HashMap<>();
    params.put("memberId", memberId);
    params.put("chatRoomNo", chatRoomNo);
    return sqlSession.selectOne("chatOne.isOnechatRoomMember", params);
}
}