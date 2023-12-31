package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.dto.MinorCategoryDto;
import com.kh.springfinal.dto.ZipCodeDto;

@Repository
public class CategoryDaoImpl implements CategoryDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MajorCategoryDto> majorcategoryList() {
		
		return sqlSession.selectList("category.majorCategory");
	}

	@Override
	public List<MinorCategoryDto> minorCategoryList(int majorCategoryNo) {
		
		return sqlSession.selectList("category.minorCategory",majorCategoryNo);
	}

	@Override
	public MajorCategoryDto findMajor(int majorCategoryNo) {
		return sqlSession.selectOne("category.majorFind",majorCategoryNo);
	}

	@Override

	public String majorName(int majorCategoryNo) {
		return sqlSession.selectOne("category.majorCategoryName",majorCategoryNo);
	}

	@Override
	public String minorName(int minorCategoryNo) {
		return sqlSession.selectOne("category.minorCategoryName",minorCategoryNo);
  }
	public MinorCategoryDto selectOneMajor(int minorCategoryNo) {
		return sqlSession.selectOne("category.selectOneMajor", minorCategoryNo);

	}

	
	
	

}
