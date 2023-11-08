package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ZipCodeDto;

public interface ZipCodeDao {

	void insert(ZipCodeDto zipCodeDto);
	
	List<ZipCodeDto> list();
}
