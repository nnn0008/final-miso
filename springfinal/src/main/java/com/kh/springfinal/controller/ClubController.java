package com.kh.springfinal.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springfinal.dao.CategoryDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.dto.ZipCodeDto;

@Controller
@RequestMapping("/club")
public class ClubController {
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private ZipCodeDao zipDao;
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@GetMapping("/insert")
	public String insert(Model model) {
		
		
		List<MajorCategoryDto> majorList = categoryDao.majorcategoryList();
//		List<ZipCodeDto> zipList = zipDao.list();
		
		model.addAttribute("majorCategory",majorList);
//		model.addAttribute("zipList",zipList);
		 
		return "club/insert";
		
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute ClubDto clubDto,
			HttpSession session) {
		
		
		String memberId = (String) session.getAttribute("name");
		int clubNo = clubDao.sequence();

		clubDto.setClubNo(clubNo);
		clubDto.setClubOwner(memberId);

		return "redirect:/";
		
	}
	
	
	
	
	

}
