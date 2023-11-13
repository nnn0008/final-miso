package com.kh.springfinal.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubBoardReplyDao;
import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardReplyDto;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ClubBoardReplyDao clubBoardReplyDao;
	
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@PostMapping("/insert")
	public void insert(HttpSession session, @ModelAttribute ClubBoardReplyDto clubBoardReplyDto, @RequestParam int clubBoardNo) {
		
		int clubBoardReplyNo = clubBoardReplyDao.sequence();
		String clubBoardReplyWriter = (String)session.getAttribute("name");
		String clubBoardReplyWriterLevel = (String)session.getAttribute("level");

		clubBoardReplyDto.setClubBoardNo(clubBoardNo);
		clubBoardReplyDto.setClubBoardReplyNo(clubBoardReplyNo);
		clubBoardReplyDto.setClubBoardReplyWriter(clubBoardReplyWriter);
		
		clubBoardReplyDao.insert(clubBoardReplyDto);
	}
	
	
}
