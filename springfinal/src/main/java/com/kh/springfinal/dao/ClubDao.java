package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.MajorCategoryDto;

public interface ClubDao {
	
	int sequence();
	void insert(ClubDto clubDto);
	List<ClubDto> list();
	ClubDto selectOne(String memberId);
}
