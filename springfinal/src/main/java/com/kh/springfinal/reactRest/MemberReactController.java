package com.kh.springfinal.reactRest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@GetMapping("/")
	public List<MemberDto> selectListOld() {
		return memberDao.selectListOld();
	}
	
	@GetMapping("/{userId}/{password}")
	public MemberDto selectOne(@PathVariable String userId, @PathVariable String password) {
			MemberDto memberDto = memberDao.loginId(userId);
//			String memberPw  = password;
//			String originPw = memberDto.getMemberPw();
//			boolean result = encoder.matches(memberPw, originPw);
//			if(result == true) {
//				memberDto.setMemberPw(memberPw);
//				return memberDto;
//			}
			return memberDto;
	}
	
}
