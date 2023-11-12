package com.kh.springfinal.websocket;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
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
import com.kh.springfinal.dao.ChatOneDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatOneDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.MessageDto;
import com.kh.springfinal.dto.MessageDto.MessageType;
import com.kh.springfinal.service.ClientService;
import com.kh.springfinal.vo.ChatListVO;
import com.kh.springfinal.vo.ChatVO;
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
	
	@Autowired
	private ClientService clientService;
	
	@Autowired
	private ChatOneDao chatOneDao;
	
	
		
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
	
	// 접속 성공
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    ClientVO client = clientService.createClientVO(session);

	    if (client.isMember()) {
	        clients.add(client);

	        for (Integer chatRoomNo : client.getChatRoomNos()) {
	            addRoomMember(client, chatRoomNo);
	        }
	    }
	    log.debug("사용자 접속! 현재 {}명", clients.size());
	}

	
		
	// 접속 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		  ClientVO client = clientService.createClientVO(session);

		    if (client.isMember()) {
		        clients.remove(client);

		        for (Integer chatRoomNo : client.getChatRoomNos()) {
		        	removeRoomMember(client, chatRoomNo);
		        }
		    }

	    log.debug("사용자 종료! 현재 {}명", clients.size());
	    // 다른 로직 추가
	}
	
	// 채팅방 멤버 추가
	public void addRoomMember(ClientVO client, Integer chatRoomNo) {
	    Set<ClientVO> roomMembers = roomMembersMap.computeIfAbsent(chatRoomNo, k -> new HashSet<>());
	    roomMembers.add(client);
	    log.debug("채팅방 멤버 추가 - 채팅방 번호: {}, 멤버 수: {}", chatRoomNo, roomMembers.size());
	}

	// 채팅방 멤버 제거
	public void removeRoomMember(ClientVO client, Integer chatRoomNo) {
	    Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
	    if (roomMembers != null) {
	        roomMembers.remove(client);
	        log.debug("채팅방 멤버 제거 - 채팅방 번호: {}, 멤버 수: {}", chatRoomNo, roomMembers.size());
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
	
//	//접속자 명단(clients)을 모든 접속자에게 전송하는 메소드
//		public void sendClientList() throws IOException {
//			//1. clients를 전송 가능한 형태(JSON 문자열)로 변환한다
//			ObjectMapper mapper = new ObjectMapper();
//
//			Map<String, Object> data = new HashMap<>();
//			//data.put("clients", clients);//전체회원 명단(null이 문제가됨)
//			data.put("roomMembers", roomMembersMap);//로그인한 회원명단
//			String clientJson = mapper.writeValueAsString(data);
//			log.debug("data {}",data);
//			
//			//2. 모든 사용자에게 전송
//			TextMessage message = new TextMessage(clientJson);
//			for(ClientVO client : clients) {
//				client.send(message);
//			}
//		}
	
//	// 채팅방 멤버 명단을 전송하는 메소드
//	public void sendRoomMembersList(Integer chatRoomNo) throws IOException {
//	    // 1. 채팅방 멤버 명단을 전송 가능한 형태(JSON 문자열)로 변환한다
//	    ObjectMapper mapper = new ObjectMapper();
//
//	    List<ChatRoomDto> roomMembers = chatRoomDao.chatRoomMemberList(chatRoomNo); // 채팅방 번호에 해당하는 멤버 명단 가져오기
//
//	    if (roomMembers != null) {
//	        Map<String, Object> data = new HashMap<>();
//	        data.put("roomMembers", roomMembers);
//	        String roomMembersJson = mapper.writeValueAsString(data);
//
//	        // 2. 동호회 멤버에게 전송
//	        TextMessage message = new TextMessage(roomMembersJson);
//
//	            ((ClientVO) roomMembers).send(message);
//
//	    }
//	}
	
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
	        
	        // 각 채팅의 닉네임 가져오기
	        List<ChatVO> roomMembers = chatRoomDao.chatRoomMemberName(chatRoomNo);
	        // chatVO의 clubMemberId와 chatDto의 memberId 비교
	        String chatSenderNickname = roomMembers.stream()
	                .filter(member -> member.getClubMemberId().equals(chatDto.getChatSender()))
	                .findFirst()
	                .map(ChatVO::getMemberName)
	                .orElse(chatDto.getChatSender()); // 닉네임이 없을 경우 memberId 사용

	        map.put("memberName", chatSenderNickname); // 닉네임 추가


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
	    ClientVO client = clientService.createClientVO(session);
	    
	    // 메시지를 JSON으로 파싱
	    ObjectMapper mapper = new ObjectMapper();
	    MessageDto messageDto = mapper.readValue(message.getPayload(), MessageDto.class);

	    // messageType 추출
	    MessageType messageType = messageDto.getMessageType();

	    // messageType에 따라 처리
	    
	    //입장 메세지인 경우
	    if (MessageType.join.equals(messageType)) {
	        Integer chatRoomNo = messageDto.getChatRoomNo();
	        
	        Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
	        log.debug("roomMembers for chatRoomNo {}: {}", chatRoomNo, roomMembers);
	        
	        List<ChatListVO> chatList = chatRoomDao.chatRoomLIst(chatRoomNo);
	        ChatListVO firstChat = chatList.get(0);
	        String clubName = firstChat.getClubName();
	        String clubExplain = firstChat.getClubExplain();
	        
	        // 여기에서 chatRoomNo를 활용하여 처리
	        sendChatHistory(chatRoomNo, session);
	        
	     // sender 정보와 추가 정보(예: 입장하는 사용자의 ID 목록)를 map에 추가하여 전송
	        Map<String, Object> data = new HashMap<>();
	        data.put("messageType", MessageType.join);
	        data.put("chatSender", client.getMemberId());
	        data.put("memberName", client.getMemberName());
	        data.put("clubName", clubName);
	        
	        // roomMembers에 있는 각 ClientVO의 memberId와 memberName을 전송
	        List<Map<String, Object>> membersList = new ArrayList<>();
	        for (ClientVO roomMember : roomMembers) {
	            Map<String, Object> memberData = new HashMap<>();
	            memberData.put("memberId", roomMember.getMemberId());
	            memberData.put("memberName", roomMember.getMemberName());
	            memberData.put("memberLevel", roomMember.getMemberLevel());
	            membersList.add(memberData);
	        }
	        data.put("roomMembers", membersList);
	        
	        String joinMessageJson = mapper.writeValueAsString(data);
	        TextMessage tm = new TextMessage(joinMessageJson);

	        client.send(tm);
	    }
	    
	    // 채팅 메시지인 경우
	    else if (MessageType.message.equals(messageType)) {
	        LocalDateTime chatTime = LocalDateTime.now();
	        
	        Integer chatRoomNo = messageDto.getChatRoomNo();
	        String chatContent = messageDto.getChatContent();
	        String chatSender = messageDto.getChatSender();
	        
	        Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
	        log.debug("roomMembers for chatRoomNo {}: {}", chatRoomNo, roomMembers);
	        
	        if (roomMembers != null) {
	            // 정보를 Map에 담아서 변환 후 전송
	            Map<String, Object> data = new HashMap<>();
	            data.put("messageType", MessageType.message);
	            data.put("memberId", client.getMemberId());
	            data.put("content", chatContent);
	            data.put("chatTime", chatTime.toString());
	            data.put("chatRoomNo", chatRoomNo);
	            data.put("memberLevel", client.getMemberLevel());
	            data.put("memberName", client.getMemberName());
	            
	            String messageJson = mapper.writeValueAsString(data);
	            TextMessage tm = new TextMessage(messageJson);

	            for (ClientVO c : roomMembers) {
	                c.send(tm);
	            }
	           
	            // DB
	            chatDao.insert(ChatDto.builder()
	                    .chatContent(chatContent)
	                    .chatSender(chatSender)
	                    .chatRoomNo(chatRoomNo)
	                    .build());
	        } else {
	            log.warn("roomMembers is null for chatRoomNo {}", chatRoomNo);
	        }
	    }
	    
	    else if (MessageType.dm.equals(messageType)) {
	        LocalDateTime chatTime = LocalDateTime.now();
	        
	        //채팅방을 생성하고 번호를 받아옴
	        Integer chatRoomNo = chatRoomDao.sequence();
	        log.debug("Created new chat room with number: {}", chatRoomNo); // 로그 추가
	        ChatRoomDto chatRoomDto = new ChatRoomDto(); // ChatRoomDto 생성
	        chatRoomDto.setChatRoomNo(chatRoomNo); // 생성된 룸 번호를 ChatRoomDto에 설정
	        chatRoomDao.insert(chatRoomDto); // DB에 넣기

	        
	        //새로운 채팅방 번호를 참여한 사용자들에게 전송
	        Set<ClientVO> roomMembers = roomMembersMap.computeIfAbsent(chatRoomNo, k -> new HashSet<>());
	        roomMembers.add(client);
	        sendChatRoomNumberToClient(chatRoomNo, session);
	        
	        String chatContent = messageDto.getChatContent();
	        String chatSender = messageDto.getChatSender();
	        String chatReceiver = messageDto.getChatReceiver();
	        
	        if (roomMembers != null) {
	            // 정보를 Map에 담아서 변환 후 전송
	            Map<String, Object> data = new HashMap<>();
	            data.put("messageType", MessageType.dm);
	            data.put("memberId", client.getMemberId());
	            data.put("chatReceiver", chatReceiver);
	            data.put("chatRoomNo", chatRoomNo);
	 	        data.put("content", chatContent);
	            data.put("chatTime", chatTime.toString());
	            data.put("memberLevel", client.getMemberLevel());
	            data.put("memberName", client.getMemberName());
	            
	            String messageJson = mapper.writeValueAsString(data);
	            TextMessage tm = new TextMessage(messageJson);

	            for (ClientVO c : roomMembers) {
	                c.send(tm);
	            }
	            
	            //DB
	            chatOneDao.insert(ChatOneDto.builder()
	            		.chatRoomNo(chatRoomNo)
	                    .chatSender(chatSender)
	                    .chatReceiver(chatReceiver)
	            		.build());
	            
	            // DB
	 	        chatDao.insert(ChatDto.builder()
	 	        		.chatContent(chatContent)
	 	        		.chatSender(chatSender)
	 	        		.chatRoomNo(chatRoomNo)
	 	        		.chatReceiver(chatReceiver)
	 	        		.build());
	            
	            log.debug("Inserted chat data into DB for chat room: {}", chatRoomNo); // 로그 추가
	            
	        }
	        
//	        if(chatReceiver != null && chatContent != null) {
//	        	 Map<String, Object> data = new HashMap<>();     
//	        	 
//	 	        // ... (메시지 전송에 필요한 데이터 추가)
//	 	        data.put("messageType", MessageType.dm);
//	 	        data.put("memberId", client.getMemberId());
//	 	        data.put("chatReceiver", chatReceiver);
//	 	        data.put("chatRoomNo", chatRoomNo);
//	 	        data.put("content", chatContent);
//	            data.put("chatTime", chatTime.toString());
//	            data.put("memberLevel", client.getMemberLevel());
//	            data.put("memberName", client.getMemberName());
//	 	        
//	 	       String chatMessageJson = mapper.writeValueAsString(data);
//		        TextMessage tm2 = new TextMessage(chatMessageJson);
//
//		        for (ClientVO c : roomMembers) {
//		            c.send(tm2);
//		        }
//	 	        
//	 	        // DB
//	 	        chatDao.insert(ChatDto.builder()
//	 	        		.chatContent(chatContent)
//	 	        		.chatSender(chatSender)
//	 	        		.chatRoomNo(chatRoomNo)
//	 	        		.chatReceiver(chatReceiver)
//	 	        		.build());
//	        }
	       }
	    }
	
	
	private void sendChatRoomNumberToClient(Integer chatRoomNo, WebSocketSession session) throws IOException {
		Map<String, Object> data = new HashMap<>();
		data.put("messageType", MessageType.dm);
		data.put("chatRoomNo", chatRoomNo);
		
		String chatRoomNumberMessageJson = mapper.writeValueAsString(data);
		TextMessage tm = new TextMessage(chatRoomNumberMessageJson);
		
		session.sendMessage(tm);
	}
	
	
}
	    
