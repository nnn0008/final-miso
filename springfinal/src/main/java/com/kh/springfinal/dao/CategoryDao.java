package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.dto.MinorCategoryDto;

public interface CategoryDao {

	
	List<MajorCategoryDto> majorcategoryList();
	List<MinorCategoryDto> minorCategoryList(int majorNo);
}
