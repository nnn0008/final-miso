package com.kh.springfinal.reactRest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.OneDao;
import com.kh.springfinal.dto.OneDto;

@CrossOrigin(value = {"http://localhost:3000", "http://localhost:5500"})
@RestController
@RequestMapping("/react/onereq")
public class OneReactController {
	@Autowired
	private OneDao oneDao;
	
	@GetMapping("/")
	public List<OneDto> selectList(){
		return oneDao.selectList();
	}
}
