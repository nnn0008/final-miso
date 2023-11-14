package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.vo.ClubMemberVO;

public interface ClubMemberDao {
	
	ClubMemberDto selectOne(int clubMemberNo);
	
	void insert(ClubMemberDto clubMemberDto);
	
	int sequence();
	
	boolean existMember(int clubNo,String memberId);
	
	List<ClubMemberDto> memberList(int clubNo);
	
	List<ClubMemberVO> memberInfo(int clubNo);

}
