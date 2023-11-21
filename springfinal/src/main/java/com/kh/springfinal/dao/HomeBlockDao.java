package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.HomeBlockDto;

public interface HomeBlockDao {
	void addBlock(String memberId);
	List<HomeBlockDto> selectListBlock();
	void deleteBlock(String memberId);
}
