package com.kh.springfinal.rest;


import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.MemberProfileDao;
import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.dto.MemberProfileDto;
import com.kh.springfinal.dto.ZipCodeDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private MemberProfileDao profileDao;
	
	@Autowired
	private ZipCodeDao zipCodeDao;
	
	@PostMapping("/checkId")
	public String checkId(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.loginId(memberId);
		if(memberDto != null) {
			return "Y";
		}
		else {
			return "N";
		}
	}
	
	//프로필 저장
	@PostMapping("/profileUpdate")
	public  Map<String, Object> profileUpdate(HttpSession session, @RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int attachNo = attachDao.sequence();
		String memberId = (String) session.getAttribute("name");
		AttachDto attachDto = profileDao.profileFindOne(memberId);
		
		String home = System.getProperty("user.home");
		File dir = new File(home,"upload");
		
		if(attachDto != null) {
			
			attachDao.delete(attachDto.getAttachNo());
		File target = new File(dir,String.valueOf(attachDto.getAttachNo()));
		target.delete();
		}
		
		File insertTarget = new File(dir,String.valueOf(attachNo));
		attach.transferTo(insertTarget);
		
		AttachDto insertDto = new AttachDto();
		insertDto.setAttachNo(attachNo);
		insertDto.setAttachName(attach.getOriginalFilename());
		insertDto.setAttachSize(attach.getSize());
		insertDto.setAttachType(attach.getContentType());
		attachDao.insert(insertDto);
		
		MemberProfileDto memberProfileDto = new MemberProfileDto();
		memberProfileDto.setAttachNo(attachNo);
		memberProfileDto.setMemberId(memberId);
		profileDao.profileUpload(memberProfileDto);
		return Map.of("memberId", memberId);
	}
	
	//프로필 띄우는 코드
	@RequestMapping("/profileShow")
	public ResponseEntity<ByteArrayResource> 
	profileShow(@RequestParam String memberId) throws IOException {
		AttachDto attachDto = profileDao.profileFindOne(memberId);

//		if(attachDto == null) {
//			//throw new NoTargetException("파일 없음");//내가만든 예외로 통합
//			return ResponseEntity.notFound().build();//404 반환
//		}

		String home = System.getProperty("user.home");
		File dir = new File(home, "upload");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));

		byte[] data = FileUtils.readFileToByteArray(target);//실제파일정보 불러오기
		ByteArrayResource resource = new ByteArrayResource(data);
		

		if (attachDto != null) {
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
		else {
            // attachDto가 null이면 에러 응답
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
	}
	
	@PostMapping("/searchAddr")
	public ZipCodeDto searchAddr(@RequestParam int memberAddr) {
		return zipCodeDao.selectOne(memberAddr);
	}
}