package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.dto.MinorCategoryDto;
import com.kh.springfinal.dto.ZipCodeDto;

public interface CategoryDao {

	
	List<MajorCategoryDto> majorcategoryList();
	List<MinorCategoryDto> minorCategoryList(int majorNo);
	MajorCategoryDto findMajor(int majorCategoryNo);
	
	String majorName(int majorCategoryNo);
	String minorName(int minorCategoryNo);
	
}
