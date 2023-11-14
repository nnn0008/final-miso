package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MemberDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	MemberDto loginId(String memberId, String memberPw);
	public MemberDto selectOne(String memberId);
	List<MemberDto> memberIdListByEmail(String memberName, String memberEmail);
}