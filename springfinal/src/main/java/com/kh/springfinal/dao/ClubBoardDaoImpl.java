package com.kh.springfinal.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubMemberDto;

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
	
	@Override
	public ClubMemberDto selectOneClubMemberNo(String clubMemberId, int clubNo) {
		Map <String, Object> params = Map.of("clubNo", clubNo, "clubMemberId", clubMemberId);
		return sqlSession.selectOne("clubBoard.findClubMemberNo", params);
	}
	
	@Override
	public List<ClubBoardAllDto> selectListByPage(int page, int size, int clubNo) {
		int end = page * size;
		int begin = end - (size - 1);
		Map params = Map.of("begin", begin, "end", end, "clubNo", clubNo);
		return sqlSession.selectList("clubBoard.selectListByPage", params);
	}
	
	@Override
	public ClubBoardDto selectOne(int clubBoardNo) {
		return sqlSession.selectOne("clubBoard.find", clubBoardNo);
	}
	
	@Override
	public boolean delete(int clubBoardNo) {
		return sqlSession.selectOne("clubBoard.remove", clubBoardNo);
	}
	
}
