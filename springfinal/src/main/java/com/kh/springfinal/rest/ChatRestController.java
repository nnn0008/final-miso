package com.kh.springfinal.rest;


import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.configuration.FileUploadProperties;
import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ChatDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dao.MemberProfileDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.vo.ChatMemberListVO;
import com.kh.springfinal.vo.ChatOneMemberListVO;
import com.kh.springfinal.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
public class ChatRestController {
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private ChatDao chatDao;
	
	@Autowired
	private MemberProfileDao profileDao;
	
    // 초기 디렉터리 설정
    @Autowired
    private FileUploadProperties props;

    private File dir;

    @PostConstruct
    public void init() {
        dir = new File(props.getHome());
        dir.mkdirs();
    }
	
//	 @GetMapping("/getProfile")
//	    public List<MemberDto> getProfile() {
//		 	return chatRoomDao.selectMemberProfile();
//	    }
	 // getProfile 메서드 수정
	 @GetMapping("/getProfile")
	 public List<MemberVO> getProfile() {
	     List<MemberVO> memberList = chatRoomDao.selectMemberProfile2();

	     // 프로필 이미지 URL을 추가
	     for (MemberVO member : memberList) {
	         AttachDto profileImage = profileDao.profileFindOne(member.getMemberId());
	         if (profileImage != null) {
	             member.setProfileImageUrl("/getProfileImage?memberId=" + member.getMemberId());
	         }
	     }

	     return memberList;
	 }

    
	 @GetMapping("/download")
	 public ResponseEntity<?> download(@RequestParam int attachNo) throws IOException {
	     AttachDto attachDto = attachDao.selectOne(attachNo);

	     File target = new File(dir, String.valueOf(attachNo));
	     if (!target.exists()) {
	         return ResponseEntity.notFound().build();
	     }

	     byte[] data = FileUtils.readFileToByteArray(target);
	     ByteArrayResource resource = new ByteArrayResource(data);

	     return ResponseEntity.ok()
	             .header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
	             .contentLength(attachDto.getAttachSize())
	             .header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
	             .header(HttpHeaders.CONTENT_DISPOSITION,
	                     ContentDisposition.attachment()
	                             .filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
	                             .build()
	                             .toString()
	             )
	             .body(resource);
	 }
	 
	 //멤버 프로필 사진
	 @RequestMapping("/getProfileImage")
	 public ResponseEntity<ByteArrayResource> getProfileImage(@RequestParam String memberId) throws IOException {
//	     log.debug("Received request for profile image. Member ID: {}", memberId);

	     AttachDto attachDto = profileDao.profileFindOne(memberId);

	     if (attachDto == null) {
//	         log.warn("Profile image not found for Member ID: {}", memberId);
	         return ResponseEntity.notFound().build();
	     }

//	     log.debug("Profile image found for Member ID: {}", memberId);

	     String home = System.getProperty("user.home");
	     File dir = new File(home, "upload");
	     File target = new File(dir, String.valueOf(attachDto.getAttachNo()));

	     byte[] data = FileUtils.readFileToByteArray(target);
	     ByteArrayResource resource = new ByteArrayResource(data);

//	     log.debug("Sending profile image for Member ID: {}", memberId);

	     return ResponseEntity.ok()
	             .header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
	             .contentLength(attachDto.getAttachSize())
	             .header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
	             .header(HttpHeaders.CONTENT_DISPOSITION,
	                     ContentDisposition.attachment()
	                             .filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
	                             .build().toString()
	             )
	             .body(resource);
	 }

	 
	 @GetMapping("/getMemberList")
	 public List<ChatMemberListVO> getMemberList(@RequestParam int chatRoomNo) {
	     List<ChatMemberListVO> memberList = chatRoomDao.chatMemberList(chatRoomNo);
	     return memberList;
	 }

	 @GetMapping("/getChatOneMemberList")
	 public List<ChatOneMemberListVO> getChatOneMemberList(@RequestParam int chatRoomNo) {
	     List<ChatOneMemberListVO> chatOneMemberList = chatRoomDao.chatOneMemberList(chatRoomNo);
	     return chatOneMemberList;
	 }
	 
	 @GetMapping("/getMettingMemberList")
	 public List<ChatMemberListVO> getMeetingMemberList(@RequestParam int chatRoomNo){
		 List<ChatMemberListVO> meetingMemberList = chatRoomDao.meetingMemberList(chatRoomNo);
		 return meetingMemberList;
	 }

	 
	 @PostMapping("/updateBlind")
	 public void update(@RequestBody Map<String, Object> requestBody) {
		System.out.println("들어오나");
		 int chatNo = (int) requestBody.get("chatNo");
	     chatDao.chatBlindUpdate(chatNo);
	 }
	 
}

