package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<ZipCodeDto> list(String keyword) {
		
		return sqlSession.selectList("zipcode.searchList",keyword);
	}

	@Override
	public List<ZipCodeDto> selectList(String sido,String hdong,
			String sigungu,String eupmyun,String dongName) {
		
		Map<String,Object> params = new HashMap<>();
		
		params.put("sido", sido);
		params.put("hdong", hdong);
		params.put("sigungu", sigungu);
		params.put("eupmyun", eupmyun);
		params.put("dongName", dongName);
		
		
		return sqlSession.selectList("zipcode.selectOne",params);
	}
	
	

	
	
}
