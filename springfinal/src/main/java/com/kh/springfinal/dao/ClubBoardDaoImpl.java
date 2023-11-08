package com.kh.springfinal.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardDto;

@Repository
public class ClubBoardDaoImpl implements ClubBoardDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("clubBoard.sequence");
	}
	
	@Override
	public void insert(ClubBoardDto clubBoardDto) {
		sqlSession.insert("clubBoard.add", clubBoardDto);
	}
}
