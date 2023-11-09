package com.kh.springfinal.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		//회원 정보 DB저장
		memberDao.join(memberDto);
		return "redirect:./login";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}

	@PostMapping("/login")
	public String login(@RequestParam String memberId, @RequestParam String memberPw,
								HttpSession session) {
		//db 유저 정보
		MemberDto userDto = memberDao.loginId(memberId);
		//틀리면 되돌림
		if(userDto==null) {
			log.debug("아이디");
			return "redirect:login?error";
		}
		//db Pw
		String userPw = userDto.getMemberPw();
		//db Pw 와 입력값Pw 검사 후 session입력
		if(userPw.equals(memberPw)) {
			session.setAttribute("name", userDto.getMemberId());
			session.setAttribute("level", userDto.getMemberLevel());			
			
//			ChatRoomDto chatRoomDto = chatRoomDao.selectOne(userDto.getMemberId());
//			log.debug("chatRoomDto: {}", chatRoomDto);
//			
//			if(chatRoomDto != null ) { //채팅방 번호가 있다면
//				session.setAttribute("chatRoomNo", chatRoomDto.getChatRoomNo()); //채팅방 번호를 넣어라
//			}		
		}
		else {
			return "redirect:login?error";
		}
		//로그인 완료창으로 보내기
		return "redirect:./loginFinish";	
	}
	
	
	//로그인 완료창
	@RequestMapping("/loginFinish")
	public String loginFinish() {
		return "member/loginFinish";
	}
}
