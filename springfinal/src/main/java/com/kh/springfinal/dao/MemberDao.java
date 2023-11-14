package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MemberDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	public MemberDto loginId(String memberId);
	MemberDto selectOne(String memberId, String memberPw);
	List<MemberDto> memberIdListByEmail(String memberName, String memberEmail);
	MemberDto changePw(String memberId);
	
}