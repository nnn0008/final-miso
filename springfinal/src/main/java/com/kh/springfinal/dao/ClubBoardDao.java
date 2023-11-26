package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.vo.ClubDetailBoardListVO;
import com.kh.springfinal.vo.PaginationVO;

public interface ClubBoardDao {
	int sequence();
	void insert(ClubBoardDto clubBoardDto);
	ClubMemberDto selectOneClubMemberNo(String memberId, int clubNo);
	ClubBoardDto selectOnes(int clubBoardNo);
	ClubBoardAllDto selectOne(int clubBoardNo);
	boolean delete(int clubBoardNo);
	boolean update(ClubBoardDto clubBoardDto, int clubBoardNo);
	boolean updateReplyCount(int clubBoardNo);
	boolean updateLikeCount(int clubBoardNo);
	List<ClubDetailBoardListVO> clubDetailBoardList(int clubNo);
	List<ClubBoardAllDto> selectListByPage(PaginationVO vo, int clubNo);
	int clubBoardCount(PaginationVO vo, int clubNo);

}
