package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardLikeDto;

@Repository
public class ClubBoardLikeDaoImpl implements ClubBoardLikeDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ClubBoardLikeDto clubBoardLikeDto) {
		sqlSession.insert("clubBoardLike.add", clubBoardLikeDto);
	}
	
	@Override
	public boolean delete(int clubBoardNo) {
		return sqlSession.delete("clubBoardLike.remove", clubBoardNo) > 0;
	}
	
	@Override
	public ClubBoardLikeDto selectOne(int clubBoardNo) {
		return sqlSession.selectOne("clubBoardLike.find", clubBoardNo);
	}
	
	@Override
	public int count(int clubBoardNo) {
		return sqlSession.selectOne("clubBoardLike.count", clubBoardNo);
	}
	
	@Override
	public boolean check(ClubBoardLikeDto clubBoardLikeDto) {
		List<ClubBoardLikeDto> list = sqlSession.selectList("clubBoardLike.check", clubBoardLikeDto);
		return list.isEmpty() ? false : true;
	}
	
}
