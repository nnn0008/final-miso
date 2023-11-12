package com.kh.springfinal.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubBoardImage2Dto;
import com.kh.springfinal.dto.ClubBoardImage3Dto;
import com.kh.springfinal.dto.ClubBoardImageDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.vo.FileLoadVO;

@Controller
@RequestMapping("/clubBoard")
public class ClubBoardController {
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private FileLoadVO fileLoadVO;
	
	@GetMapping("/write")
	public String write(@RequestParam int clubNo, Model model) {
		model.addAttribute("clubNo", clubNo);
		return "clubBoard/write";
	}	
	
	@PostMapping("/write")
	public String write(@ModelAttribute ClubBoardDto clubBoardDto, @ModelAttribute MemberDto memberDto, @ModelAttribute ClubMemberDto clubMemberDto, 
			HttpSession session, @RequestParam int clubNo, @ModelAttribute ClubBoardImageDto clubBoardImageDto, @ModelAttribute ClubBoardImage2Dto clubBoardImage2Dto,
			@ModelAttribute ClubBoardImage3Dto clubBoardImage3Dto, @RequestParam MultipartFile attach,
			@RequestParam MultipartFile attachSecond, @RequestParam MultipartFile attachThird) throws Exception, IOException{
//		memberDto = memberDao.loginId((String)session.getAttribute("name")); //여기서 회원 이름을 얻어야함
//		memberDto = memberDao.loginId("testuser1"); //여기서 회원 이름을 얻어야함
		
		memberDto.setMemberId("testuser1");
		String clubMemberId = memberDto.getMemberId();
		
		int clubBoardNo = clubBoardDao.sequence();
		clubMemberDto = clubBoardDao.selectOneClubMemberNo(clubMemberId, clubNo);
		
		int clubMemberNo = clubMemberDto.getClubMemberNo();
		
		clubBoardDto.setClubBoardName(clubMemberId);
		clubBoardDto.setClubBoardNo(clubBoardNo);
		clubBoardDto.setClubMemberNo(clubMemberNo);
		clubBoardDto.setClubNo(clubNo);
		clubBoardDao.insert(clubBoardDto);
		
		clubBoardDao.insert(clubBoardDto);

		//사진 첨부
		if(!attach.isEmpty()) {
			fileLoadVO.upload(clubBoardImageDto, clubBoardImage2Dto, clubBoardImage3Dto, clubBoardNo, attach, attachSecond, attachThird);
		}

		
		return "redirect:/clubBoard/list?clubNo="+clubNo;
	}
	
	@RequestMapping("/list")
	public String list(Model model, @RequestParam int clubNo) {
		List<ClubBoardAllDto> list = clubBoardDao.selectListByPage(1, 999, clubNo);
		model.addAttribute("list", list);
		return "clubBoard/list";
	}
	
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int clubBoardNo) {
		ClubBoardAllDto clubBoardAllDto = clubBoardDao.selectOne(clubBoardNo);		
		model.addAttribute("clubBoardAllDto", clubBoardAllDto);
		return "clubBoard/detail";
	}
	
	
}