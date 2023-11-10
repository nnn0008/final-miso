package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubBoardImageDto;

public interface ClubBoardImageDao {
	void insert(ClubBoardImageDto clubBoardImageDto);
	boolean delete(int clubBoardNo);
	ClubBoardImageDto selectOne(int clubBoardNo);
	List<ClubBoardImageDto> selectList();
}
