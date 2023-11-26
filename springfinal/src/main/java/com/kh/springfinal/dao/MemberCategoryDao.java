package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.dto.MemberCategoryDto;
import com.kh.springfinal.dto.MinorCategoryDto;

public interface MemberCategoryDao {
	void insert(MemberCategoryDto memberCategoryDto);
	List<MemberCategoryDto> selectListLike(String memberId);
	boolean deleteLikeCategory(String memberId);
	MinorCategoryDto findLikeminor(String memberId);
	MajorCategoryDto findLikemajor(int minorCategoryNo);
	
}
