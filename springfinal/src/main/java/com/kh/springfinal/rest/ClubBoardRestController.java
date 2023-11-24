package com.kh.springfinal.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubBoardImage2Dao;
import com.kh.springfinal.dao.ClubBoardImage3Dao;
import com.kh.springfinal.dao.ClubBoardImageDao;
import com.kh.springfinal.dao.ClubBoardLikeDao;
import com.kh.springfinal.dao.ClubBoardReplyDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubBoardImage2Dto;
import com.kh.springfinal.dto.ClubBoardImage3Dto;
import com.kh.springfinal.dto.ClubBoardImageDto;
import com.kh.springfinal.dto.ClubBoardLikeDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.vo.ClubBoardLikeVO;
import com.kh.springfinal.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/clubBoard")
public class ClubBoardRestController {
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
	
	@Autowired
	private ClubBoardImageDao clubBoardImageDao;
	@Autowired
	private ClubBoardImage2Dao clubBoardImage2Dao;
	@Autowired
	private ClubBoardImage3Dao clubBoardImage3Dao;
	@Autowired
	private AttachDao attachDao;
	
	@PostMapping("/check")
	public ClubBoardLikeVO check(@RequestParam int clubBoardNo, HttpSession session){
		String memberId = (String) session.getAttribute("name");
		ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo);
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubBoardDto.getClubNo()); 
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
	        String memberId = (String) session.getAttribute("name"); //로그인한 유저
	        ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo); //보드 번호로 보드 dto하나 선택
	        ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubBoardDto.getClubNo());//로그인 한 아이디와 clubno를 통해 로그인을 한 유저의 clubMemberDto를 추출 
	        int clubMemberNo = clubMemberDto.getClubMemberNo(); //로그인 한 유저의 clubno
	        
	        ClubMemberDto likeMemberNo = clubMemberDao.selectOne(clubMemberNo); //좋아요 누른 멤버 찾는 DTO
	        MemberDto memberDto = memberDao.loginId(memberId); //웹소켓,로그인한 유저
	        
	        int writeNo = clubBoardDto.getClubMemberNo();
	        ClubMemberDto writeDto = clubMemberDao.selectOne(writeNo);
	        String boardWriterMember = writeDto.getClubMemberId(); //게시글 작성자
	        String boardTitle = clubBoardDto.getClubBoardTitle();  //게시글 제목
	        MemberDto replyWriterMember = memberDao.loginId(likeMemberNo.getClubMemberId());  //좋아요 누른 멤버
	        String replyWriterName = replyWriterMember.getMemberName(); //좋아요 누른 멤버 닉네임
	        
	        ClubBoardLikeDto clubBoardLikeDto = new ClubBoardLikeDto();
	        clubBoardLikeDto.setClubMemberNo(clubMemberNo);
	        clubBoardLikeDto.setClubBoardNo(clubBoardNo);

	        boolean isCheck = clubBoardLikeDao.check(clubBoardLikeDto);

	        if (isCheck) { //이미 좋아요를 눌렀다면
	            clubBoardLikeDao.deleteByClubMemberNo(clubMemberNo);
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
	
	@PostMapping("/match")
	public String match(@RequestParam int clubBoardNo, HttpSession session) {
		ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo);
		ClubMemberDto clubMemberDto = clubMemberDao.selectOne(clubBoardDto.getClubMemberNo()); //보드의 멤버번호
		String memberId = (String)session.getAttribute("name"); //로그인한 유저의 아이디
		boolean check = clubMemberDto.getClubMemberId().equals(memberId);
		
		if(check) return "t"; //일치한다면
		else return "f"; //일치하지 않는다면
	}
	
	@PostMapping("/deletePhoto")
	public void deletePhoto(@RequestParam int clubBoardNo) {
		ClubBoardImageDto clubBoardImageDto = clubBoardImageDao.selectOne(clubBoardNo);
		attachDao.delete(clubBoardImageDto.getAttachNo());
	}
	@PostMapping("/deletePhoto2")
	public void deletePhoto2(@RequestParam int clubBoardNo) {
		ClubBoardImage2Dto clubBoardImage2Dto = clubBoardImage2Dao.selectOne(clubBoardNo);
		attachDao.delete(clubBoardImage2Dto.getAttachNo());
	}
	@PostMapping("/deletePhoto3")
	public void deletePhoto3(@RequestParam int clubBoardNo) {
		ClubBoardImage3Dto clubBoardImage3Dto = clubBoardImage3Dao.selectOne(clubBoardNo);
		attachDao.delete(clubBoardImage3Dto.getAttachNo());
	}
	
	@GetMapping("/page")
	public List<ClubBoardAllDto> clubBoardList(@ModelAttribute("vo")PaginationVO vo, @RequestParam int clubNo, @RequestParam(required=false) int page, 
			@RequestParam(required=false) String keyword) {
		log.debug("keyword={}",keyword);
		int count = clubBoardDao.clubBoardCount(vo, clubNo);
		vo.setPage(page);
		vo.setCount(count);
		if(keyword != null) {
			vo.setKeyword(keyword);
		}
		List<ClubBoardAllDto> list = clubBoardDao.selectListByPage(vo, clubNo); 
		log.debug("list={}", list);
		return list;
	}
}
