package com.kh.springfinal.websocket;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.springfinal.vo.ClientVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WebSocketServer extends TextWebSocketHandler{

	//JSON 변환기
	private ObjectMapper mapper = new ObjectMapper();
	
	@Autowired
	private SqlSession sqlSession;
	
	//저장소
	private Set<ClientVO> clients = new CopyOnWriteArraySet<>(); //전체 회원(로그인)
	private Map<Integer, Set<ClientVO>> roomMembersMap = new ConcurrentHashMap<>(); // 채팅방 멤버, 채팅방 번호를 키로 사용
	
	//접속 성공
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		ClientVO client = new ClientVO(session);
		
		if(client.isMember()) {
			clients.add(client);
			Integer chatRoomNo = client.getChatRoomNo();
			if(chatRoomNo != null) {
				addRoomMember(client, chatRoomNo);  //클라이언트를 채팅방 멤버 목록에 추가
			}
		}
		log.debug("사용자 접속! 현재 {}명", clients.size());
			
	}
	
	//접속 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		ClientVO client = new ClientVO(session);
		clients.remove(client);
		log.debug("사용자 종료! 현재 {}명", clients.size());	
	}
	
	//채팅방 멤버 추가
		public void addRoomMember(ClientVO client, Integer chatRoomNo) {
		    Set<ClientVO> roomMembers = roomMembersMap.computeIfAbsent(chatRoomNo, k -> new HashSet<>());
		    roomMembers.add(client);
		    log.debug("채팅방 멤버 = {}", roomMembers.size());
		}
		//제거
		public void removeRoomMember(ClientVO client, Integer chatRoomNo) {
		    Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
		    if (roomMembers != null) {
		        roomMembers.remove(client);
		    }
		}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//사용자가 보낸 메세지를 처리하는 메소드
		ClientVO client = new ClientVO(session);
		for(ClientVO clients : clients) {
			clients.send(message);
		}
	}
}