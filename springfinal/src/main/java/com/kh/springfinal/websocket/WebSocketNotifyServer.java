package com.kh.springfinal.websocket;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

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
public class WebSocketNotifyServer extends TextWebSocketHandler{

	//저장소
		private Set<ClientVO> clients = new CopyOnWriteArraySet<>(); //전체 회원(로그인)
		private Map<String, WebSocketSession> clientsMap = new ConcurrentHashMap<>(); //1:1로 할 경우
		
		//접속 성공
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			ClientVO client = new ClientVO(session);
			clients.add(client);
			
			String memberId = client.getMemberId();
			clientsMap.put(memberId, session); //멤버 아이디랑 세션
			 log.debug("사용자 접속! 현재 {}명", clientsMap);
		}
		
		
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			ClientVO client = new ClientVO(session);
			log.debug("clientsMap: {}", clientsMap);
			
			ObjectMapper mapper = new ObjectMapper();
			//사용자는 메세지를 JSON 형태로 보내므로 이를 해석해야 한다(ObjectMapper)
            Map params = mapper.readValue(message.getPayload(), Map.class);
            log.debug("msg = {}", params);
            
            String notifyType = (String) params.get("notifyType");
            String replyWriterMember = (String) params.get("replyWriterMember");
            String boardWriterMember = (String) params.get("boardWriterMember");
            int boardNo = (int) params.get("boardNo");
            String boardTitle = (String) params.get("boardTitle");
            String replyWriterName = (String) params.get("replyWriterName");
            
            log.debug("notifyType = {}", notifyType);
            log.debug("replyWriterMember = {}", replyWriterMember);
            log.debug("boardWriterMember = {}", boardWriterMember);
            log.debug("boardNo = {}", boardNo);
            log.debug("boardTitle = {}", boardTitle);
            
//            log.debug("replyWriterMember contains = {}", clientsMap.containsKey(replyWriterMember));
            WebSocketSession replyWriterMemberClient = clientsMap.get(replyWriterMember);
            WebSocketSession boardWriterMemberClient = clientsMap.get(boardWriterMember);
            log.debug("replyWriterMemberClient={}",replyWriterMemberClient);
            log.debug("boardWriterMemberClient={}",boardWriterMemberClient);


            if("reply".equals(notifyType) && replyWriterMemberClient != null) {
            	TextMessage tm = new TextMessage(replyWriterName + "님이 "
						+ "<a href='/clubBoard/detail?clubBoardNo="+ boardNo +"' style=\"color: black\">"
						+ boardTitle+" 글에 댓글을 달았습니다!</a>");
            	
            	boardWriterMemberClient.sendMessage(tm);

            }
						
		}

		//접속 종료
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			ClientVO client = new ClientVO(session);
			clients.remove(client);
			String memberId = client.getMemberId();
			Set<ClientVO> clientSet = new HashSet<>();
			clientsMap.remove(memberId, clientSet);
			 log.debug("사용자 접속! 현재 {}명", clients.size());
		}

		
}
