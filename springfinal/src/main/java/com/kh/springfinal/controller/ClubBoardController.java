package com.kh.springfinal.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dto.ClubBoardDto;

@Controller
@RequestMapping("/clubBoard")
public class ClubBoardController {
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/clubBoard/write.jsp";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute ClubBoardDto clubBoardDto) {
		return "redirect:club?clubNo="+clubBoardDto.getClubNo()+"/clubList";
	}
}
