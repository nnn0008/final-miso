package com.kh.springfinal.websocket;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.stream.Collectors;

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
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.MeetingDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.MemberProfileDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatOneDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.MeetingDto;
import com.kh.springfinal.dto.MemberDto;
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
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private MemberProfileDao profileDao;
	
	@Autowired
	private MeetingDao meetingDao;
	
	@Autowired
	private MemberDao memberDao;

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
	private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	
	// 접속 성공
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		 ClientVO client = new ClientVO(session);
		clients.add(client);

		log.debug("사용자 접속 {}명", clients.size());
	}
	

	// 접속 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    // 해당 세션을 찾아서 제거
	    Iterator<Map<String, Object>> iterator = sessionList.iterator();
	    while (iterator.hasNext()) {
	        Map<String, Object> mapSessionList = iterator.next();
	        WebSocketSession existingSession = (WebSocketSession) mapSessionList.get("session");
	        if (existingSession.getId().equals(session.getId())) {
	            // 세션을 찾았으므로 제거
	            iterator.remove();
	            
	            Integer chatRoomNo = (Integer) mapSessionList.get("chatRoomNo");
	            log.debug("사용자 종료! 현재 {}명", sessionList.size());
	            
	            break;
	        }
	    }
	}
//	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//	    Iterator<ClientVO> iterator = clients.iterator();
//	    while (iterator.hasNext()) {
//	        ClientVO client = iterator.next();
//	        WebSocketSession existingSession = client.getSession();
//	        if (existingSession.getId().equals(session.getId())) {
//	            // 세션을 찾았으므로 제거
//	            iterator.remove();
//
//	            log.debug("사용자 종료! 현재 {}명", clients.size());
//
//	            break;
//	        }
//	    }
//	}


	// 특정 채팅방 입장 시 이전 메시지 조회 및 전송
	public void sendChatHistory(Integer chatRoomNo, WebSocketSession session) throws IOException {

	    ClientVO client = clientService.createClientVO(session);
	    String chatSender = client.getMemberId();
	    log.debug("chatSender:{}", chatSender);
	    
	    log.debug("Before executing the query for chatRoomNo {} and chatSender {}", chatRoomNo, chatSender);
	    List<ChatDto> chatHistory = chatDao.getChatHistoryDetail(chatRoomNo, chatSender); // 동호회 채팅 내역
	    List<ChatDto> oneChatHistory = chatOneDao.getChatOnetHistory(chatRoomNo); // 개인 채팅 내역
	    List<ChatDto> meetingChatHistory = chatDao.getMeetingHistory(chatRoomNo, chatSender); //정모 채팅 내역
	    
//	    List<ChatDto> chatHistoryReset = chatDao.getChatHistoryAfterDate(chatRoomNo, chatSender, targetTime);

	    for (ChatDto chatDto : chatHistory) {
	        processChatDto(chatDto, chatRoomNo, session);
	    }

	    for (ChatDto chatDto : oneChatHistory) {
	        processChatDto(chatDto, chatRoomNo, session);
	    }
	    
	    for(ChatDto chatDto : meetingChatHistory) {
	    	processChatDto(chatDto, chatRoomNo, session);
	    }
	}

	private void processChatDto(ChatDto chatDto, Integer chatRoomNo, WebSocketSession session) throws IOException {

		LocalDateTime chatTime = chatDto.getChatTime();

		AttachDto profileImage = profileDao.profileFindOne(chatDto.getChatSender());
        String profileImageUrl = null;
        
        if(profileImage != null) {
        	profileImageUrl = "/getProfileImage?memberId=" + chatDto.getChatSender();
        }
		
        
	    Map<String, Object> map = new HashMap<>();
	    map.put("memberId", chatDto.getChatSender());
	    map.put("chatTime", chatTime.toString());
	    map.put("chatRoomNo", chatRoomNo);
	    map.put("chatNo", chatDto.getChatNo());
	    map.put("chatBlind", chatDto.getChatBlind());

	    if(profileImageUrl != null) {
	    	map.put("profileImageUrl", profileImageUrl);
        }
	    
	    if ("Y".equals(chatDto.getChatBlind())) {
	        map.put("content", "삭제된 메시지입니다");
	    } else {
	        if (chatDto.getAttachNo() != 0) {
	            map.put("messageType", "file");
	            map.put("content", "/download?attachNo=" + chatDto.getAttachNo());
	        } else {
	            map.put("content", chatDto.getChatContent());
	        }
	    }
	 // 기존 채팅방 멤버의 닉네임 가져오기
	    List<ChatVO> roomMembers = chatRoomDao.chatRoomMemberName(chatRoomNo);

	    // chatVO의 clubMemberId와 chatDto의 memberId 비교
	    String chatSenderNickname = roomMembers.stream()
	            .filter(member -> member.getClubMemberId().equals(chatDto.getChatSender()))
	            .findFirst()
	            .map(ChatVO::getMemberName)
	            .orElse(null); // 닉네임이 없을 경우 null 사용

	    if (chatSenderNickname != null) {
	        map.put("memberName", chatSenderNickname); // 기존 채팅방 닉네임 추가
	    }

	    // 1:1 채팅의 닉네임 및 레벨 가져오기
	    List<ChatOneVO> oneChatMembers = chatOneDao.chatOneMemberName(chatRoomNo);

	    // chatOneVO의 chatSender와 chatDto의 memberId 비교
	    String chatOneSenderNickname = oneChatMembers.stream()
	            .filter(member -> Objects.equals(member.getMemberId(), chatDto.getChatSender()))
	            .findFirst()
	            .map(ChatOneVO::getMemberName)
	            .orElse(null); // 닉네임이 없을 경우 null 사용

	    String memberLevel = oneChatMembers.stream()
	            .filter(member -> Objects.equals(member.getMemberId(), chatDto.getChatSender()))
	            .findFirst()
	            .map(ChatOneVO::getMemberLevel)
	            .orElse(null); // 닉네임이 없을 경우 null 사용

	    if (chatOneSenderNickname != null) {
	        map.put("oneChatMemberName", chatOneSenderNickname); // 1:1 채팅 닉네임 추가
	    }
	    if (memberLevel != null) {
	        map.put("memberLevel", memberLevel); // 1:1 채팅 레벨 추가
	    }

	    // 동호회 채팅의 닉네임 가져오기
	    List<ChatVO> meetingRoomMembers = chatRoomDao.meetingRoomMemberName(chatRoomNo);
	    String meetingSenderName = meetingRoomMembers.stream()
	            .filter(member -> member.getClubMemberId().equals(chatDto.getChatSender()))
	            .findFirst()
	            .map(ChatVO::getMemberName)
	            .orElse(null); // 닉네임이 없을 경우 null 사용

	    if (meetingSenderName != null) {
	        map.put("meetingMemberName", meetingSenderName); // 닉네임 추가
	    }

	    String messageJson = mapper.writeValueAsString(map);
	    TextMessage tm = new TextMessage(messageJson);
	    session.sendMessage(tm);
	}
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		ClientVO client = new ClientVO(session);
	    // 메시지를 JSON으로 파싱
	    ObjectMapper mapper = new ObjectMapper();
	    MessageDto messageDto = mapper.readValue(message.getPayload(), MessageDto.class);
	    
	    log.debug("메세지 유형 = {}", messageDto.getMessageType());

	    // messageType 추출
	    MessageType messageType = messageDto.getMessageType();

	   //messageType에 따라 처리
	 // 입장 메세지인 경우
	    if (MessageType.join.equals(messageType)) {
	        // 해당 룸번호를 가져옴 
	        Integer chatRoomNo = messageDto.getChatRoomNo();
	        String memberId = client.getMemberId();
	        
	        //map에 룸번호, 세션 정보를 담는다
	        Map<String, Object> map = new HashMap<>();
	        map.put("chatRoomNo", chatRoomNo);        
	        map.put("session", session);
	        map.put("memberId", memberId);
	        sessionList.add(map);

	        List<String> memberIds = new ArrayList<>();
	        for (Map<String, Object> mapSessionList : sessionList) {
	            String memberIdToAdd = (String) mapSessionList.get("memberId");
	            memberIds.add(memberIdToAdd);
	        }
	        
	        System.out.println("Current sessionList: " + sessionList);
	        
	     // 채팅 목록을 검색
	        List<ChatListVO> chatList = chatRoomDao.chatRoomList(chatRoomNo);
	        List<MeetingDto> meetingList = chatRoomDao.fineMeetingRoomList(chatRoomNo);

	        if (!chatList.isEmpty()) {
	            // 그룹 채팅일 경우
//	            ChatListVO firstChat = chatList.get(0);
//	            String clubName = firstChat.getClubName();
//	            String clubExplain = firstChat.getClubExplain();

	            // 여기에서 chatRoomNo를 활용하여 처리
	            // 채팅 내역이 있을 경우에만 채팅 내역을 전송
	            sendChatHistory(chatRoomNo, session);

	            // 기존 코드와 동일하게 처리
	            for (Map<String, Object> mapSessionList : sessionList) {
	                Integer roomNo = (Integer) mapSessionList.get("chatRoomNo");
	                WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");

	                if (roomNo.equals(chatRoomNo)) {
	                    Map<String, Object> mapToSend = new HashMap<>();
	                    mapToSend.put("chatRoomNo", roomNo.toString());
	                    mapToSend.put("chatSender", client.getMemberId());
	                    mapToSend.put("memberName", client.getMemberName());
//	                    mapToSend.put("clubName", clubName);
//	                    mapToSend.put("clubExplain", clubExplain);
	                    mapToSend.put("messageType", MessageType.join);
	                    mapToSend.put("memberLevel", client.getMemberLevel());
	                    // memberId 리스트 추가
	                    mapToSend.put("memberIds", memberIds);

	                    String joinMessageJson = mapper.writeValueAsString(mapToSend);
	                    TextMessage tm = new TextMessage(joinMessageJson);

	                    sess.sendMessage(tm);
	                }
	            }
	        } else if (!meetingList.isEmpty()) {
	            // 모임 채팅일 경우
	            MeetingDto firstMeeting = meetingList.get(0);
	            String meetingName = firstMeeting.getMeetingName();
	            // 기타 모임 정보 필요한 경우에도 추가
	            MemberDto memberDto = memberDao.loginId(memberId);

	            // 여기에서 필요한 모임 채팅 정보를 전송하는 로직을 추가
	            sendChatHistory(chatRoomNo, session);

	            // 모임 채팅 정보를 클라이언트에게 전송
	            Map<String, Object> meetingChatMessage = new HashMap<>();
	            meetingChatMessage.put("messageType", MessageType.join);
	            meetingChatMessage.put("meetingName", meetingName);
	            meetingChatMessage.put("memberId", memberId);
	            meetingChatMessage.put("memberIds", memberIds);
	            meetingChatMessage.put("memberName", memberDto.getMemberName());

	            String meetingChatJson = mapper.writeValueAsString(meetingChatMessage);
	            TextMessage meetingChatMessages = new TextMessage(meetingChatJson);

	            session.sendMessage(meetingChatMessages);
	        } else {
	            // 개인 채팅일 경우
	            
	        	sendChatHistory(chatRoomNo, session);
	        	
	        	Map<String, Object> chatOneMessage = new HashMap<>();
	        	chatOneMessage.put("chatSender", memberId);
	        	chatOneMessage.put("messageType", MessageType.join);
	        	chatOneMessage.put("memberIds", memberIds);
	        	
	        	 String OneChatJson = mapper.writeValueAsString(chatOneMessage);
		           TextMessage chatOneMessages = new TextMessage(OneChatJson);

		            session.sendMessage(chatOneMessages);
	        }
	    }
	    
