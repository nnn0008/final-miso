package com.kh.springfinal.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
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
		log.debug(memberId);
		MemberDto memberDto = memberDao.loginId(memberId);
//		if(memberDto!=null) {
//			session.setAttribute("name", memberId);
//		}
		return "redirect:/miso";	
	}
}
