package com.kh.springfinal.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.HomeDao;
import com.kh.springfinal.dao.MeetingMemberDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.WishlistDao;
import com.kh.springfinal.vo.FileLoadVO;
import com.kh.springfinal.vo.HomeForClubVO;
import com.kh.springfinal.vo.HomeForMeetingMemberVO;
import com.kh.springfinal.vo.HomeForMeetingVO;
import com.kh.springfinal.vo.WishlistVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class HomeController {
	@Autowired
	private WishlistDao wishlistDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private ClubDao clubDao;
	@Autowired
	private ClubMemberDao clubMemberDao;
	@Autowired
	private FileLoadVO fileLoadVO;
	@Autowired
	private HomeDao homeDao;
	@Autowired
	private MeetingMemberDao meetingMemberDao;
	//http://localhost:8080/
	
	@RequestMapping("/")
	public String home(Model model, HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		
		List<WishlistVO> wishList = wishlistDao.selectListForHome(memberId);
		List<HomeForClubVO> joinList = clubMemberDao.selectListByMemberId(memberId);
//		List<HomeForMeetingVO> meetingList = homeDao.selectList(memberId);	
		List<HomeForMeetingMemberVO> memberList = homeDao.selectList();
		
		model.addAttribute("wishList", wishList);
		model.addAttribute("joinList", joinList);
//		model.addAttribute("meetingList", meetingList);
		model.addAttribute("memberList", memberList);
		
		log.debug("wishlist ={}",wishList);
		log.debug("joinlist ={}", joinList);
//		log.debug("updateList = {}", updateList);
		log.debug("memberList = {}", memberList);
		return "home";
	}
	
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachNo) throws IOException{
		log.debug("attachNo={}",attachNo);
		return fileLoadVO.download(attachNo);
	}
	
	
}
