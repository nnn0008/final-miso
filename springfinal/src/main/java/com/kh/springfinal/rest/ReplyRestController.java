package com.kh.springfinal.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubBoardReplyDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardReplyDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ClubBoardReplyDao clubBoardReplyDao;
	
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@PostMapping("/insert")
	public void insert(HttpSession session, @RequestParam String clubBoardReplyContent, @RequestParam(required = false) Integer clubBoardReplyParent, 
			@RequestParam int clubBoardNo) {
		ClubBoardReplyDto clubBoardReplyDto = new ClubBoardReplyDto();
		int clubBoardReplyNo = clubBoardReplyDao.sequence();
		String memberId = (String)session.getAttribute("name");
		
		MemberDto memberDto = memberDao.loginId(memberId);
		ClubBoardAllDto clubBoardAllDto = clubBoardDao.selectOne(clubBoardNo);
		int clubNo = clubBoardAllDto.getClubNo();
		ClubMemberDto clubMemberDto = clubBoardReplyDao.selectOne(clubNo, memberId);
		
		clubBoardReplyDto.setClubBoardReplyNo(clubBoardReplyNo);
		clubBoardReplyDto.setClubBoardReplyContent(clubBoardReplyContent);
		clubBoardReplyDto.setClubBoardReplyNo(clubBoardReplyNo);
		clubBoardReplyDto.setClubBoardReplyNo(clubBoardReplyNo);
		clubBoardReplyDto.setClubBoardReplyWriter(memberDto.getMemberName());
		clubBoardReplyDto.setClubMemberNo(clubMemberDto.getClubMemberNo());
		clubBoardReplyDto.setClubBoardNo(clubBoardNo);
		clubBoardReplyDto.setClubBoardReplyParent(clubBoardReplyParent);
		
		if(clubBoardReplyDto.getClubBoardReplyParent() == null) { //댓글인 경우
			clubBoardReplyDto.setClubBoardReplyGroup(clubBoardReplyNo);
		}
		else { //대댓글인 경우
			ClubBoardReplyDto originClubBoardReplyDto = clubBoardReplyDao.selectOne(clubBoardReplyDto.getClubBoardReplyParent());
			clubBoardReplyDto.setClubBoardReplyGroup(originClubBoardReplyDto.getClubBoardReplyGroup());
			clubBoardReplyDto.setClubBoardReplyDepth(originClubBoardReplyDto.getClubBoardReplyDepth() + 1);
		}
		clubBoardReplyDao.insert(clubBoardReplyDto);
		//댓글 개수 업데이트 필요함
		clubBoardDao.updateReplyCount(clubBoardNo);
	}
	
	@PostMapping("/list")
	public List<ClubBoardReplyDto> list(@RequestParam int clubBoardNo){
		List<ClubBoardReplyDto> list = clubBoardReplyDao.selectList(clubBoardNo);
		
		return list;
	}
	
	@PostMapping("/delete")
	public void delete(@RequestParam int clubBoardReplyNo) {
		ClubBoardReplyDto clubBoardReplyDto = clubBoardReplyDao.selectOne(clubBoardReplyNo);
		clubBoardReplyDao.delete(clubBoardReplyNo);
		//댓글 개수 업데이트 필요함
		clubBoardDao.updateReplyCount(clubBoardReplyDto.getClubBoardNo());
	}
	
	@PostMapping("/edit")
	public void edit(@RequestParam int clubBoardReplyNo, @RequestParam String clubBoardReplyContent) {
		clubBoardReplyDao.edit(clubBoardReplyNo, clubBoardReplyContent);
	}
}
