package com.kh.springfinal.rest;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.MeetingDao;
import com.kh.springfinal.dao.MeetingImageDao;
import com.kh.springfinal.dao.MeetingMemberDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ChatRoomDto;
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
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@PostMapping("/insert")
	public void insert(HttpSession session,
			@RequestParam int clubNo, @RequestParam String meetingName,
			@RequestParam("meetingTime") @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") Date meetingTime,
			@RequestParam String meetingLocation, @RequestParam int meetingPrice,
			@RequestParam int meetingNumber,
			@RequestParam String meetingFix,
			@RequestParam MultipartFile attach
			) throws IllegalStateException, IOException {
		
		ChatRoomDto chatRoomDto = new ChatRoomDto();
		
		int chatRoomNo = chatRoomDao.sequence();
		
		chatRoomDto.setChatRoomNo(chatRoomNo);
		
		chatRoomDao.insert(chatRoomDto);
		
		//아이디가 필요하다
		String memberId = (String)session.getAttribute("name");
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
		
		MeetingDto meetingDto = new MeetingDto();
		int meetingNo = meetingDao.sequence();
		
		meetingDto.setMeetingDate(meetingTime); //날짜
		meetingDto.setMeetingLocation(meetingLocation); //위치
		meetingDto.setMeetingName(meetingName); //정모 제목
		meetingDto.setMeetingNo(meetingNo); //정모 번호
		meetingDto.setMeetingNumber(meetingNumber); //정모 인원
		meetingDto.setMeetingPrice(meetingPrice); 
		meetingDto.setClubNo(clubNo);
		meetingDto.setMeetingFix(meetingFix);
		meetingDto.setChatRoomNo(chatRoomNo);
		
		log.debug("meetingTime={}",meetingTime);
		
		meetingDao.insert(meetingDto);
		
		
		
		if(!attach.isEmpty()) {
			int attachNo = attachDao.sequence();
			
			//첨부파일 등록(파일이 있을 때만)
			String home = System.getProperty("user.home");
			File dir = new File(home,"upload");
			dir.mkdirs();
			File target = new File(dir,String.valueOf(attachNo));
			attach.transferTo(target);
			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);
			
			//연결(파일이 있을 때만)
			
			
			
			meetingImageDao.insert(attachNo,meetingNo);
			
		}
		MeetingMemberDto meetingMemberDto = new MeetingMemberDto();
		
		meetingMemberDto.setClubMemberNo(clubMemberDto.getClubMemberNo());
		meetingMemberDto.setMeetingNo(meetingNo);
		meetingMemberDao.insert(meetingMemberDto);
		
	}
	
	@GetMapping("/edit")
	public MeetingDto edit(int meetingNo) throws IllegalStateException, IOException {
		
		
		MeetingDto meetingDto = meetingDao.selectOne(meetingNo);
		
		
		return meetingDto;
		
		
	}
	
	@PostMapping("/edit")
	public void edit(HttpSession session,
			@RequestParam int clubNo, @RequestParam String meetingName,
			@RequestParam("meetingTime") @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") Date meetingTime,
			@RequestParam String meetingLocation, @RequestParam int meetingPrice,
			@RequestParam int meetingNumber,
			@RequestParam String meetingFix,
			@RequestParam MultipartFile attach
			) throws IllegalStateException, IOException {
		
		
		
		//아이디가 필요하다
		String memberId = (String)session.getAttribute("name");
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
		
		MeetingDto meetingDto = new MeetingDto();
		int meetingNo = meetingDao.sequence();
		
		meetingDto.setMeetingDate(meetingTime); //날짜
		meetingDto.setMeetingLocation(meetingLocation); //위치
		meetingDto.setMeetingName(meetingName); //정모 제목
		meetingDto.setMeetingNo(meetingNo); //정모 번호
		meetingDto.setMeetingNumber(meetingNumber); //정모 인원
		meetingDto.setMeetingPrice(meetingPrice); 
		meetingDto.setClubNo(clubNo);
		meetingDto.setMeetingFix(meetingFix);
		
		log.debug("meetingTime={}",meetingTime);
		
		meetingDao.insert(meetingDto);
		
		
		
		if(!attach.isEmpty()) {
			int attachNo = attachDao.sequence();
			
			//첨부파일 등록(파일이 있을 때만)
			String home = System.getProperty("user.home");
			File dir = new File(home,"upload");
			dir.mkdirs();
			File target = new File(dir,String.valueOf(attachNo));
			attach.transferTo(target);
			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);
			
			//연결(파일이 있을 때만)
			
			
			
			meetingImageDao.insert(attachNo,meetingNo);
			
		}
		MeetingMemberDto meetingMemberDto = new MeetingMemberDto();
		
		meetingMemberDto.setClubMemberNo(clubMemberDto.getClubMemberNo());
		meetingMemberDto.setMeetingNo(meetingNo);
		meetingMemberDao.insert(meetingMemberDto);
		
	}
	
	
	@GetMapping("/list")
	public List<MeetingDto> list(int clubNo) throws ParseException{
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd E a hh:mm:ss");
		List<MeetingDto> meetingList = meetingDao.selectList(clubNo);
		
		for(MeetingDto dto : meetingList) {

			//스트링 날짜 설정
		 	Date date = dto.getMeetingDate();
	        String formattedDate = dateFormat.format(date);
	        dto.setDateString(formattedDate); 
	        
	        
	        
	        //디데이 설정
	        
	        Date currentDate = new Date();
	        SimpleDateFormat currentDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        String formattedCurrentDate = currentDateFormat.format(currentDate);
	        String day = currentDateFormat.format(date);
	        
            int timeDiff = (int) (currentDateFormat.parse(day).getTime() - currentDateFormat.parse(formattedCurrentDate).getTime());
            int daysDiff = (int) Math.ceil(timeDiff / (1000 * 3600 * 24));

            dto.setDday(daysDiff);
		}
		
		return meetingList;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/image")
	public ResponseEntity<ByteArrayResource> 
							image(@RequestParam int meetingNo) throws IOException {
		//[1] 클럽 번호로 파일 번호를 찾아야 한다
		//[2] 파일 번호로 파일 정보를 불러와야 한다
		//[3] 실제 파일을 불러와야 한다
		//[4] 앞에서 불러온 모든 정보로 ResponseEntity를 생성한다
		//[5] 사용자한테 준다
		
		//1,2
		AttachDto attachDto = meetingDao.findImage(meetingNo);
		
		if(attachDto == null) {
//			throw new NoTargetException("파일 없음");
			//내가 만든 예외로 통합
			
			return ResponseEntity.notFound().build();
			//404로 반환
			
		}
		
		//3
		String home = System.getProperty("user.home");
		File dir = new File(home,"upload");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target);// 실제파일정보 불러오기
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//4,5 - header(정보), body(내용)
		return ResponseEntity.ok()
//				.header("Content-Encoding","UTF-8")
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
//				.header("Content-Length",String.valueOf(attachDto.getAttachSize()))
				.contentLength(attachDto.getAttachSize())
//				.header("Content-Type",attachDto.getAttachType())//저장된 유형
				.header(HttpHeaders.CONTENT_TYPE,attachDto.getAttachType())
//				.header("Content-Type","application/octet-stream")//무조건 다운로드
//				.contentType(MediaType.APPLICATION_OCTET_STREAM)
//				.header("Content-Disposition","attachment; filename="+attachDto.getAttachName())
				.header(HttpHeaders.CONTENT_DISPOSITION,
					ContentDisposition.attachment().filename(attachDto.getAttachName(),StandardCharsets.UTF_8)
					.build().toString()
						)
				
			.body(resource);	
	}
	
	@PostMapping("/attend")
	public void attend(@RequestParam int clubNo, @RequestParam int meetingNo,HttpSession session) {
		
		
		String memberId= (String) session.getAttribute("name");
		
		int clubMemberNo = clubMemberDao.findClubMemberNo(clubNo, memberId);
		
		MeetingMemberDto meetingMemberDto = new MeetingMemberDto();
		
		meetingMemberDto.setClubMemberNo(clubMemberNo);
		meetingMemberDto.setMeetingNo(meetingNo);
		
		meetingMemberDao.insert(meetingMemberDto);
		
		
	}
	
	
	
	
}