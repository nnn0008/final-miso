package com.kh.springfinal.rest;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.ZipCodeDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/zip")
public class ZipCodeSearchRestController {
	@Autowired
	private ZipCodeDao codeDao;
	
	
}
