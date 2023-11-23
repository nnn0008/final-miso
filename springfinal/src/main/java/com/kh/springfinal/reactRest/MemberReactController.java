package com.kh.springfinal.reactRest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.MemberDto;

//@CrossOrigin
@CrossOrigin(value = {"http://localhost:3000", "http://localhost:5500"})
@RestController
@RequestMapping("/memberList")
public class MemberReactController {
	
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/")
	public List<MemberDto> selectListOld() {
		return memberDao.selectListOld();
	}
}
