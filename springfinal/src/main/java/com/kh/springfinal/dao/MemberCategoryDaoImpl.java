package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.dto.MemberCategoryDto;
import com.kh.springfinal.dto.MinorCategoryDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberCategoryDaoImpl implements MemberCategoryDao{
	
	@Autowired
	  private SqlSession sqlSession;
	@Override
	public void insert(MemberCategoryDto memberCategoryDto) {
		sqlSession.insert("memberCategory.addCategory", memberCategoryDto);
	}

	@Override
	public List<MemberCategoryDto> selectListLike(String memberId) {
		return sqlSession.selectList("memberCategory.fineLikeCategory", memberId);
	}

	@Override
	public boolean deleteLikeCategory(String memberId) {
		int count = sqlSession.delete("memberCategory.deleteLikeCategory", memberId);
		boolean result = count>0;
		return result;
	}

	@Override
	public MinorCategoryDto findLikeminor(String memberId) {
		return sqlSession.selectOne("memberCategory.findLikeminor", memberId);
	}

	@Override
	public MajorCategoryDto findLikemajor(int minorCategoryNo) {
		return sqlSession.selectOne("memberCategory.findLikemajor", minorCategoryNo);
	}

	@Override
	public List<MinorCategoryDto> minorList() {
		return sqlSession.selectList("memberCategory.minorCategoryList");
	}

}
