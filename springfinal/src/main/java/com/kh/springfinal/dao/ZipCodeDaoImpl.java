package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ZipCodeDto;

@Repository
public class ZipCodeDaoImpl implements ZipCodeDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ZipCodeDto zipCodeDto) {
		sqlSession.insert("zipcode.add", zipCodeDto);
	}

	@Override
	public List<ZipCodeDto> list() {
		
		return sqlSession.selectList("zipcode.list");
	}
	
}
