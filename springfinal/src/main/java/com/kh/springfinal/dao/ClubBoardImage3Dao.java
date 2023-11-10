package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubBoardImage3Dto;
import com.kh.springfinal.dto.ClubBoardImageDto;

public interface ClubBoardImage3Dao {
	void insert(ClubBoardImage3Dto clubBoardImage3Dto);
	boolean delete(int clubBoardNo);
	ClubBoardImage3Dto selectOne(int clubBoardNo);
	List<ClubBoardImage3Dto> selectList();
}
