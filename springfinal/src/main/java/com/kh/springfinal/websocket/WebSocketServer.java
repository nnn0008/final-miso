package com.kh.springfinal.websocket;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
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
import com.kh.springfinal.dao.ChatDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.MessageDto;
import com.kh.springfinal.dto.MessageDto.MessageType;
import com.kh.springfinal.vo.ClientVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WebSocketServer extends TextWebSocketHandler{

	//JSON 변환기
	private ObjectMapper mapper = new ObjectMapper();
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private ChatDao chatDao;
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
		
	//저장소
	private Set<ClientVO> clients = new CopyOnWriteArraySet<>(); //전체 회원(로그인)
	private Map<Integer, Set<ClientVO>> roomMembersMap = new ConcurrentHashMap<>(); // 채팅방 멤버, 채팅방 번호를 키로 사용
	
	
//	//접속 성공
//		@Override
//		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//			ClientVO client = new ClientVO(session);
//			
//			if(client.isMember()) {
//				clients.add(client);
//				ChatRoomDto chatRoomDto =
//						chatRoomDao.selectOne(client.getMemberId());	 //아이디에 해당하는 룸번호를 찾아서 넣어라 		
//				Integer chatRoomNo = client.getChatRoomNo();
//				if(chatRoomNo != null) {
//					addRoomMember(client, chatRoomNo);  //클라이언트를 채팅방 멤버 목록에 추가
//				}
//			}
//			log.debug("사용자 접속! 현재 {}명", clients.size());
//			
//			sendMessageList(client); //접속자 명단 전송
//			sendRoomMembersList(client.getChatRoomNo()); //채팅 멤버 명단 전송
//			sendRoomList(client.getChatRoomNo(), session); //이 사용자가 접속 가능한 방 목록을 전달(방 번호들)
//		}
	
	//접속 성공
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		ClientVO client = new ClientVO(session);
		
		if(client.isMember()) {
			clients.add(client);
			
			//사용자가 속해있는 모든 룸번호를 조회
			List<Integer> chatRooms = chatRoomDao.selectRoomNoByMemberId(client.getMemberId());
			
			 log.debug("사용자가 속한 룸 번호 개수: {}", chatRooms.size()); // 로그로 개수 출력
			 log.debug("사용자가 속한 룸 번호: {}", chatRooms); // 사용자가 속한 룸 번호를 로그로 출력

			if(chatRooms != null) {
				for(Integer chatRoomNo : chatRooms) {
				addRoomMember(client, chatRoomNo);	//멤버 추가
				
					}
				}
			}
			
		log.debug("사용자 접속! 현재 {}명", clients.size());
		
//		sendMessageList(client); //접속자 명단 전송
//		sendRoomMembersList(client.getChatRoomNo()); //채팅 멤버 명단 전송
//		sendRoomList(client.getChatRoomNo(), session); //이 사용자가 접속 가능한 방 목록을 전달(방 번호들)
	}
		
	//접속 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		ClientVO client = new ClientVO(session);
		clients.remove(client);
		
		if(client.isMember()) {
			
			clients.remove(client);
			Integer chatRoomNo = client.getChatRoomNo(); 
			if(chatRoomNo != null) {
				removeRoomMember(client, chatRoomNo);
			}
		}
		log.debug("사용자 종료! 현재 {}명", clients.size());	
		
		//접속자 명단 전송
//		sendMessageList(client);
//		sendRoomMembersList(client.getChatRoomNo()); //채팅 멤버 명단 전송	
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
	
//	//채팅방 목록을 전송하는 메소드(룸번호 조회)
//	public void sendRoomList(Integer chatRoomNo, WebSocketSession session) throws IOException {
//		ClientVO client = new ClientVO(session);
//		//1. 채팅방 목록 조회
//		List<ChatRoomDto> chatRooms = chatRoomDao.chatRoomList(client.getMemberId());
//		log.debug("chatRooms : {}", chatRooms);
//		
//		//2. 채팅방 목록 JSON 문자열로 변환
//	   ObjectMapper mapper = new ObjectMapper();
//	   if(chatRooms != null) {
//		   Map<String, Object> data = new HashMap<>();
//		   data.put("chatRooms", chatRooms);
//		   String chatRoomJson = mapper.writeValueAsString(data);
//		   
//		 //3. 해당 멤버에게 전송
//		 TextMessage message = new TextMessage(chatRoomJson);
//		 session.sendMessage(message);		 
//	   }	   	   
//	}
//	
	// 채팅방 멤버 명단을 전송하는 메소드
	public void sendRoomMembersList(Integer chatRoomNo) throws IOException {
	    // 1. 채팅방 멤버 명단을 전송 가능한 형태(JSON 문자열)로 변환한다
	    ObjectMapper mapper = new ObjectMapper();

	    Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo); // 채팅방 번호에 해당하는 멤버 명단 가져오기

	    if (roomMembers != null) {
	        Map<String, Object> data = new HashMap<>();
	        data.put("roomMembers", roomMembers);
	        String roomMembersJson = mapper.writeValueAsString(data);

	        // 2. 동호회 멤버에게 전송
	        TextMessage message = new TextMessage(roomMembersJson);

	        for (ClientVO roomMember : roomMembers) {
	            roomMember.send(message);
	        }
	    }
	}
