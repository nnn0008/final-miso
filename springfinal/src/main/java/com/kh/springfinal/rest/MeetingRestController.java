package com.kh.springfinal.rest;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.MeetingDao;
import com.kh.springfinal.dao.MeetingImageDao;
import com.kh.springfinal.dao.MeetingMemberDao;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MeetingDto;
import com.kh.springfinal.dto.MeetingMemberDto;
import com.kh.springfinal.vo.FileLoadVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/rest/meeting")
public class MeetingRestController {
	
	@Autowired
	private MeetingDao meetingDao;
	
	@Autowired
	private MeetingImageDao meetingImageDao;
	
	@Autowired
	private MeetingMemberDao meetingMemberDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@Autowired
	private FileLoadVO fileLoadVO;
	
	@PostMapping("/insert")
	public void insert(HttpSession session,
			@RequestParam int clubNo, @RequestParam String meetingName,
			@RequestParam("meetingTime") @DateTimeFormat(pattern = "yyyy-mm-dd HH:mm") Date meetingTime,
			@RequestParam String meetingLocation, @RequestParam int meetingPrice,
			@RequestParam int meetingNumber, @RequestParam MultipartFile meetingImage,
			@RequestParam String meetingFix
			) throws IllegalStateException, IOException {
		
		//아이디가 필요하다
		String memberId = (String)session.getAttribute("name");
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
		
		MeetingDto meetingDto = new MeetingDto();
		int meetingNo = meetingDao.sequence();
		
		meetingDto.setMeetingDate(meetingTime); //날짜
		meetingDto.setMeetingLocation(meetingLocation); //시간
		meetingDto.setMeetingName(meetingName); //정모 제목
		meetingDto.setMeetingNo(meetingNo); //정모 번호
		meetingDto.setMeetingNumber(meetingNumber); //정모 인원
		meetingDto.setMeetingPrice(meetingPrice); 
		meetingDto.setClubNo(clubNo);
		meetingDto.setMeetingFix(meetingFix);
		
		meetingDao.insert(meetingDto);
		
		MeetingMemberDto meetingMemberDto = new MeetingMemberDto();
		
		meetingMemberDto.setClubMemberNo(clubMemberDto.getClubMemberNo());
		meetingMemberDto.setMeetingNo(meetingNo);
		
		meetingMemberDao.insert(meetingMemberDto);
		
		
		//파일
		fileLoadVO.meetingUpload(meetingImage, meetingNo);
	}
	
//	@PostMapping("/list")
//	public Map<String,Object> params(@RequestParam int clubNo, @RequestParam int meetingNo){
//		List<MeetingDto> meetingList = meetingDao.selectList(clubNo);
//		List<MeetingMemberDto> meetingMemberDto = meetingMemberDao.selectList(meetingNo);
//		Map params = Map.of("meetingList", meetingList, "meetingMemberDto", meetingMemberDto);
//		return params;
//	}
	
	
	
	
}
