package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MemberDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	public MemberDto selectOne(String memberId);
	MemberDto loginId(String memberId, String memberPw);
	List<MemberDto> memberIdListByEmail(String memberName, String memberEmail);
	MemberDto changePw(String memberId);
	
}