package com.kh.springfinal.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ClubBoardDao;

@RestController
@RequestMapping("/rest/clubBoard")
public class ClubBoardLikeRestController {
	@Autowired
	private ClubBoardDao clubBoardDao;
}