//	    //messageType에 따라 처리
//		 // 입장 메세지인 경우
//		    if (MessageType.join.equals(messageType)) {
//		        // 해당 룸번호를 가져옴 
//		        Integer chatRoomNo = messageDto.getChatRoomNo();
//		        String memberId = client.getMemberId();
//		        
//		        //map에 룸번호, 세션 정보를 담는다
//		        Map<String, Object> map = new HashMap<>();
//		        map.put("chatRoomNo", chatRoomNo);        
//		        map.put("session", session);
//		        map.put("memberId", memberId);
//		        sessionList.add(map);
//
//		        List<String> memberIds = new ArrayList<>();
//		        for (Map<String, Object> mapSessionList : sessionList) {
//		            String memberIdToAdd = (String) mapSessionList.get("memberId");
//		            memberIds.add(memberIdToAdd);
//		        }
//		        
//		        System.out.println("Current sessionList: " + sessionList);
//		        
//		        //채팅 목록을 검색
//		        List<ChatListVO> chatList = chatRoomDao.chatRoomList(chatRoomNo);
////		        List<MeetingDto> meetingList = chatRoomDao.fineMeetingRoomList(chatRoomNo);
//
//		        if (!chatList.isEmpty()) {
//		            ChatListVO firstChat = chatList.get(0);
//		            String clubName = firstChat.getClubName();
//		            String clubExplain = firstChat.getClubExplain();
//
//		            // 여기에서 chatRoomNo를 활용하여 처리
//		            // 채팅 내역이 있을 경우에만 채팅 내역을 전송
//		            sendChatHistory(chatRoomNo, session);
//
//		            // 기존 코드와 동일하게 처리
//		            for (Map<String, Object> mapSessionList : sessionList) {
//		                Integer roomNo = (Integer) mapSessionList.get("chatRoomNo");
//		                WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
//		                
//		                if (roomNo.equals(chatRoomNo)) {
//		                    Map<String, Object> mapToSend = new HashMap<>();
//		                    mapToSend.put("chatRoomNo", roomNo.toString());
//		                    mapToSend.put("chatSender", client.getMemberId());
//		                    mapToSend.put("memberName", client.getMemberName());
//		                    mapToSend.put("clubName", clubName);
//		                    mapToSend.put("clubExplain", clubExplain);
//		                    mapToSend.put("messageType", MessageType.join);
//		                    mapToSend.put("memberLevel", client.getMemberLevel());
////		                    mapToSend.put("clubMemberRank", clubMemberRank);
//		                    
//		                 // memberId 리스트 추가
//		                    mapToSend.put("memberIds", memberIds);
//		                    
//		                    String joinMessageJson = mapper.writeValueAsString(mapToSend);
//		                    TextMessage tm = new TextMessage(joinMessageJson);
//
//		                    sess.sendMessage(tm);
//		                }
//
//		            }
//		        } else {
//		            // 채팅 내역이 없을 때의 처리
//		            log.debug("chatList is empty for chatRoomNo {}", chatRoomNo);
//		            
//		            // 여기에서 chatRoomNo를 활용하여 처리
//		            sendChatHistory(chatRoomNo, session);
//		        }
//		    }
	   
	 // 채팅 메시지인 경우
	    else if (MessageType.message.equals(messageType)) {
	        LocalDateTime chatTime = LocalDateTime.now();
	        
	        Integer chatRoomNo = messageDto.getChatRoomNo();
	        String chatContent = messageDto.getChatContent();
	        String chatSender = messageDto.getChatSender();
	        
	        AttachDto profileImage = profileDao.profileFindOne(chatSender);
	        String profileImageUrl = null;
	        
	        if(profileImage != null) {
	        	profileImageUrl = "/getProfileImage?memberId=" + chatSender;
	        }
	        
	        //채팅 삭제 업데이트를 위한
	        String chatBlind = "N";
	        int chatNo = chatDao.sequence();
	        
	        // Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
	        List<Map<String, Object>> targetSessions = sessionList.stream()
	                .filter(map -> map.get("chatRoomNo").equals(chatRoomNo))
	                .collect(Collectors.toList());

	        // log.debug("roomMembers for chatRoomNo {}: {}", chatRoomNo, roomMembers);
	        log.debug("Target sessions for chatRoomNo {}: {}", chatRoomNo, targetSessions);

	        if (!targetSessions.isEmpty()) {
	            // 정보를 Map에 담아서 변환 후 전송
	            Map<String, Object> data = new HashMap<>();
	            data.put("messageType", MessageType.message);
	            data.put("memberId", client.getMemberId());
	            data.put("content", chatContent);
	            data.put("chatTime", chatTime.toString());
	            data.put("chatRoomNo", chatRoomNo);
	            data.put("memberLevel", client.getMemberLevel());
	            data.put("memberName", client.getMemberName());
	            data.put("chatBlind", chatBlind);
	            data.put("chatNo", chatNo);
	            
	            if(profileImageUrl != null) {
	            	data.put("profileImageUrl", profileImageUrl);
	            }
	            
	            String messageJson = mapper.writeValueAsString(data);
	            TextMessage tm = new TextMessage(messageJson);

	            for (Map<String, Object> targetSessionMap : targetSessions) {
	                WebSocketSession targetSession = (WebSocketSession) targetSessionMap.get("session");
	                targetSession.sendMessage(tm);
	            }

	            // DB
	            chatDao.insert(ChatDto.builder()
	                    .chatNo(chatNo)
	                    .chatContent(chatContent)
	                    .chatSender(chatSender)
	                    .chatRoomNo(chatRoomNo)
	                    .build());
	        } else {
	            log.debug("No target sessions for chatRoomNo {}", chatRoomNo);
	        }
	    }

	    else if (MessageType.dm.equals(messageType)) {
	        LocalDateTime chatTime = LocalDateTime.now();
	        
	        String chatSender = messageDto.getChatSender();
	        String chatReceiver = messageDto.getChatReceiver();
	        String chatContent = messageDto.getChatContent();
	        
	        AttachDto profileImage = profileDao.profileFindOne(chatSender);
	        String profileImageUrl = null;
	        
	        if(profileImage != null) {
	        	profileImageUrl = "/getProfileImage?memberId=" + chatSender;
	        }
	        
	        //채팅 삭제 업데이트를 위한
	        String chatBlind = "N";
	        int chatNo = chatDao.sequence();
	        
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
	            data.put("chatBlind", chatBlind);
	            data.put("chatNo", chatNo);
	            
	            if(profileImageUrl != null) {
	            	data.put("profileImageUrl", profileImageUrl);
	            }
	            
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
	 	        		.chatNo(chatNo)
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
	        
	        AttachDto profileImage = profileDao.profileFindOne(chatSender);
	        String profileImageUrl = null;
	        
	        if(profileImage != null) {
	        	profileImageUrl = "/getProfileImage?memberId=" + chatSender;
	        }
	        
	        //채팅 삭제 업데이트를 위한
	        String chatBlind = "N";
	        int chatNo = chatDao.sequence();
	        
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
                		.chatNo(chatNo)
                        .chatSender(chatSender)
                        .chatRoomNo(chatRoomNo)
                        .attachNo(attachNo)
                        .build());
            } else {
                chatDao.insert(ChatDto.builder()
                		.chatNo(chatNo)
                        .chatSender(chatSender)
                        .chatRoomNo(chatRoomNo)
                        .build());
            }
         }
            
            List<Map<String, Object>> targetSessions = sessionList.stream()
	                .filter(map -> map.get("chatRoomNo").equals(chatRoomNo))
	                .collect(Collectors.toList());

	        log.debug("Target sessions for chatRoomNo {}: {}", chatRoomNo, targetSessions);
	        
            if (!targetSessions.isEmpty()) {
            Map<String, Object> FileChat = new HashMap<>();
            FileChat.put("messageType", MessageType.file);
            FileChat.put("memberId", client.getMemberId());
            FileChat.put("content", "/download?attachNo=" + attachNo); // 파일 다운로드를 알리는 채팅 내용
            FileChat.put("chatTime", chatTime.toString());
            FileChat.put("chatRoomNo", chatRoomNo);
            FileChat.put("memberLevel", client.getMemberLevel());
            FileChat.put("memberName", client.getMemberName());
            FileChat.put("chatBlind", chatBlind);
            FileChat.put("chatNo", chatNo);
            
            if(profileImageUrl != null) {
            	FileChat.put("profileImageUrl", profileImageUrl);
            }
                           
            String messageJson = mapper.writeValueAsString(FileChat);
            TextMessage tm = new TextMessage(messageJson);
            
            for (Map<String, Object> targetSessionMap : targetSessions) {
                WebSocketSession targetSession = (WebSocketSession) targetSessionMap.get("session");
                targetSession.sendMessage(tm);
            }
         }
            
	    }	
	    
	    else if (MessageType.delete.equals(messageType)) {
	        int chatRoomNo = messageDto.getChatRoomNo();
	        int chatNo = messageDto.getChatNo();

	        // 업데이트 수행 및 업데이트된 chatBlind 값 조회
	        boolean chatBlindUpdated = chatDao.chatBlindUpdate(chatNo);
	        String chatBlind = chatDao.chatBliindCheck(chatNo);
	        	        
	        List<Map<String, Object>> targetSessions = sessionList.stream()
	                .filter(map -> map.get("chatRoomNo").equals(chatRoomNo))
	                .collect(Collectors.toList());

	        log.debug("Target sessions for chatRoomNo {}: {}", chatRoomNo, targetSessions);

	        if (!targetSessions.isEmpty()) {
	            // 정보를 Map에 담아서 변환 후 전송
	            Map<String, Object> data = new HashMap<>();
	            data.put("messageType", MessageType.delete.toString());
	            data.put("chatNo", chatNo);
	            data.put("chatBlind", chatBlind);

//	            // 업데이트된 chatBlind에 따라 content 설정
//	            if ("Y".equals(chatBlind)) {
//	                data.put("content", "삭제된 메시지입니다");
//	            } 
	            
	            String messageJson = mapper.writeValueAsString(data);
	            TextMessage tm = new TextMessage(messageJson);

	            for (Map<String, Object> targetSessionMap : targetSessions) {
	                WebSocketSession targetSession = (WebSocketSession) targetSessionMap.get("session");
	                targetSession.sendMessage(tm);
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
