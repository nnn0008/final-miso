package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ReportDto;

@Repository
public class ReportDaoImpl implements ReportDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("report.sequence");
	}
	
	@Override
	public void insert(ReportDto reportDto) {
		sqlSession.insert("report.insert", reportDto);
	}

	@Override
	public List<ReportDto> selectList() {
		return sqlSession.selectList("report.selectList");
	}

	@Override
	public boolean delete(int reportNo) {
		int count = sqlSession.delete("report.delete", reportNo);
		boolean result = count>0;
		return result;
	}

}
