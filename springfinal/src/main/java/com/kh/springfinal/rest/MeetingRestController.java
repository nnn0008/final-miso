package com.kh.springfinal.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.MeetingDao;
import com.kh.springfinal.dao.MeetingImageDao;
import com.kh.springfinal.dao.MeetingMemberDao;

@RestController
@RequestMapping("/rest/meeting")
public class MeetingRestController {
	
	@Autowired
	private MeetingDao meetingDao;
	
	@Autowired
	private MeetingImageDao meetingImageDao;
	
	@Autowired
	private MeetingMemberDao meetingMemberDao;
	
	//@PostMapping("/insert")
}
