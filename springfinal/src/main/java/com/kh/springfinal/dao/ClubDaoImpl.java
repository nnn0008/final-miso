package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.MajorCategoryDto;

@Repository
public class ClubDaoImpl implements ClubDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ClubDto clubDto) {
		
		sqlSession.insert("club.add",clubDto);
		
	}

	@Override
	public int sequence() {
		
		return sqlSession.selectOne("club.sequence");
		
	}

	@Override
	public List<ClubDto> list() {
		return sqlSession.selectList("club.allList");
	}
	
	@Override
	public ClubDto selectOne(String memberId) {
		return sqlSession.selectOne("club.find", memberId);
	}

}
