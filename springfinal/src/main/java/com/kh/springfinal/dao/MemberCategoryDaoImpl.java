package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.MemberCategoryDto;

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
		sqlSession.selectList("memberCategory.fineLikeCategory", memberId);
		return null;
	}

	@Override
	public boolean deleteLikeCategory(String memberId) {
		int count =sqlSession.delete("memberCategory.deleteLikeCategory", memberId);
		boolean result = count>0;
		return result;
	}

}
