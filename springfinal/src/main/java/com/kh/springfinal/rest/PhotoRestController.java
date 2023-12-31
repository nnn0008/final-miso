package com.kh.springfinal.rest;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.MemberProfileDao;
import com.kh.springfinal.dao.PhotoDao;
import com.kh.springfinal.dao.PhotoImageDao;
import com.kh.springfinal.dao.PhotoLikeDao;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.dto.PhotoDto;
import com.kh.springfinal.dto.PhotoImageDto;
import com.kh.springfinal.dto.PhotoLikeDto;
import com.kh.springfinal.vo.FileLoadVO;
import com.kh.springfinal.vo.PhotoLikeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/photo")
public class PhotoRestController {

	@Autowired
	private PhotoDao photoDao;

	@Autowired
	private FileLoadVO fileLoadVO;

	@Autowired
	private ClubBoardDao clubBoardDao;

	@Autowired
	private PhotoImageDao photoImageDao;

	@Autowired
	private ClubMemberDao clubMemberDao;

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Autowired
	private PhotoLikeDao photoLikeDao;
	
	//@Autowired
	//private PhotoLikeDao photoLikeDao;

	@PostMapping("/insert")
	public void insert(@RequestParam MultipartFile photoImage, @RequestParam int clubNo, HttpSession session)
			throws IllegalStateException, IOException {
		PhotoDto photoDto = new PhotoDto();
		int photoNo = photoDao.sequence();
		String memberId = (String) session.getAttribute("name");
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);

		photoDto.setClubMemberNo(clubMemberDto.getClubMemberNo());
		photoDto.setClubNo(clubNo);
		photoDto.setPhotoNo(photoNo);

		photoDao.insert(photoDto);

		// 이미지 넣기
		fileLoadVO.photoUpload(photoImage, photoNo);
	}

	@PostMapping("/list")
	public List<PhotoDto> list(@RequestParam int clubNo) {
		List<PhotoDto> list = photoDao.selectList(clubNo);
		return list;
	}

	@GetMapping("/download/{photoNo}")
	public ResponseEntity<ByteArrayResource> download(@PathVariable int photoNo) throws IOException {
		PhotoImageDto photoImageDto = photoImageDao.selectOne(photoNo);
		return fileLoadVO.download(photoImageDto.getAttachNo());
	}

	@PostMapping("/detail")
	public Map<String, Object> detail(@RequestParam int photoNo) {
		PhotoDto photoDto = photoDao.selectOne(photoNo);
		ClubMemberDto clubMemberDto = clubMemberDao.selectOne(photoDto.getClubMemberNo());
		MemberDto memberDto = memberDao.loginId(clubMemberDto.getClubMemberId());
		//MemberProfileDto memberProfileDto = memberProfileDao.profileFindOne(memberDto.getMemberId());
		Map<String, Object> params = Map.of("photoDto", photoDto, "memberName", memberDto.getMemberName(), "memberId", memberDto.getMemberId());
		return params;
	}
	
	@PostMapping("/delete")
	public void delete(@RequestParam int photoNo) {
		photoDao.delete(photoNo);
	}
	
	//좋아요를 했는지 체크
	@RequestMapping("/check")
	public PhotoLikeVO check(@RequestParam int clubNo,
			@RequestParam int photoNo, HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
		int clubMemberNo = clubMemberDto.getClubMemberNo();
		
		PhotoLikeDto photoLikeDto = new PhotoLikeDto();
		photoLikeDto.setClubMemberNo(clubMemberNo);
		photoLikeDto.setPhotoNo(photoNo);
		//log.debug("clubNo = {}", clubNo);
		//log.debug("memberId = {}", memberId);
		//log.debug("photoNo = {}", photoNo);
		//log.debug("clubMemberNo = {}", clubMemberNo);
		
		boolean isCheck = photoLikeDao.check(photoNo, clubMemberNo);
		//log.debug("isCheck = {}", isCheck);
		int count = photoLikeDao.count(photoNo);
		//log.debug("count = {}", count);
		
		PhotoLikeVO vo = new PhotoLikeVO();
		vo.setCheck(isCheck);
		vo.setCount(count);
		//log.debug("vo = {}", vo);
		
		return vo;
	}
	
	@RequestMapping("/action")
	public PhotoLikeVO action(HttpSession session, @RequestParam int photoNo, @RequestParam int clubNo) {
		String memberId = (String) session.getAttribute("name");
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
		int clubMemberNo = clubMemberDto.getClubMemberNo();
		
		//Dto에 저장되어있는지 여부
		boolean isCheck = photoLikeDao.check(photoNo, clubMemberNo);
		
		if(isCheck) {//좋아요를 했다면
			photoLikeDao.deleteByClubMemberNo(clubMemberNo); //체크를 해제
			photoDao.update(photoNo);
			//log.debug("했으니까 해제함");
		}
		else {
			PhotoLikeDto photoLikeDto = new PhotoLikeDto();
			photoLikeDto.setClubMemberNo(clubMemberNo);
			photoLikeDto.setPhotoNo(photoNo);
			photoLikeDao.insert(photoLikeDto);
			photoDao.update(photoNo);
			//log.debug("안했으니까 추가");
		}
		int count = photoLikeDao.count(photoNo);
		
		PhotoLikeVO vo = new PhotoLikeVO();
		vo.setCheck(!isCheck); //좋아요 안했다
		vo.setCount(count);
		return vo;
	}
	
	
}
