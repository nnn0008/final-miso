package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MemberCategoryDto;

public interface MemberCategoryDao {
	void insert(MemberCategoryDto memberCategoryDto);
	List<MemberCategoryDto> selectListLike(String memberId);
	boolean deleteLikeCategory(String memberId);
}
