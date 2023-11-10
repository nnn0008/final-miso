package com.kh.springfinal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/photo")
public class PhotoController {
	
	@GetMapping("/write")
	public String write() {
		return "photo/write";
	}
	
	@RequestMapping("/list")
	public String list() {
		return "photo/list";
	}
}
