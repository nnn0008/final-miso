package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubMemberDto;

public interface ClubBoardDao {
	int sequence();
	void insert(ClubBoardDto clubBoardDto);
	ClubMemberDto selectOneClubMemberNo(String memberId, int clubNo);
	List<ClubBoardAllDto> selectListByPage(int page, int size, int clubNo);
	ClubBoardAllDto selectOne(int clubBoardNo);
	boolean delete(int clubBoardNo);
	boolean updateReplyCount(int clubBoardNo);
}
