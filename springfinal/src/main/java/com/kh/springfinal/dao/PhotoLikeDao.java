package com.kh.springfinal.dao;

import com.kh.springfinal.dto.PhotoLikeDto;

public interface PhotoLikeDao {
	void insert(PhotoLikeDto photoLikeDto);
	boolean delete(int photoNo);
	boolean deleteByClubMemberNo(int clubMemberNo);
	PhotoLikeDto selectOne(int photoNo);
	boolean check(int photoNo, int clubMemberNo);
	int count(int photoNo);
}
