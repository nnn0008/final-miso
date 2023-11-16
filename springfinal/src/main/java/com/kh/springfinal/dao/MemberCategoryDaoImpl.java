package com.kh.springfinal.dao;

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
		sqlSession.insert("memberCategory", memberCategoryDto);
	}

}
