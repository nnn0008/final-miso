package com.kh.springfinal.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.PhotoDao;

@RestController
@RequestMapping("/rest/photo")
public class PhotoRestController {
	
	@Autowired
	private PhotoDao photoDao;
	
	@PostMapping("/insert")
	public void insert() {
		
	}
}
