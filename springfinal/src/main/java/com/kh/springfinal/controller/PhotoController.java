package com.kh.springfinal.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.PhotoDao;
import com.kh.springfinal.dto.PhotoDto;
import com.kh.springfinal.vo.ClubImageVO;
import com.kh.springfinal.vo.FileLoadVO;

@Controller
@RequestMapping("/photo")
public class PhotoController {
	
	@Autowired
	private PhotoDao photoDao;
	
	@Autowired
	private AttachDao attachDao;

	@Autowired
	private FileLoadVO fileLoadVO;
	
	@Autowired
	private ClubDao clubDao;
	
	@RequestMapping("/list")
	public String list(@RequestParam int clubNo, Model model) {
		List<PhotoDto> photoList = photoDao.selectList(clubNo);
		model.addAttribute("photoList", photoList);
		
		//상단 바로가기 메뉴
		ClubImageVO clubDto = clubDao.clubDetail(clubNo);		
		model.addAttribute("clubDto",clubDto);
		
		return "photo/list";
	}
	
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachNo) throws IOException{
		return fileLoadVO.download(attachNo);
	}
	
}
