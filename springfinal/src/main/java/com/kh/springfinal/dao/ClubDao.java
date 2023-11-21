package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.vo.ClubImageVO;
import com.kh.springfinal.vo.ClubListVO;

public interface ClubDao {
	
	int sequence();
	void insert(ClubDto clubDto);
	List<ClubDto> list();
	ClubDto selectOne(String memberId);
	ClubImageVO clubDetail(int clubNo);
	boolean edit(ClubDto clubDto);
	void connect(int clubNo, int attachNo);
	AttachDto findImage(int clubNo);
	List<ClubListVO> clubList(String memberId);
	List<ClubListVO> majorClubList(String memberId, int majorCategoryNo);
	List<ClubListVO> minorClubList(String memberId, int minorCategoryNo);
	
}
