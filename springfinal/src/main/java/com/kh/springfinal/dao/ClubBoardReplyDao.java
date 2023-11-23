package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubBoardReplyDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.vo.ClubBoardReplyMemberVO;

public interface ClubBoardReplyDao {
	int sequence();
	void insert(ClubBoardReplyDto clubBoardReplyDto);
	List<ClubBoardReplyDto> selectList(int clubBoardNo);
	ClubBoardReplyDto selectOne(int clubBoardReplyNo);
	boolean delete(int clubBoardReplyNo);
	boolean edit(int clubBoardReplyNo, String clubBoardReplyContent);
	ClubMemberDto selectOne(int clubNo, String clubMemberId);
	
	//마이페이지에서 쓸 모든 댓글 리스트
	List<ClubBoardDto> selectReplyByMember(String memberId);
	
	//답글까지 생각해서 만들기
	List<ClubBoardReplyDto> selectListByReply(int clubBoardNo);
	
	//알림 부분
	ClubBoardReplyMemberVO selectBoardReplyMember(int clubBoardReplyNo);
}
