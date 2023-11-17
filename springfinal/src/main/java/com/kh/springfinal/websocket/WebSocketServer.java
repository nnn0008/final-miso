package com.kh.springfinal.websocket;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.annotation.PostConstruct;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Base64Utils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.springfinal.configuration.FileUploadProperties;
import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ChatDao;
import com.kh.springfinal.dao.ChatOneDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatOneDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.MessageDto;
import com.kh.springfinal.dto.MessageDto.MessageType;
import com.kh.springfinal.service.ClientService;
import com.kh.springfinal.vo.ChatListVO;
import com.kh.springfinal.vo.ChatOneVO;
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
	
	@Autowired
	private AttachDao attachDao;

    // 초기 디렉터리 설정
    @Autowired
    private FileUploadProperties props;

    private File dir;

    @PostConstruct
    public void init() {
        dir = new File(props.getHome());
        dir.mkdirs();
    }

	//저장소
	private Set<ClientVO> clients = new CopyOnWriteArraySet<>(); //전체 회원(로그인)
	private Map<Integer, Set<ClientVO>> roomMembersMap = new ConcurrentHashMap<>(); // 채팅방 멤버, 채팅방 번호를 키로 사용
	
	
	// 접속 성공
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
//	    log.debug("채팅방 멤버 추가 - 채팅방 번호: {}, 멤버 수: {}", chatRoomNo, roomMembers.size());
	}

	// 채팅방 멤버 제거
	public void removeRoomMember(ClientVO client, Integer chatRoomNo) {
	    Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
	    if (roomMembers != null) {
	        roomMembers.remove(client);
//	        log.debug("채팅방 멤버 제거 - 채팅방 번호: {}, 멤버 수: {}", chatRoomNo, roomMembers.size());
	    }
	}

	// 특정 채팅방 입장 시 이전 메시지 조회 및 전송
	public void sendChatHistory(Integer chatRoomNo, WebSocketSession session) throws IOException {
	    MessageDto messageDto = new MessageDto();
	    // messageType 추출
	    MessageType messageType = messageDto.getMessageType();

	    ClientVO client = clientService.createClientVO(session);
	    String chatSender = client.getMemberId();
	    log.debug("chatSender:{}", chatSender);

	    log.debug("Before executing the query for chatRoomNo {} and chatSender {}", chatRoomNo, chatSender);
	    List<ChatDto> chatHistory = chatDao.getChatHistoryDetail(chatRoomNo, chatSender); // 동호회 채팅 내역
	    List<ChatDto> oneChatHistory = chatOneDao.getChatOnetHistory(chatRoomNo); // 개인 채팅 내역

	    for (ChatDto chatDto : chatHistory) {
	        processChatDto(chatDto, chatRoomNo, session);
	    }

	    for (ChatDto chatDto : oneChatHistory) {
	        processChatDto(chatDto, chatRoomNo, session);
	    }
	}

	private void processChatDto(ChatDto chatDto, Integer chatRoomNo, WebSocketSession session) throws IOException {
	    LocalDateTime chatTime = chatDto.getChatTime();

	    Map<String, Object> map = new HashMap<>();
	    map.put("memberId", chatDto.getChatSender());
	    map.put("chatTime", chatTime.toString());
	    map.put("chatRoomNo", chatRoomNo);

	    if (chatDto.getAttachNo() != 0) {
	        map.put("messageType", "file");
	        map.put("content", "/download?attachNo=" + chatDto.getAttachNo());
	    } else {
	        map.put("content", chatDto.getChatContent());
	    }

	    // 기존 채팅방 멤버의 닉네임 가져오기
	    List<ChatVO> roomMembers = chatRoomDao.chatRoomMemberName(chatRoomNo);

	    // chatVO의 clubMemberId와 chatDto의 memberId 비교
	    String chatSenderNickname = roomMembers.stream()
	            .filter(member -> member.getClubMemberId().equals(chatDto.getChatSender()))
	            .findFirst()
	            .map(ChatVO::getMemberName)
	            .orElse(chatDto.getChatSender()); // 닉네임이 없을 경우 memberId 사용

	    map.put("memberName", chatSenderNickname); // 기존 채팅방 닉네임 추가

	    // 1:1 채팅의 닉네임 및 레벨 가져오기
	    List<ChatOneVO> oneChatMembers = chatOneDao.chatOneMemberName(chatRoomNo);

	    // chatOneVO의 chatSender와 chatDto의 memberId 비교
	    String chatOneSenderNickname = oneChatMembers.stream()
	            .filter(member -> Objects.equals(member.getMemberId(), chatDto.getChatSender()))
	            .findFirst()
	            .map(ChatOneVO::getMemberName)
	            .orElse(chatDto.getChatSender()); // 닉네임이 없을 경우 chatSender 사용

	    String memberLevel = oneChatMembers.stream()
	            .filter(member -> Objects.equals(member.getMemberId(), chatDto.getChatSender()))
	            .findFirst()
	            .map(ChatOneVO::getMemberLevel)
	            .orElse(chatDto.getChatSender()); // 닉네임이 없을 경우 chatSender 사용

	    map.put("oneChatMemberName", chatOneSenderNickname); // 1:1 채팅 닉네임 추가
	    map.put("memberLevel", memberLevel); // 1:1 채팅 레벨 추가

	    String messageJson = mapper.writeValueAsString(map);
	    TextMessage tm = new TextMessage(messageJson);
	    session.sendMessage(tm);
	}


	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    ClientVO client = clientService.createClientVO(session);
	    
	    // 메시지를 JSON으로 파싱
	    ObjectMapper mapper = new ObjectMapper();
	    MessageDto messageDto = mapper.readValue(message.getPayload(), MessageDto.class);
	    
	    log.debug("메세지 유형 = {}", messageDto.getMessageType());

	    // messageType 추출
	    MessageType messageType = messageDto.getMessageType();

	    // messageType에 따라 처리
	    
	    //입장 메세지인 경우
	    if (MessageType.join.equals(messageType)) {
	        
	    	//해당 룸번호를 가져옴 
	    	Integer chatRoomNo = messageDto.getChatRoomNo();
	    	
	    	//해당 룸번호에 해당하는 멤버를 넣는다
	    	Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
	    	log.debug("roomMembers for chatRoomNo {}: {}", chatRoomNo, roomMembers);

	        List<ChatListVO> chatList = chatRoomDao.chatRoomLIst(chatRoomNo);
	        if (!chatList.isEmpty()) {
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
	            else {

	    	        // 여기에서 chatRoomNo를 활용하여 처리
	                sendChatHistory(chatRoomNo, session);
	            	
	            	log.warn("chatList is empty for chatRoomNo {}", chatRoomNo);
	            	
	            }
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
	        
	        String chatSender = messageDto.getChatSender();
	        String chatReceiver = messageDto.getChatReceiver();
	        String chatContent = messageDto.getChatContent();
	        
	        // 1:1 채팅 룸이 이미 존재하는지 확인
	        List<ChatOneDto> existingChatRooms1 = chatOneDao.getExistingChatRoom(chatSender, chatReceiver);
	        List<ChatOneDto> existingChatRooms2 = chatOneDao.getExistingChatRoom(chatReceiver, chatSender);
	        
	        if (!existingChatRooms1.isEmpty()) {
	            ChatOneDto existingChatRoom = existingChatRooms1.get(0);
	            sendChatRoomNumberToClient(existingChatRoom.getChatRoomNo(), session);
	            return;
	        } else if (!existingChatRooms2.isEmpty()) {
	            ChatOneDto existingChatRoom = existingChatRooms2.get(0);
	            sendChatRoomNumberToClient(existingChatRoom.getChatRoomNo(), session);
	            return;
	        }
	        
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
	    }
	    
	    //메세지 타입이 파일일 경우
	    else if (MessageType.file.equals(messageType)) { 
	        log.debug("Entering the file processing block");
	        
	        Integer chatRoomNo = messageDto.getChatRoomNo();
	        String chatContent = messageDto.getChatContent();
	        String chatSender = messageDto.getChatSender();
	        String fileName = messageDto.getFileName();
	        long fileSize = messageDto.getFileSize();
	        String fileType = messageDto.getFileType(); 
	        
//	        log.debug("chatRoomNo: {}, chatContent: {}, chatSender: {}, fileName: {}, fileSize: {}, fileType: {}", 
//	                chatRoomNo, chatContent, chatSender, fileName, fileSize, fileType);
				       
            //뒷부분이 실제 이미지 파일내용이므로 제거한 다음 분석하도록 처리
            String[] slice = messageDto.getChatContent().split(",");
            byte[] data = Base64Utils.decodeFromString(slice[1]);
            LocalDateTime chatTime = LocalDateTime.now();
                           
            //분석한 내용을 저장
			//- 이 부분에 데이터베이스 저장 및 시퀀스 생성을 통한 파일명 설정 코드가 있어야 함
            int attachNo = attachDao.sequence(); // 시퀀스 번호 생성
            
            //시퀀스 번호를 파일명으로 하여 실제 파일 저장
            File target = new File(dir, String.valueOf(attachNo));
            try(FileOutputStream out = new FileOutputStream(target)) {
				out.write(data);
			}
            
            //DB에 저장한 파일 정보 모아서 insert
            AttachDto attachDto = new AttachDto();
            attachDto.setAttachNo(attachNo); //실제 저장된 이름
            attachDto.setAttachName(fileName); //사용자가 저장한 이름
            attachDto.setAttachSize(fileSize);
            attachDto.setAttachType(fileType);
            attachDao.insert(attachDto);
            
         // DB
            if (attachNo != 0) {
                chatDao.insert(ChatDto.builder()
                        .chatSender(chatSender)
                        .chatRoomNo(chatRoomNo)
                        .attachNo(attachNo)
                        .build());
            } else {
                chatDao.insert(ChatDto.builder()
                        .chatSender(chatSender)
                        .chatRoomNo(chatRoomNo)
                        .build());
            }

            Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
            log.debug("roomMembers for chatRoomNo {}: {}", chatRoomNo, roomMembers);
            
            if (roomMembers != null) {
            Map<String, Object> FileChat = new HashMap<>();
            FileChat.put("messageType", MessageType.file);
            FileChat.put("memberId", client.getMemberId());
            FileChat.put("content", "/download?attachNo=" + attachNo); // 파일 다운로드를 알리는 채팅 내용
            FileChat.put("chatTime", chatTime.toString());
            FileChat.put("chatRoomNo", chatRoomNo);
            FileChat.put("memberLevel", client.getMemberLevel());
            FileChat.put("memberName", client.getMemberName());
                           
            String messageJson = mapper.writeValueAsString(FileChat);
            TextMessage tm = new TextMessage(messageJson);
            
            for (ClientVO c : roomMembers) {
                c.send(tm);
            }
         }
            
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
