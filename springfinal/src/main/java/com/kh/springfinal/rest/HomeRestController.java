package com.kh.springfinal.rest;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.HomeDao;
import com.kh.springfinal.dao.MeetingMemberDao;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MeetingMemberDto;
import com.kh.springfinal.vo.FileLoadVO;
import com.kh.springfinal.vo.HomeForMeetingVO;
import com.kh.springfinal.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/rest/home")
public class HomeRestController {
	
	@Autowired
	private HomeDao homeDao;
	@Autowired
	private MeetingMemberDao meetingMemberDao;
	@Autowired
	private FileLoadVO fileLoadVO;
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@GetMapping("page")
	public List<HomeForMeetingVO> page(@ModelAttribute("vo")PaginationVO vo, @RequestParam(required=false) int page, HttpSession session){
		String memberId = (String)session.getAttribute("name");
		int count = homeDao.meetingCount(vo, memberId);
		vo.setPage(page);
		vo.setCount(count);
		List<HomeForMeetingVO> list = homeDao.selectList(vo, memberId);
		
		log.debug("page = {}", page);
		log.debug("vo = {}", vo);
		log.debug("list = {}", list);
		
		return list;
	}
	
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachNo) throws IOException{
		return fileLoadVO.download(attachNo);
	}

	@PostMapping("/insert")
	public String insert(@RequestParam int clubNo, @RequestParam int meetingNo, HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
		MeetingMemberDto existDto = homeDao.selectOne(clubNo, meetingNo);
		
		log.debug("existDto = ", existDto);
		log.debug("meetingNo = ", meetingNo);
		log.debug("clubMemberNo = ", clubMemberDto.getClubMemberNo());
		if(existDto != null) {
			return "이미 참석했습니다";
		}
		else {
			MeetingMemberDto meetingMemberDto = new MeetingMemberDto();
			meetingMemberDto.setMeetingNo(meetingNo);
			meetingMemberDto.setClubMemberNo(clubMemberDto.getClubMemberNo());
			meetingMemberDao.insert(meetingMemberDto);
			return "신청이 완료되었습니다";
		}
		
	} 
	
	@PostMapping("/remove")
	public void remove(@RequestParam int clubNo, @RequestParam int meetingNo, HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
		log.debug("clubMemberNo = ", clubMemberDto.getClubMemberNo());
		log.debug("meetingNo = ", meetingNo);
		log.debug("clubNo = ", clubNo);
		meetingMemberDao.deleteAttend(meetingNo, clubMemberDto.getClubMemberNo());
	}
	
}
