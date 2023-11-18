package com.kh.springfinal.rest;

import java.io.IOException;
import java.util.List;

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

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.PhotoDao;
import com.kh.springfinal.dao.PhotoImageDao;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.PhotoDto;
import com.kh.springfinal.dto.PhotoImageDto;
import com.kh.springfinal.vo.FileLoadVO;

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
	
	@PostMapping("/insert")
	public void insert(@RequestParam MultipartFile photoImage, 
			@RequestParam int clubNo,
			HttpSession session) throws IllegalStateException, IOException {
		PhotoDto photoDto = new PhotoDto();
		int photoNo = photoDao.sequence();
		String memberId = (String)session.getAttribute("name");
		ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
		
		photoDto.setClubMemberNo(clubMemberDto.getClubMemberNo());
		photoDto.setClubNo(clubNo);
		photoDto.setPhotoNo(photoNo);
		
		photoDao.insert(photoDto);
		
		//이미지 넣기
		fileLoadVO.photoUpload(photoImage, photoNo);
	}
	
	@PostMapping("/list")
	public List<PhotoDto> list(@RequestParam int clubNo) {
		List<PhotoDto> list = photoDao.selectList(clubNo);
		return list;
	}
	
	@GetMapping("/download/{photoNo}")
	public ResponseEntity<ByteArrayResource> download(@PathVariable int photoNo) throws IOException{
		PhotoImageDto photoImageDto = photoImageDao.selectOne(photoNo);
		
		return fileLoadVO.download(photoImageDto.getAttachNo());
	}
	
	//@PostMapping("/detail")
}
