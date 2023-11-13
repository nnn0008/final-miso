package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.vo.ClubImageVO;

public interface ClubDao {
	
	int sequence();
	void insert(ClubDto clubDto);
	List<ClubDto> list();
	ClubDto selectOne(String memberId);
	ClubImageVO clubDetail(int clubNo);
	boolean edit(ClubDto clubDto);
	void connect(int clubNo, int attachNo);
	AttachDto findImage(int clubNo);
	
}