//
//	//접속한 사용자에게 메세지 이력을 전송하는 메소드
//	public void sendMessageList(ClientVO client) throws IOException {
//		List<ChatDto> list = chatDao.list(); 
//	
//		for(ChatDto dto : list) {
//			if(dto.getChatReceiver() == null && dto.getChatRoomNo() == client.getChatRoomNo()) {
//				LocalDateTime chatTime = LocalDateTime.now(); // 현재 날짜와 시간 가져오기
//				
//				Map<String, Object> map = new HashMap<>();
//				map.put("content", dto.getChatContent()); //메세지 내용
//				map.put("memberId", dto.getChatSender()); //발신자
//				map.put("chatTime", chatTime.toString()); //LocalDateTime을 문자열로 변환
//				map.put("chatRoomNo", dto.getChatRoomNo()); //채팅방 번호
//				map.put("attachNo", dto.getAttachNo()); //첨부파일 번호(이후 구현)
//				
//				String messageJson = mapper.writeValueAsString(map); //JSON 문자열 생성
//				TextMessage message = new TextMessage(messageJson);
//				client.send(message);
//			}
//		}
//	}
//	
	
	// 특정 채팅방 입장 시 이전 메시지 조회 및 전송
	public void sendChatHistory(Integer chatRoomNo, WebSocketSession session) throws IOException {

	    List<ChatDto> chatHistory = chatDao.getChatHistory(chatRoomNo);
	    
	    for (ChatDto chatDto : chatHistory) {
	        LocalDateTime chatTime = chatDto.getChatTime();

	        Map<String, Object> map = new HashMap<>();
	        map.put("memberId", chatDto.getChatSender());
	        map.put("content", chatDto.getChatContent());
	        map.put("chatTime", chatTime.toString());
	        map.put("chatRoomNo", chatRoomNo);

	        String messageJson = mapper.writeValueAsString(map);
	        TextMessage tm = new TextMessage(messageJson);
	        session.sendMessage(tm);
	    }
	}
	
//	// 채팅방 멤버에게 메시지 전송
//	private void sendMessageToChatRoomMembers(Integer chatRoomNo, String chatSender, String chatContent) throws IOException {
//	    Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
//
//	    if (roomMembers != null) {
//	        for (ClientVO roomMember : roomMembers) {
//	            // 해당 채팅방에 속한 클라이언트에게만 메시지 전송
//	            sendMessageToClient(roomMember.getSession(), chatContent, chatSender, chatRoomNo);
//	        }
//	    }
//	}
//
//	// 특정 클라이언트에게 채팅 메시지 전송
//	private void sendMessageToClient(WebSocketSession session, String chatContent, String chatSender, Integer chatRoomNo) throws IOException {
//	    LocalDateTime chatTime = LocalDateTime.now();
//	    
//	    // 클라이언트 정보를 이용하여 ClientVO 객체 생성
//	    ClientVO client = new ClientVO(session);
//
//	    Map<String, Object> map = new HashMap<>();
//	    map.put("messageType", MessageType.message);
//	    map.put("chatSender", chatSender);
//	    map.put("content", chatContent);
//	    map.put("chatRoomNo", chatRoomNo);
//	    map.put("chatTime", chatTime.toString());
//
//	    String messageJson = mapper.writeValueAsString(map);
//	    TextMessage tm = new TextMessage(messageJson);
//
//	    session.sendMessage(tm);
//	    
//	    // DB insert
//	    chatDao.insert(ChatDto.builder()
//	            .chatSender(client.getMemberId())
//	            .chatContent(chatContent)
//	            .chatRoomNo(chatRoomNo)
//	            .chatTime(chatTime)
//	            .build());
//	}

	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		ClientVO client = new ClientVO(session);
		
	    // 메시지를 JSON으로 파싱
	    ObjectMapper mapper = new ObjectMapper();
	    MessageDto messageDto = mapper.readValue(message.getPayload(), MessageDto.class);

	    // messageType 추출
	    MessageType messageType = messageDto.getMessageType();

	    // messageType에 따라 처리
	    
	    //입장 메세지인 경우
	    if (MessageType.join.equals(messageType)) {
	        Integer chatRoomNo = messageDto.getChatRoomNo();
	        // 여기에서 chatRoomNo를 활용하여 처리
	        sendChatHistory(chatRoomNo, session);
	    }
	    
	 // 채팅 메시지인 경우
	    else if (MessageType.message.equals(messageType)) {
	    	LocalDateTime chatTime = LocalDateTime.now();
	    	
	    	Integer chatRoomNo = messageDto.getChatRoomNo();
	        String chatContent = messageDto.getChatContent();
	        String chatSender = messageDto.getChatSender();
	        
//	         정보를 Map에 담아서 변환 후 전송
            Map<String, Object> map = new HashMap<>();
            map.put("chatSender", chatSender);
            map.put("content", chatContent);
            map.put("chatTime", chatTime.toString());
            map.put("chatRoomNo", chatRoomNo);
            
            String messageJson = mapper.writeValueAsString(map);
            TextMessage tm = new TextMessage(messageJson);

            client.send(tm);
           
            //DB
            chatDao.insert(ChatDto.builder()
            		.chatContent(chatContent)
            		.chatSender(chatSender)
            		.chatRoomNo(chatRoomNo)
            		.build());
            
            
	    }
	}

	
