package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ZipCodeDto;
import com.kh.springfinal.vo.ZipCodeSearchVO;

public interface ZipCodeDao {

	void insert(ZipCodeDto zipCodeDto);
	List<ZipCodeDto> selectList(String searchVal);
	
		
	
}
