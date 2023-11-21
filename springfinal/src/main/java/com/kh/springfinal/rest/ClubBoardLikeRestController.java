package com.kh.springfinal.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubBoardLikeDao;
import com.kh.springfinal.dao.ClubBoardReplyDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardLikeDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.vo.ClubBoardLikeVO;
import com.kh.springfinal.vo.ClubBoardReplyMemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/clubBoard")
public class ClubBoardLikeRestController {
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@Autowired
	private ClubBoardLikeDao clubBoardLikeDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ClubBoardReplyDao clubBoardReplyDao;
	
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
	
//	@RequestMapping("/action")
//	public ClubBoardLikeVO action(HttpSession session, @RequestParam int clubBoardNo) {
//		String memberId = (String) session.getAttribute("name");
//		ClubBoardAllDto clubBoardAllDto = clubBoardDao.selectOne(clubBoardNo);
//		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubBoardAllDto.getClubNo()); 
//		int clubMemberNo = clubMemberDto.getClubMemberNo();
//		
//		ClubBoardLikeDto clubBoardLikeDto = new ClubBoardLikeDto();
//		clubBoardLikeDto.setClubMemberNo(clubMemberNo);
//		clubBoardLikeDto.setClubBoardNo(clubBoardNo);
//		
//		boolean isCheck = clubBoardLikeDao.check(clubBoardLikeDto);
//		log.debug("clubMemberNo = {}", clubMemberNo);
//		if(isCheck) { //이미 좋아요를 눌렀다면
//			clubBoardLikeDao.deleteByClubMemberNo(clubMemberNo);
//			clubBoardDao.updateLikeCount(clubBoardNo);
//		}
//		else {//좋아요를 누르지 않았따면
//			clubBoardLikeDao.insert(clubBoardLikeDto);
//			clubBoardDao.updateLikeCount(clubBoardNo);
//		}
//		
//		int count = clubBoardLikeDao.count(clubBoardNo);
//		
//		ClubBoardLikeVO vo = new ClubBoardLikeVO();
//		vo.setCheck(isCheck);
//		vo.setCount(count);
//		
//		return vo;
//	}
	
	@RequestMapping("/action")
	public Map<String, Object> action(HttpSession session, @RequestParam int clubBoardNo) {
	    Map<String, Object> responseMap = new HashMap<>();
	    try {
	        String memberId = (String) session.getAttribute("name");
	        ClubBoardAllDto clubBoardAllDto = clubBoardDao.selectOne(clubBoardNo);
	        ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubBoardAllDto.getClubNo()); 
	        int clubMemberNo = clubMemberDto.getClubMemberNo();
	        
	        ClubMemberDto likeMemberNo = clubMemberDao.selectOne(clubMemberNo); //좋아요 누른 멤버 찾는 DTO
	        MemberDto memberDto = memberDao.loginId(memberId); //웹소켓 
	        String boardWriterMember = clubBoardAllDto.getClubMemberId(); //게시글 작성자
	        String boardTitle = clubBoardAllDto.getClubBoardTitle();  //게시글 제목
	        MemberDto replyWriterMember = memberDao.loginId(likeMemberNo.getClubMemberId());  //좋아요 누른 멤버
	        String replyWriterName = replyWriterMember.getMemberName(); //좋아요 누른 멤버 닉네임
	        
	        ClubBoardLikeDto clubBoardLikeDto = new ClubBoardLikeDto();
	        clubBoardLikeDto.setClubMemberNo(clubMemberNo);
	        clubBoardLikeDto.setClubBoardNo(clubBoardNo);

	        boolean isCheck = clubBoardLikeDao.check(clubBoardLikeDto);

	        if (isCheck) { //이미 좋아요를 눌렀다면
	            clubBoardLikeDao.delete(clubBoardNo);
	            clubBoardDao.updateLikeCount(clubBoardNo);
	        } else { //좋아요를 누르지 않았따면
	            clubBoardLikeDao.insert(clubBoardLikeDto);
	            clubBoardDao.updateLikeCount(clubBoardNo);
	        }
	        int count = clubBoardLikeDao.count(clubBoardNo);

	        ClubBoardLikeVO vo = new ClubBoardLikeVO();
	        vo.setCheck(isCheck);
	        vo.setCount(count);
	        
	        // ClubBoardLikeVO를 맵에 추가
	        responseMap.put("vo", vo);
	        
	        responseMap.put("success", true);
	        responseMap.put("replyWriterMember", replyWriterMember.getMemberId()); // 좋아요 누른 멤버
	        responseMap.put("boardWriterMember", boardWriterMember); // 게시글 작성자
	        responseMap.put("clubBoardNo", clubBoardNo); //게시글 번호
	        responseMap.put("boardTitle", boardTitle); // 게시글 제목
	        responseMap.put("replyWriterName", replyWriterName); //좋아요 누른 멤버 닉네임
	        
	        return responseMap;
	       
	    } catch (Exception e) {
	        log.error("Error processing insert operation", e);
	        responseMap.put("success", false);
	        return responseMap;
	    }
}
	}
