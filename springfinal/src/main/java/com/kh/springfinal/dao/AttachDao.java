package com.kh.springfinal.dao;

import com.kh.springfinal.dto.AttachDto;

public interface AttachDao {
	int sequence();
	void insert(AttachDto attachDto);
	AttachDto selectOne(int attachNo);
	boolean delete(int attachNo);
}
