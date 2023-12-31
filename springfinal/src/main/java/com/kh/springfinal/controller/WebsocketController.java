package com.kh.springfinal.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.springfinal.dao.ChatDao;
import com.kh.springfinal.dao.ChatOneDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dto.ChatDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.vo.ChatListVO;
import com.kh.springfinal.vo.ChatMemberListVO;
import com.kh.springfinal.vo.ChatOneMemberListVO;
import com.kh.springfinal.vo.ChatOneMemberVO;
import com.kh.springfinal.vo.ClubImageVO;
import com.kh.springfinal.vo.MeetingVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class WebsocketController {
	
	@Autowired
	private ChatRoomDao chatRoomDao;	
		
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private ChatDao chatDao;
	
	@Autowired
	private ChatOneDao chatOneDao;
	
	private int chatRoomNo = 0;
	
//	@RequestMapping("/chat")
//	public String chat() {
//		return "chat/sockjs2";
//	}
	
	//채팅방 리스트
	@RequestMapping("/roomList")
	public String getRoomList(Model model, HttpSession session) {
	    // 세션에서 로그인한 사용자의 아이디를 가져옴
	    String memberId = (String) session.getAttribute("name");

	    // 해당 사용자가 가지고 있는 동호회 목록 조회
	    List<ChatRoomDto> chatRoomList = chatRoomDao.chatRoomList(memberId);
	    // 해당 사용자가 가지고 있는 1:1룸 목록 조회
	    List<ChatOneMemberVO> oneChatRoomList = chatOneDao.oneChatRoomList2(memberId, memberId);
	    // 해당 사용자가 가지고 있는 정모 목록 조회
	    List<MeetingVO> meetingRoomList = chatRoomDao.meetingRoomList2(memberId);


	 // 해당 동호회의 번호, 이름, 내용 조회
	 List<ChatListVO> roomList = new ArrayList<>();
	 for (ChatRoomDto chatRoom : chatRoomList) {
	     int chatRoomNo = chatRoom.getChatRoomNo();
	     List<ChatListVO> chatRoomInfoList = chatRoomDao.chatRoomList(chatRoomNo);
	     roomList.addAll(chatRoomInfoList);
	 }


	    // model.addAttribute("list", chatRoomList);
	    model.addAttribute("roomList", roomList);
	    model.addAttribute("oneChatRoomList", oneChatRoomList);
	    model.addAttribute("meetingRoomList", meetingRoomList);
	    // model.addAttribute("lastMessage", lastMessage);

	    return "chat/roomList";
	}

	
	//채팅방
	@GetMapping("/enterRoom/{chatRoomNo}")
	public String enterRoom(@PathVariable int chatRoomNo, Model model, HttpSession session) {
	    ClubDto clubInfo = chatRoomDao.clubInfo(chatRoomNo);
	    List<ChatMemberListVO> members = chatRoomDao.chatMemberList(chatRoomNo);
	    ChatOneMemberListVO oneMembers = chatRoomDao.oneMembers(chatRoomNo);
	    List<ChatMemberListVO> meetingMembers = chatRoomDao.meetingMemberList(chatRoomNo);

	        if(clubInfo != null) {	        	
	        	int clubNo = clubInfo.getClubNo(); // 클럽번호 가져오기
	        	ClubImageVO clubDto = clubDao.clubDetail(clubNo);
	        	// 상단 바로가기 메뉴
	        	model.addAttribute("clubDto", clubDto);
	        	
	        }
	        
	        String circleName = null;
	        if (clubInfo != null && clubInfo.getClubName() != null) {
	            circleName = clubInfo.getClubName();
	        } else {
	            String sessionName = (String) session.getAttribute("name");
	            String chatSender = oneMembers != null ? oneMembers.getChatSender() : null;
	            String chatReceiver = oneMembers != null ? oneMembers.getChatReceiver() : null;
	            String meetingName = null;

	            if (chatSender != null && chatReceiver != null) {
	                if (chatSender.equals(sessionName)) {
	                    circleName = chatReceiver;
	                } else if (chatReceiver.equals(sessionName)) {
	                    circleName = chatSender;
	                }
	            }

	            if (meetingMembers != null && !meetingMembers.isEmpty()) {
	                meetingName = meetingMembers.get(0).getMeetingName();
	            }
	            
	            if (circleName == null) {
	                circleName = meetingName;
	            }
	        }
	        model.addAttribute("circleName", circleName);

	        
	        model.addAttribute("meetingMembers", meetingMembers);
	        model.addAttribute("clubInfo", clubInfo);
	        model.addAttribute("members", members);
	        model.addAttribute("oneMembers", oneMembers);
	        
	        
	        return "chat/sockjs2";

	}

	
	// 룸번호에 해당하는 이전 메시지 조회
    @GetMapping("/fetchChatHistory")
    @ResponseBody
    public List<ChatDto> fetchChatHistory(@RequestParam Integer chatRoomNo) {
        return chatDao.getChatHistory(chatRoomNo);
    }
}
