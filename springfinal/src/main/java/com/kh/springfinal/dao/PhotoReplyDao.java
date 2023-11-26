package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.PhotoReplyDto;

public interface PhotoReplyDao {
	int sequence();
	void insert(PhotoReplyDto photoReplyDto);
	boolean delete(int photoReplyNo);
	boolean update(int photoReplyNo);
	List<PhotoReplyDto> selectList(int photoNo);
	PhotoReplyDto selectOne(int photoReplyNo);
}
