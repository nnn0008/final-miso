package com.kh.springfinal.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dto.MemberDto;

@CrossOrigin
@RestController
public class ChatRestController {
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	 @GetMapping("/getProfile")
	    public List<MemberDto> getProfile() {
		 	return chatRoomDao.selectMemberProfile();
	    }


}
