package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.PhotoDto;

public interface PhotoDao {
	int sequence();
	void insert(PhotoDto photoDto);
	boolean delete(int photoNo);
	PhotoDto selectOne(int photoNo);
	List<PhotoDto> selectList(int clubBoardNo);
}
