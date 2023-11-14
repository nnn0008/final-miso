package com.kh.springfinal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.WebSocketSession;

import com.kh.springfinal.dao.ChatOneDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dto.ChatOneDto;
import com.kh.springfinal.vo.ClientVO;

@Service
public class ClientService {
	
	@Autowired
    private ChatRoomDao chatRoomDao;

	@Autowired
	private ChatOneDao chatOneDao;
	
    public ClientVO createClientVO(WebSocketSession session) {
        ClientVO client = new ClientVO(session);
        initializeChatRooms(client);
        return client;
    }

    private void initializeChatRooms(ClientVO client) {
        List<Integer> chatRooms = chatRoomDao.selectRoomNoByMemberId(client.getMemberId());
        
     // 사용자가 참여하고 있는 1:1 채팅방 목록을 가져옴
        List<ChatOneDto> oneChatRooms = chatOneDao.oneChatRoomList(client.getMemberId(), client.getMemberId());
        
        if (chatRooms != null) {
            // 기존의 chatRooms에 1:1 채팅방 목록을 추가
            for (ChatOneDto oneChatRoom : oneChatRooms) {
                chatRooms.add(oneChatRoom.getChatRoomNo());
            }
            client.getChatRoomNos().addAll(chatRooms);
        }
    }
   }
