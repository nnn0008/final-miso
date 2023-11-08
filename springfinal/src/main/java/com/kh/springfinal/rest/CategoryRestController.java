package com.kh.springfinal.rest;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dto.MinorCategoryDto;

@CrossOrigin
@RestController
@RequestMapping("/rest")
public class CategoryRestController {
		
	@Autowired
	private SqlSession sqlSession;
	
	@GetMapping("/category")
	public List<MinorCategoryDto> category(int majorCategoryNo) {
		
		return sqlSession.selectList("category.minorCategory", majorCategoryNo);
		
		
		
		
	}

}
