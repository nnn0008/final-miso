package com.kh.springfinal.rest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/member")
public class MemberRestController {
	@Autowired
	private MemberDao memberDao;
	
	@PostMapping("/checkId")
	public String checkId(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.loginId(memberId);
		if(memberDto != null) {
			return "Y";
		}
		else {
			return "N";
		}
	}
	
	
	
}
