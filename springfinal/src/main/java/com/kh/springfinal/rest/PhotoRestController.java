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
		Map<String, Object> params = Map.of("photoDto", photoDto, "memberDto", memberDto);
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
			photoLikeDao.delete(photoNo); //체크를 해제
		}
		else {
			PhotoLikeDto photoLikeDto = new PhotoLikeDto();
			photoLikeDto.setClubMemberNo(clubMemberNo);
			photoLikeDto.setPhotoNo(photoNo);
			photoLikeDao.insert(photoLikeDto);
		}
		int count = photoLikeDao.count(photoNo);
		
		PhotoLikeVO vo = new PhotoLikeVO();
		vo.setCheck(!isCheck); //좋아요 안했다
		vo.setCount(count);
		return vo;
	}
	
	
	
//	@PostMapping("/like")
//	public String like(HttpSession session, @RequestParam int photoNo,
//			@RequestParam int clubNo) {
//		//로그인 한 회원과 관련된 처리
//		String memberId = (String)session.getAttribute("name");
//		ClubMemberDto loginClubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
//		
//		//기존 사진과 관련된 처리
//		PhotoDto photoDto = photoDao.selectOne(photoNo);
//		int clubMemberNo = photoDto.getClubMemberNo();
//		ClubMemberDto clubMemberDto = clubMemberDao.selectOne(clubMemberNo);
//		PhotoLikeDto photoLikeDto = photoLikeDao.selectOne(photoNo);
//		
////		boolean isLike = 
////				loginClubMemberDto.getClubMemberNo();
//		
//		//3가지로 판단
//		//1. 로그인한 회원과 글 작성자가 동일하다면 하트 버튼을 눌러도 아무일도 일어나선 안된다
//		//2. 서로 다르고 좋아요를 한 적이 없다면 빈 하트를 눌렀을 때, 좋아요 수를 1개 올리고 좋아요 수 카운트 계산
//		//3. 서로 다르고 좋아요를 한 글이라면 꽉 찬 하트를 눌렀을 때, 좋아요 수를 1개 감소시키고 좋아요 수 카운트 계산
//		if(memberId.equals(clubMemberDto.getClubMemberId())) {
//			return "2"; //꽉 찬 하트 + 버튼 클릭을 못하게 해야한다
//		}
////		else if() { //좋아요를 한 적이 없다
////			
////		}
////		else {
////			
////		}
//		
//		
//	}
	
	
}