//	 // 1:1 채팅인 경우
//	    else if (MessageType.dm.equals(messageType)) {
////	        LocalDateTime chatTime = LocalDateTime.now();
//
//	        String chatReceiver = messageDto.getChatReceiver();
//	        String chatSender = client.getMemberId();
//
//	        // 1:1 채팅 룸이 이미 존재하는지 확인
//	        List<ChatDto> existingChatRooms1 = chatRoomDao.getExistingChatRoom(chatSender, chatReceiver);
//	        List<ChatDto> existingChatRooms2 = chatRoomDao.getExistingChatRoom(chatReceiver, chatSender);
//
//	        if (!existingChatRooms1.isEmpty()) {
//	            // 이미 존재하는 룸에 참여
//	            Integer existingChatRoomNo = existingChatRooms1.get(0).getChatRoomNo();
////	            String chatContent = messageDto.getChatContent();
//
//	            // 채팅 룸에 참여
//	            Set<ClientVO> roomMembers = roomMembersMap.computeIfAbsent(existingChatRoomNo, k -> new HashSet<>());
//	            // 새로 생성된 채팅방 번호를 클라이언트로 전송
//	            Map<String, Object> data = new HashMap<>();
//	            data.put("messageType", MessageType.dm);
//	            data.put("memberId", client.getMemberId());
//	            data.put("chatReceiver", chatReceiver);
//	            data.put("chatRoomNo", existingChatRoomNo);
//	            
//	            String dmMessageJson = mapper.writeValueAsString(data);
//	            TextMessage tm = new TextMessage(dmMessageJson);
//	            
//	            for (ClientVO c : roomMembers) {
//	            	c.send(tm);
//	            
//
//
////	                chatDao.insert(ChatDto.builder()
////	                        .chatContent(chatContent)
////	                        .chatSender(chatSender)
////	                        .chatRoomNo(existingChatRoomNo)
////	                        .chatReceiver(chatReceiver)
////	                        .build());
//	            }
//
//	            // 클라이언트에게 새로 생성된 채팅방 번호 전송
//	            sendChatRoomNumberToClient(existingChatRoomNo, session);
//	            
//	            LocalDateTime chatTime = LocalDateTime.now();
//	            String chatContent = messageDto.getChatContent();
//	                        
//	            data.put("messageType", MessageType.message);
//	            data.put("memberId", client.getMemberId());
//	            data.put("chatReceiver", chatReceiver);
//	            data.put("chatRoomNo", existingChatRoomNo);
//	            data.put("content", chatContent);
//	            data.put("chatTime", chatTime.toString());
//	            data.put("memberLevel", client.getMemberLevel());
//	            data.put("memberName", client.getMemberName());
//	            
//	            String chatMessageJson = mapper.writeValueAsString(data);
//	            TextMessage tm2 = new TextMessage(chatMessageJson);
//
//	            for (ClientVO c : roomMembers) {
//	                c.send(tm2);
//	            }
//	            
//	            chatDao.insert(ChatDto.builder()
//	                    .chatContent(chatContent)
//	                    .chatSender(chatSender)
//	                    .chatRoomNo(existingChatRoomNo)
//	                    .chatReceiver(chatReceiver)
//	                    .build());
//	            
//	        }
//	        
//	        else if (!existingChatRooms2.isEmpty()) {
//	            // 상대가 채팅방을 생성한 경우 해당 채팅방으로 참여
//	            Integer existingChatRoomNo = existingChatRooms2.get(0).getChatRoomNo();
//
////	            // 채팅 룸에 참여
//	            Set<ClientVO> roomMembers = roomMembersMap.computeIfAbsent(existingChatRoomNo, k -> new HashSet<>());
//	            roomMembers.add(client);
//
//	            // 클라이언트에게 새로 생성된 채팅방 번호 전송
//	            sendChatRoomNumberToClient(existingChatRoomNo, session);
//	            
//	        } else {
//	            // 빈 1:1 채팅 룸 생성
//	            Integer newChatRoomNo = chatRoomDao.sequence(); // sequence 메서드로 chatRoomNo 생성
//	            ChatRoomDto chatRoomDto = new ChatRoomDto(); // ChatRoomDto 생성
//	            chatRoomDto.setChatRoomNo(newChatRoomNo); // 생성된 룸 번호를 ChatRoomDto에 설정
//	            chatRoomDao.insert(chatRoomDto); // DB에 넣기
//	            System.out.println("New Chat Room No: " + newChatRoomNo);
//
////	            String chatContent = messageDto.getChatContent();
//
////	            // 채팅 룸에 참여
//	            Set<ClientVO> roomMembers = roomMembersMap.computeIfAbsent(newChatRoomNo, k -> new HashSet<>());
//	            roomMembers.add(client);
//
//	            // 새로 생성된 채팅방 번호를 클라이언트로 전송
//	            Map<String, Object> data = new HashMap<>();
//	            data.put("messageType", MessageType.dm);
//	            data.put("memberId", client.getMemberId());
////	            data.put("content", chatContent);
////	            data.put("chatTime", chatTime.toString());
//	            data.put("chatReceiver", chatReceiver);
////	            data.put("memberLevel", client.getMemberLevel());
////	            data.put("memberName", client.getMemberName());
//	            data.put("chatRoomNo", newChatRoomNo);
//
//	            String dmMessageJson = mapper.writeValueAsString(data);
//	            TextMessage tm = new TextMessage(dmMessageJson);
//
//	            // 해당 사용자에게 메시지 전송
//	            session.sendMessage(tm);
//
//	            // 클라이언트에게 새로 생성된 채팅방 번호 전송
//	            sendChatRoomNumberToClient(newChatRoomNo, session);
//
////	            chatDao.insert(ChatDto.builder()
////	                    .chatContent(chatContent)
////	                    .chatSender(chatSender)
////	                    .chatRoomNo(newChatRoomNo)
////	                    .chatReceiver(chatReceiver)
////	                    .build());
//	            
//	            
//	            LocalDateTime chatTime = LocalDateTime.now();
//	            String chatContent = messageDto.getChatContent();
//	                        
//	            data.put("messageType", MessageType.message);
//	            data.put("memberId", client.getMemberId());
//	            data.put("chatReceiver", chatReceiver);
//	            data.put("chatRoomNo", newChatRoomNo);
//	            data.put("content", chatContent);
//	            data.put("chatTime", chatTime.toString());
//	            data.put("memberLevel", client.getMemberLevel());
//	            data.put("memberName", client.getMemberName());
//	            
//	            String chatMessageJson = mapper.writeValueAsString(data);
//	            TextMessage tm2 = new TextMessage(chatMessageJson);
//
//	            for (ClientVO c : roomMembers) {
//	                c.send(tm2);
//	            }
//	            
//	            chatDao.insert(ChatDto.builder()
//	                    .chatContent(chatContent)
//	                    .chatSender(chatSender)
//	                    .chatRoomNo(newChatRoomNo)
//	                    .chatReceiver(chatReceiver)
//	                    .build());
//	        }
//	    }
//	    
//	}

//	    private void joinChatRoom(Integer existingChatRoomNo, String chatSender, String chatReceiver, WebSocketSession session) throws IOException {
//	    	ClientVO client = clientService.createClientVO(session);
//
//	    	
//	    	// 채팅 룸에 참여
//	        Set<ClientVO> roomMembers = roomMembersMap.computeIfAbsent(existingChatRoomNo, k -> new HashSet<>());
//	        roomMembers.add(client);
//
//	        // 새로 생성된 채팅방 번호를 클라이언트로 전송
//	        Map<String, Object> data = new HashMap<>();
//	        data.put("messageType", MessageType.dm);
//	        data.put("chatSender", chatSender);
//	        data.put("chatReceiver", chatReceiver);
//
//
//	        String dmMessageJson = mapper.writeValueAsString(data);
//	        TextMessage tm = new TextMessage(dmMessageJson);
//
//	        // 해당 사용자에게 메시지 전송
//	        session.sendMessage(tm);
//
//	        // 클라이언트에게 새로 생성된 채팅방 번호 전송
//	        sendChatRoomNumberToClient(existingChatRoomNo, session);
//	    }
	    
	    
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
