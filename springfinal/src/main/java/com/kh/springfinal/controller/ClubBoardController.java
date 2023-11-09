package com.kh.springfinal.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;

@Controller
@RequestMapping("/clubBoard")
public class ClubBoardController {
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ClubDao clubDao;
	
//	@Autowired
//	private clubMemberDao clubMemberDao;
	
	@GetMapping("/write")
	public String write() {
		return "clubBoard/write";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute ClubBoardDto clubBoardDto, @ModelAttribute MemberDto memberDto, @ModelAttribute ClubMemberDto clubMemberDto, HttpSession session) {
		memberDto = memberDao.loginId((String)session.getAttribute("name")); //여기서 회원 이름을 얻어야함
		clubMemberDto = clubMemberDao.selectOne(memberDto.getMemberId());
		int clubBoardNo = clubBoardDao.sequence();
		int clubMemberNo = clubMemberDto.getClubMemberNo();
		String clubBoradName = memberDto.getMemberName();
		int clubNo = clubMemberDto.getClubNo();
		
		clubBoardDto.setClubBoardNo(clubBoardNo);
		clubBoardDto.setClubNo(clubNo);
		clubBoardDto.setClubMemberNo(clubMemberNo);
		clubBoardDto.setClubBoardName(clubBoradName);
		
		clubBoardDao.insert(clubBoardDto);
		
		return "redirect:club?clubNo="+clubBoardDto.getClubNo()+"/clubBoardList";
	}
}
