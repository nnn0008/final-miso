package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubBoardImage2Dto;
import com.kh.springfinal.dto.ClubBoardImageDto;

public interface ClubBoardImage2Dao {
	void insert(ClubBoardImage2Dto clubBoardImage2Dto);
	boolean delete(int clubBoardNo);
	ClubBoardImage2Dto selectOne(int clubBoardNo);
	List<ClubBoardImage2Dto> selectList();
}
