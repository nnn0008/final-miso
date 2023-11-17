package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.PhotoImageDto;

public interface PhotoImageDao {
	void insert(PhotoImageDto photoImageDto);
	PhotoImageDto selectOne(int photoNo);
	List<PhotoImageDto> selectList(int clubBoardNo);
	boolean delete(int photoNo);
}