//	@Override
//	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//	    // 사용자가 보낸 메시지를 처리하는 메소드
//	    ClientVO client = new ClientVO(session);
//	    if (!client.isMember()) return; // 비회원 리턴
//
//	    Integer chatRoomNo = client.getChatRoomNo();
//
//	    if (chatRoomNo != null) {
//	        Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo); // 채팅룸 번호에 해당하는 멤버 목록 가져오기
//
//	        if (roomMembers != null) {
//	            // 메시지를 MessageDto로 변환
//	            MessageDto messageDto = mapper.readValue(message.getPayload(), MessageDto.class);
//
//	            LocalDateTime chatTime = LocalDateTime.now();
//
//	            // 정보를 Map에 담아서 변환 후 전송
//	            Map<String, Object> map = new HashMap<>();
//	            map.put("memberId", client.getMemberId());
//	            map.put("content", messageDto.getChat_content());
//	            map.put("chatTime", chatTime.toString());
//	            map.put("chatRoomNo", client.getChatRoomNo());
//	            // 첨부파일 추후
//
//	            String messageJson = mapper.writeValueAsString(map);
//	            TextMessage tm = new TextMessage(messageJson);
//
//	            for (ClientVO c : roomMembers) {
//	                c.send(tm);
//	            }
//
//	            // DB insert
//	            chatDao.insert(ChatDto.builder()
//	                    .chatContent(messageDto.getChat_content())
//	                    .chatSender(client.getMemberId())
//	                    .chatRoomNo(chatRoomNo)
//	                    .build());
//	        }
//	    }
//	}


		
//	@Override
//	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		//사용자가 보낸 메세지를 처리하는 메소드
//		ClientVO client = new ClientVO(session);
//		if(client.isMember() == false) return; //비회원 리턴
//		
//		Integer chatRoomNo = client.getChatRoomNo();
//		
//		if(chatRoomNo != null) {
//			Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo); //채팅룸 번호에 해당하는 멤버 목록 가져오기 
//			
//			if(roomMembers != null) {
//				Map params = mapper.readValue(message.getPayload(), Map.class);
//				
//				LocalDateTime chatTime = LocalDateTime.now();
//				
//				//정보를 Map에 담아서 변환 후 전송
//				Map<String, Object> map = new HashMap<>();
//				map.put("memberId", client.getMemberId());
//				map.put("content", params.get("content"));
//				map.put("chatTime", chatTime.toString());
//				map.put("chatRoomNo", client.getChatRoomNo());
//				//첨부파일 추후
//				
//				String messageJson = mapper.writeValueAsString(map);
//				TextMessage tm = new TextMessage(messageJson);
//			
//				for(ClientVO c : roomMembers) {
//					c.send(tm);
//				}
//				
//				//DB insert
//				chatDao.insert(ChatDto.builder()
//						.chatContent((String) params.get("content"))
//						.chatSender(client.getMemberId())
//						.chatRoomNo(chatRoomNo)
//						.build());				
//			}
//		}
//		
//	}
}