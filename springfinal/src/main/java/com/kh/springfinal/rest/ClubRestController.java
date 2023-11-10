package com.kh.springfinal.rest;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.CategoryDao;
import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.MinorCategoryDto;
import com.kh.springfinal.dto.ZipCodeDto;

@CrossOrigin
@RestController
@RequestMapping("/rest")
public class ClubRestController {
		
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private ZipCodeDao zipCodeDao;
	
	@Autowired
	private CategoryDao categoeyDao;
	
	@GetMapping("/category")
	public List<MinorCategoryDto> category(@RequestParam int majorCategoryNo) {
		
		return categoeyDao.minorCategoryList(majorCategoryNo);
	
	}
	
//	@GetMapping("/zip")
//	public List<String> zipList(@RequestParam String keyword){
//		List<String> resultList = new ArrayList<>();
//		
//		List<ZipCodeDto> zipList = zipCodeDao.list(keyword);
//		
//		for(int i=0; i<zipList.size();i++) {
//			StringBuilder sb = new StringBuilder();
//			
//		sb.append(zipList.get(i).getSido());
//		sb.append(zipList.get(i).getSigungu());
//		sb.append(zipList.get(i).getEupmyun());
//		sb.append(zipList.get(i).getDoro());
//		sb.append(zipList.get(i).getBuildName());
//		sb.append(zipList.get(i).getDongName());
//		sb.append(zipList.get(i).getHdongName());
//		
//		String result = sb.toString();
//		resultList.add(result);
//		}
//
//		return resultList;
//		
//	}
	
	@GetMapping("/zip")
	public List<ZipCodeDto> zipList(@RequestParam String keyword) {
	    List<ZipCodeDto> zipList = zipCodeDao.list(keyword);
	    return zipList;
	}

}
