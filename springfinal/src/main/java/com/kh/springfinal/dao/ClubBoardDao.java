package com.kh.springfinal.dao;

import com.kh.springfinal.dto.ClubBoardDto;

public interface ClubBoardDao {
	int sequence();
	void insert(ClubBoardDto clubBoardDto);
}
