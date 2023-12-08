package com.kh.springfinal.rest;


import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.MemberCategoryDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.MemberProfileDao;
import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.dto.MemberProfileDto;
import com.kh.springfinal.dto.MinorCategoryDto;
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
	
	@Autowired
	private MemberCategoryDao categoryDao;
	
	
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
		String home = "C:/upload/kh12fa";
		File dir = new File(home);
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
	//프로필 띄우는 코드
		@RequestMapping("/profileShow")
		public ResponseEntity<ByteArrayResource> 
		profileShow(@RequestParam String memberId) throws IOException {
			AttachDto attachDto = profileDao.profileFindOne(memberId);

			if(attachDto == null) {
				String home = "C:/upload/kh12fa";
		        File dir = new File(home);
		        File target = new File(dir, "avatar50.png");

		        // 기본 이미지 데이터 읽어오기
		        byte[] defaultImageData = FileUtils.readFileToByteArray(target);
		        ByteArrayResource resource = new ByteArrayResource(defaultImageData);

		        // 기본 이미지 반환
		        return ResponseEntity.ok()
		                .header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
		                .contentLength(defaultImageData.length)
		                .header(HttpHeaders.CONTENT_TYPE, "image/png") // 기본 이미지 타입으로 설정
		                .header(HttpHeaders.CONTENT_DISPOSITION, 
		                        ContentDisposition.attachment()
		                                .filename("avatar50.png", StandardCharsets.UTF_8)
		                                .build().toString())
		                .body(resource);
			}

			String home = "C:/upload/kh12fa";
			File dir = new File(home);
			File target = new File(dir,String.valueOf(attachDto.getAttachNo()));

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
	
	@PostMapping("/memberEditSelf")
	public boolean memberEditSelf(@ModelAttribute MemberDto memberDto) {
		return memberDao.memberEditSelf(memberDto);
	}
	
	@PostMapping("/delete")
	public boolean delete(@RequestParam String memberId, @RequestParam String memberPw) {
		log.debug("중간체크");
		memberDao.selectOne(memberId, memberPw);
		return memberDao.deleteMember(memberId);
	}
	
	@PostMapping("/minorList")
	public List<MinorCategoryDto> minorList(){
		return categoryDao.minorList();
	}
	
	@PostMapping("/profile")
	public AttachDto profile(@RequestParam String memberId) {
		return profileDao.profileFindOne(memberId);
	}
}