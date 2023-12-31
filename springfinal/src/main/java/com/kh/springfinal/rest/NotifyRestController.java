package com.kh.springfinal.rest;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ChatOneDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dao.NotifyDao;
import com.kh.springfinal.dto.ChatOneDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.NotifyDto;
import com.kh.springfinal.vo.ChatListVO;
import com.kh.springfinal.vo.ChatRoomResponseVO;
import com.kh.springfinal.vo.MeetingVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/notify")
public class NotifyRestController {
	
	@Autowired
	private NotifyDao notifyDao;
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@Autowired
	private ChatOneDao chatOneDao;
	

	@GetMapping("/list")
	public List<NotifyDto> notifyList(@RequestParam String notifyReceiver) {
	    List<NotifyDto> list = notifyDao.list(notifyReceiver);	    
	    return list;
	}
	
	@GetMapping("/roomList")
	public ResponseEntity<ChatRoomResponseVO> getRoomListRest(@RequestParam String memberId) {
	    // 해당 사용자가 가지고 있는 동호회 목록 조회
	    List<ChatRoomDto> chatRoomList = chatRoomDao.chatRoomList(memberId);

	    // 해당 사용자가 가지고 있는 1:1룸 목록 조회
	    List<ChatOneDto> oneChatRoomList = chatOneDao.oneChatRoomList(memberId, memberId);
//	    log.debug("oneChatRoomList={}", oneChatRoomList);
	    
	  //해당 사용자가 가지고 있는 정모 목록 조회
	    List<MeetingVO> meetingRoomList = chatRoomDao.meetingRoomList2(memberId); 

	    // 해당 동호회의 번호, 이름, 내용 조회
	    List<ChatListVO> roomList = new ArrayList<>();
	    for (ChatRoomDto chatRoom : chatRoomList) {
	        int chatRoomNo = chatRoom.getChatRoomNo();
	        List<ChatListVO> chatRoomInfoList = chatRoomDao.chatRoomList(chatRoomNo);
	        roomList.addAll(chatRoomInfoList);
	    }

	    ChatRoomResponseVO response = new ChatRoomResponseVO(roomList, oneChatRoomList, meetingRoomList);
	    return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	@GetMapping("/delete")
	public boolean delete(@RequestParam int notifyNo) {
	    boolean result = notifyDao.delete(notifyNo);

	    return result;
	}

	@GetMapping("/notifyOff")
	public boolean notifyOff(@RequestParam String notifyReceiver, @RequestParam boolean isEnabled) {
	    boolean result;
	    if (isEnabled) {
	        result = notifyDao.notifyEnabledOff(notifyReceiver);
//	        System.out.println("Notify Off: " + notifyReceiver);
	    } else {
	        result = notifyDao.notifyEnabledOn(notifyReceiver);
//	        System.out.println("Notify On: " + notifyReceiver);
	    }
	    return result;
	}


}
