package com.kh.springfinal.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ReportDto;

@Repository
public class ReportDaoImpl implements ReportDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ReportDto reportDto) {
		sqlSession.insert("report.insert", reportDto);
	}

}
