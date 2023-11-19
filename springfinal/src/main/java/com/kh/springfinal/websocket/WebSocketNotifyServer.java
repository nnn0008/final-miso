package com.kh.springfinal.websocket;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.springfinal.dao.NotifyDao;
import com.kh.springfinal.dto.NotifyDto;
import com.kh.springfinal.vo.ClientVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WebSocketNotifyServer extends TextWebSocketHandler{
	
		@Autowired
		private NotifyDao notifyDao;

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
//			 log.debug("사용자 접속! 현재 {}명", clientsMap);
		}
		
		//접속 종료
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			ClientVO client = new ClientVO(session);
			clients.remove(client);
			
			String memberId = client.getMemberId();
			clientsMap.remove(memberId, session); //멤버 아이디랑 세션
//			 log.debug("사용자 종료! 현재 {}명", clientsMap);
		}

		
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			ClientVO client = new ClientVO(session);
			log.debug("clientsMap: {}", clientsMap);
			
			ObjectMapper mapper = new ObjectMapper();
			//사용자는 메세지를 JSON 형태로 보내므로 이를 해석해야 한다(ObjectMapper)
            Map params = mapper.readValue(message.getPayload(), Map.class);
            log.debug("msg = {}", params);
            
            String notifyType = (String) params.get("notifyType"); //알림 종류 
            String replyWriterMember = (String) params.get("replyWriterMember"); //댓글 작성자
            String boardWriterMember = (String) params.get("boardWriterMember"); //게시글 작성자
            int boardNo = (int) params.get("boardNo"); //게시판 번호
            String boardTitle = (String) params.get("boardTitle"); //게시판 제목
            String replyWriterName = (String) params.get("replyWriterName"); //댓글 작성자 닉네임
            
            log.debug("notifyType = {}", notifyType);
            log.debug("replyWriterMember = {}", replyWriterMember); 
            log.debug("boardWriterMember = {}", boardWriterMember);
            log.debug("boardNo = {}", boardNo);
            log.debug("boardTitle = {}", boardTitle);
            
//            log.debug("replyWriterMember contains = {}", clientsMap.containsKey(replyWriterMember));
            WebSocketSession replyWriterMemberClient = clientsMap.get(replyWriterMember); //댓글 작성자 세션
            WebSocketSession boardWriterMemberClient = clientsMap.get(boardWriterMember); //게시글 작성자 세션
            log.debug("replyWriterMemberClient={}",replyWriterMemberClient);
            log.debug("boardWriterMemberClient={}",boardWriterMemberClient);

            
//         // 게시글 작성자 세션이 존재하면 메시지 발송
//            if ("reply".equals(notifyType) && replyWriterMemberClient != null) {
//                TextMessage tm = new TextMessage(replyWriterName + "님이 "
//                        + "<a href='/clubBoard/detail?clubBoardNo=" + boardNo + "' class='link-body-emphasis link-underline link-underline-opacity-0' style='color: black'>"
//                        + boardTitle + " 글에 댓글을 달았습니다!</a>");
//
//                try {
//                    boardWriterMemberClient.sendMessage(tm); // 게시글 작성자에게 발송
//                } catch (IOException e) {
//                    log.error("Failed to send message to boardWriterMember", e);
//                }
//            }

            // DB에 알림 저장
            notifyDao.insert(NotifyDto.builder()
                    .notifySender(replyWriterMember) // 댓글 작성자(발신자)
                    .notifyReceiver(boardWriterMember) // 게시글 작성자(수신자)
                    .notifyClubBoardNo(boardNo) // 게시글 번호
                    .notifyClubBoardTitle(boardTitle) // 게시글 제목
                    .notifyType(notifyType) // 알림 종류(reply)
                    .build());

            }

		
}
