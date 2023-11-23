package com.kh.springfinal.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubBoardReportDto;

@Repository
public class ClubBoardReportDaoImpl implements ClubBoardReportDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(ClubBoardReportDto clubBoardReportDto) {
		sqlSession.insert("clubBoardReport", clubBoardReportDto);
	}
	
	
}
