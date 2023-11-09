package com.kh.springfinal.dao;

import com.kh.springfinal.dto.ClubMemberDto;

public interface ClubMemberDao {
	
	ClubMemberDto selectOne(int clubMemberNo);
	
	void insert(ClubMemberDto clubMemberDto);

}
