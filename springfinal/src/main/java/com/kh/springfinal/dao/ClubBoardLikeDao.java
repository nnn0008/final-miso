package com.kh.springfinal.dao;

import com.kh.springfinal.dto.ClubBoardLikeDto;

public interface ClubBoardLikeDao {
	void insert(ClubBoardLikeDto clubBoardLikeDto);
	boolean delete(int clubBoardNo);
	boolean deleteByClubMemberNo(int clubMemberNo);
	//ClubBoardLikeDto selectOne(int clubBoardNo);
	int count(int clubBoardNo);
	boolean check(ClubBoardLikeDto clubBoardLikeDto);
}
