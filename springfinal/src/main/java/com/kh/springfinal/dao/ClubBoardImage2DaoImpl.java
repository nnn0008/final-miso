package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardImage2Dto;

@Repository
public class ClubBoardImage2DaoImpl implements ClubBoardImage2Dao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ClubBoardImage2Dto clubBoardImage2Dto) {
		sqlSession.insert("clubBoardImage2.add", clubBoardImage2Dto);
	}
	
	@Override
	public boolean delete(int clubBoardNo) {
		return sqlSession.delete("clubBoradImage2.remove", clubBoardNo) > 0;
	}
	
	@Override
	public ClubBoardImage2Dto selectOne(int clubBoardNo) {
		return sqlSession.selectOne("clubBoardImage2.find", clubBoardNo);
	}
	
	@Override
	public List<ClubBoardImage2Dto> selectList() {
		return sqlSession.selectList("clubBoardImage2.findAll");
	}
}
