package com.kh.springfinal.dao;

import java.util.List;
import java.util.Map;

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
	public boolean deleteByClubMemberNo(int clubMemberNo) {
		return sqlSession.delete("clubBoardLike.removeByClubMemberNo", clubMemberNo) > 0;
	}
	
//	@Override
//	public ClubBoardLikeDto selectOne(int clubBoardNo) {
//		return sqlSession.selectOne("clubBoardLike.find", clubBoardNo);
//	}
	
	@Override
	public int count(int clubBoardNo) {
		return sqlSession.selectOne("clubBoardLike.count", clubBoardNo);
	}
	
	@Override
	public boolean check(ClubBoardLikeDto clubBoardLikeDto) {
		List<ClubBoardLikeDto> list = sqlSession.selectList("clubBoardLike.check", clubBoardLikeDto);
		return list.isEmpty() ? false : true;
	}
	
	@Override
	public boolean isLike(int clubMemberNo, int clubBoardNo) {
		Map params = Map.of("clubMemberNo", clubMemberNo, "clubBoardNo", clubBoardNo);
		List<ClubBoardLikeDto> list = sqlSession.selectList("clubBoardLike.check", params);
		return list.isEmpty() ? false : true;
	}
	
}
