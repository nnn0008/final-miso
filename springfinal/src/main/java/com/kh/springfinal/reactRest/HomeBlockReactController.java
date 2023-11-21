package com.kh.springfinal.reactRest;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.HomeBlockDao;
import com.kh.springfinal.dto.HomeBlockDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin(value = {"http://localhost:3000", "http://localhost:5500"})
@RestController
@RequestMapping("/memberBlock")
public class HomeBlockReactController {
	@Autowired
	private HomeBlockDao blockDao;
	
	@PostMapping("/{memberId}")
	public void addBlock(@PathVariable String memberId) {
		blockDao.addBlock(memberId);
	}
	
	@GetMapping("/")
	public List<HomeBlockDto> selectListBlock(){
		return blockDao.selectListBlock();
	}
	
	@DeleteMapping("/{memberId}")
	public void deleteBlock(@PathVariable String memberId) {
		blockDao.deleteBlock(memberId);
	}
	
}
