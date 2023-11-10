package com.kh.springfinal.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
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
	public String login(HttpServletResponse httpServletResponse,
						@RequestParam String memberId, @RequestParam String memberPw,
						@RequestParam(required = false) String saveId,
								HttpSession session) {
		//db 유저 정보
		MemberDto userDto = memberDao.loginId(memberId);
		// id 틀리면 되돌림
		if(userDto==null) {
			if(saveId != null) {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(4*7*24*60*60);//4주
				httpServletResponse.addCookie(cookie);
			}
			else {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(0);//4주
				httpServletResponse.addCookie(cookie);
			}
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
			if(saveId != null) {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(4*7*24*60*60);//4주
				httpServletResponse.addCookie(cookie);
			}
			else {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(0);//4주
				httpServletResponse.addCookie(cookie);
			}
			return "redirect:login?error";
		}
		//로그인 완료창으로 보내기
		return "/home";	
	}
	
	
	//로그인 완료창
	@RequestMapping("/loginFinish")
	public String loginFinish() {
		return "member/loginFinish";
	}
	
	//아이디 찾기
	@GetMapping("/searchId")
	public String searchId() {
		return "member/searchId";
	}
	
	
}
