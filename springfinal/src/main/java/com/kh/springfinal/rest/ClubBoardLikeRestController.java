package com.kh.springfinal.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubBoardLikeDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardLikeDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.vo.ClubBoardLikeVO;

@RestController
@RequestMapping("/rest/clubBoard")
public class ClubBoardLikeRestController {
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@Autowired
	private ClubBoardLikeDao clubBoardLikeDao;
	
	@PostMapping("/check")
	public ClubBoardLikeVO check(@RequestParam int clubBoardNo, HttpSession session){
		String memberId = (String) session.getAttribute("name");
		ClubBoardAllDto clubBoardAllDto = clubBoardDao.selectOne(clubBoardNo);
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubBoardAllDto.getClubNo()); 
		int clubMemberNo = clubMemberDto.getClubMemberNo();
		
		ClubBoardLikeDto clubBoardLikeDto = new ClubBoardLikeDto();
		clubBoardLikeDto.setClubMemberNo(clubMemberNo);
		clubBoardLikeDto.setClubBoardNo(clubBoardNo);
		
		boolean isCheck = clubBoardLikeDao.check(clubBoardLikeDto);
		int count = clubBoardLikeDao.count(clubBoardNo);
		
		ClubBoardLikeVO vo = new ClubBoardLikeVO();
		vo.setCheck(isCheck);
		vo.setCount(count);
		
		return vo;
	}
	
	@RequestMapping("/action")
	public ClubBoardLikeVO action(HttpSession session, @RequestParam int clubBoardNo) {
		String memberId = (String) session.getAttribute("name");
		ClubBoardAllDto clubBoardAllDto = clubBoardDao.selectOne(clubBoardNo);
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubBoardAllDto.getClubNo()); 
		int clubMemberNo = clubMemberDto.getClubMemberNo();
		
		ClubBoardLikeDto clubBoardLikeDto = new ClubBoardLikeDto();
		clubBoardLikeDto.setClubMemberNo(clubMemberNo);
		clubBoardLikeDto.setClubBoardNo(clubBoardNo);
		
		boolean isCheck = clubBoardLikeDao.check(clubBoardLikeDto);
		
		if(isCheck) { //이미 좋아요를 눌렀다면
			clubBoardLikeDao.delete(clubBoardNo);
		}
		else {//좋아요를 누르지 않았따면
			clubBoardLikeDao.insert(clubBoardLikeDto);
		}
		
		int count = clubBoardLikeDao.count(clubBoardNo);
		
		ClubBoardLikeVO vo = new ClubBoardLikeVO();
		vo.setCheck(isCheck);
		vo.setCount(count);
		
		return vo;
	}
	
	
}
