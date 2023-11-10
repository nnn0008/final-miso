package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardImageDto;

@Repository
public class ClubBoardImageDaoImpl implements ClubBoardImageDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ClubBoardImageDto clubBoardImageDto) {
		sqlSession.insert("clubBoardImage.add", clubBoardImageDto);
	}
	
	@Override
	public boolean delete(int clubBoardNo) {
		return sqlSession.delete("clubBoradImage.remove", clubBoardNo) > 0;
	}
	
	@Override
	public ClubBoardImageDto selectOne(int clubBoardNo) {
		return sqlSession.selectOne("clubBoardImage.find", clubBoardNo);
	}
	
	@Override
	public List<ClubBoardImageDto> selectList() {
		return sqlSession.selectList("clubBoardImage.findAll");
	}
}
