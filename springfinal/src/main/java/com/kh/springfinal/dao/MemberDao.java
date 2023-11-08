package com.kh.springfinal.dao;

import com.kh.springfinal.dto.MemberDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	MemberDto loginId(String memberId);
}
