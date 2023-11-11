package com.kh.springfinal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.WebSocketSession;

import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.vo.ClientVO;

@Service
public class ClientService {
	
	@Autowired
    private ChatRoomDao chatRoomDao;

    public ClientVO createClientVO(WebSocketSession session) {
        ClientVO client = new ClientVO(session);
        initializeChatRooms(client);
        return client;
    }

    private void initializeChatRooms(ClientVO client) {
        List<Integer> chatRooms = chatRoomDao.selectRoomNoByMemberId(client.getMemberId());
        if (chatRooms != null) {
            client.getChatRoomNos().addAll(chatRooms);
        }
    }

}
