package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubBoardReplyDto;
import com.kh.springfinal.dto.ClubMemberDto;

public interface ClubBoardReplyDao {
	int sequence();
	void insert(ClubBoardReplyDto clubBoardReplyDto);
	List<ClubBoardReplyDto> selectList(int clubBoardNo);
	ClubBoardReplyDto selectOne(int clubBoardReplyNo);
	boolean delete(int clubBoardReplyNo);
	boolean edit(int clubBoardReplyNo, String clubBoardReplyContent);
	ClubMemberDto selectOne(int clubNo, String clubMemberId);
}
