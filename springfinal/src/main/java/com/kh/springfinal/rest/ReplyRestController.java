package com.kh.springfinal.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubBoardReplyDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubBoardReplyDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.vo.ClubBoardReplyMemberVO;

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
	public ResponseEntity<Map<String, Object>> insert(HttpSession session,
	        @RequestParam String clubBoardReplyContent,
	        @RequestParam(required = false) Integer clubBoardReplyParent,
	        @RequestParam int clubBoardNo) {
	    Map<String, Object> responseMap = new HashMap<>();

	    //log.debug("clubBoardReplyContent = {}", clubBoardReplyContent);
	    //log.debug("clubBoardReplyParent = {}", clubBoardReplyParent);
	    //log.debug("clubBoardNo = {}", clubBoardNo);
	    try {
	        ClubBoardReplyDto clubBoardReplyDto = new ClubBoardReplyDto();
	        int clubBoardReplyNo = clubBoardReplyDao.sequence();
	        String memberId = (String) session.getAttribute("name");

	        MemberDto memberDto = memberDao.loginId(memberId);
	        ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo);
	        int clubNo = clubBoardDto.getClubNo();
	        ClubMemberDto clubMemberDto = clubBoardReplyDao.selectOne(clubNo, memberId);

	        clubBoardReplyDto.setClubBoardReplyNo(clubBoardReplyNo);
	        clubBoardReplyDto.setClubBoardReplyContent(clubBoardReplyContent);
	        clubBoardReplyDto.setClubBoardReplyWriter(memberDto.getMemberName());
	        clubBoardReplyDto.setClubMemberNo(clubMemberDto.getClubMemberNo());
	        clubBoardReplyDto.setClubBoardNo(clubBoardNo);
	        clubBoardReplyDto.setClubBoardReplyParent(clubBoardReplyParent);

	        if (clubBoardReplyDto.getClubBoardReplyParent() == null) {
	            // 댓글인 경우
	            clubBoardReplyDto.setClubBoardReplyGroup(clubBoardReplyNo);
	        } 
	        else {
	            // 대댓글인 경우
	            ClubBoardReplyDto originClubBoardReplyDto = clubBoardReplyDao
	                    .selectOne(clubBoardReplyDto.getClubBoardReplyParent());
	            clubBoardReplyDto.setClubBoardReplyGroup(originClubBoardReplyDto.getClubBoardReplyGroup());
	            clubBoardReplyDto.setClubBoardReplyDepth(originClubBoardReplyDto.getClubBoardReplyDepth() + 1);
	        }
	        clubBoardReplyDao.insert(clubBoardReplyDto);
	        // 댓글 개수 업데이트 필요함
	        clubBoardDao.updateReplyCount(clubBoardNo);

	        // 웹소켓 전송 부분
	        ClubBoardReplyMemberVO boardReplyMember = clubBoardReplyDao.selectBoardReplyMember(clubBoardReplyNo);

	        if (boardReplyMember == null) {
	            // 오류 처리를 수행하거나 적절한 기본값을 설정하는 등의 작업
	            log.error("Failed to retrieve boardReplyMember for clubBoardReplyNo: {}", clubBoardReplyNo);

	            responseMap.put("success", false);
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseMap);
	        }

	        // 작성자, 게시글 작성자, 게시글 번호, 게시글 제목을 응답에 포함
	        responseMap.put("success", true);
	        responseMap.put("replyWriterMember", boardReplyMember.getReplyMemberId()); // 댓글 작성자
	        responseMap.put("boardWriterMember", boardReplyMember.getBoardMemberId()); // 게시글 작성자
	        responseMap.put("boardNo", clubBoardNo);
	        responseMap.put("boardTitle", boardReplyMember.getClubBoardTitle()); // 게시글 제목
	        responseMap.put("replyWriterName", memberDto.getMemberName()); //댓글 작성자 닉네임

	        return ResponseEntity.ok(responseMap);
	    } catch (Exception e) {
	        log.error("Error processing insert operation", e);
	        responseMap.put("success", false);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseMap);
	    }
	}

	@PostMapping("/list")
	public List<ClubBoardReplyDto> list(@RequestParam int clubBoardNo){
		List<ClubBoardReplyDto> list = clubBoardReplyDao.selectListByReply(clubBoardNo);
		
		return list;
	}
	
//	@PostMapping("/list")
//	public Map<String, Object> list(@RequestParam int clubBoardNo, HttpSession session){
//		String memberId = (String)session.getAttribute("name");
//		MemberDto memberDto = memberDao.loginId(memberId);
//	
//		List<ClubBoardReplyDto> list = clubBoardReplyDao.selectList(clubBoardNo);
//		ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo);
//		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubBoardDto.getClubNo());
//		//로그인 한 사람의 memberNo
//		int clubMemberNo = clubMemberDto.getClubMemberNo(); 
//		
//		Map params = Map.of("replyList", list, "clubMemberNo", clubMemberNo);
//		return params;
//	}
	
	@PostMapping("/delete")
	public void delete(@RequestParam int clubBoardReplyNo) {
		ClubBoardReplyDto clubBoardReplyDto = clubBoardReplyDao.selectOne(clubBoardReplyNo);
		clubBoardReplyDao.delete(clubBoardReplyNo);
		//댓글 개수 업데이트 필요함
		clubBoardDao.updateReplyCount(clubBoardReplyDto.getClubBoardNo());
	}
	
	@PostMapping("/edit")
	public void edit(@ModelAttribute ClubBoardReplyDto clubBoardreplyDto) {
		clubBoardReplyDao.edit(clubBoardreplyDto.getClubBoardReplyNo(), clubBoardreplyDto.getClubBoardReplyContent());
	}
}