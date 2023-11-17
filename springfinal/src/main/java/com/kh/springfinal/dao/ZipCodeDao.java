package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ZipCodeDto;
import com.kh.springfinal.vo.ZipCodeSearchVO;

public interface ZipCodeDao {

	void insert(ZipCodeDto zipCodeDto);
	
	List<ZipCodeDto> list(String keyword);
	
	List<ZipCodeDto> selectList(String sido,String hdong,
			String sigungu,String eupmyun);
	ZipCodeDto findZip(int zipCodeNo);
	
	public ZipCodeDto selectOneAddrNo(String StringmemberAddr);
}
