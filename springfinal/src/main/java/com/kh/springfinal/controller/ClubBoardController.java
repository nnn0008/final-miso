package com.kh.springfinal.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springfinal.dao.ClubBoardDao;

@Controller
@RequestMapping("/club")
public class ClubBoardController {
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@GetMapping("/write")
	public String write(Model model) {
		return "/WEB-INF/views/club/write.jsp";
	}
}
