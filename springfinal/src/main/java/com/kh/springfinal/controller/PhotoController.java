package com.kh.springfinal.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dao.PhotoDao;
import com.kh.springfinal.dto.PhotoDto;

@Controller
@RequestMapping("/photo")
public class PhotoController {
	
	@Autowired
	private PhotoDao photoDao;
	
	@RequestMapping("/list")
	public String list(@RequestParam int clubNo, Model model) {
		List<PhotoDto> list = photoDao.selectList(clubNo);
		model.addAttribute("list", list);
		return "photo/list";
	}
	
}
