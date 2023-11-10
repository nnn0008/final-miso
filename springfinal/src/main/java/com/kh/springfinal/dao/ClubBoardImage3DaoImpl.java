package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardImage3Dto;

@Repository
public class ClubBoardImage3DaoImpl implements ClubBoardImage3Dao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ClubBoardImage3Dto clubBoardImage3Dto) {
		sqlSession.insert("clubBoardImage.add", clubBoardImage3Dto);
	}
	
	@Override
	public boolean delete(int clubBoardNo) {
		return sqlSession.delete("clubBoradImage.remove", clubBoardNo) > 0;
	}
	
	@Override
	public ClubBoardImage3Dto selectOne(int clubBoardNo) {
		return sqlSession.selectOne("clubBoardImage.find", clubBoardNo);
	}
	
	@Override
	public List<ClubBoardImage3Dto> selectList() {
		return sqlSession.selectList("clubBoardImage.findAll");
	}
}	
