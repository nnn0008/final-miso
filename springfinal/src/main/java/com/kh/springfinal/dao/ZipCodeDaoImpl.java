package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ZipCodeDto;
import com.kh.springfinal.vo.ZipCodeSearchVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ZipCodeDaoImpl implements ZipCodeDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ZipCodeDto zipCodeDto) {
		sqlSession.insert("zipcode.add", zipCodeDto);
	}
	//시도 조회 구문
	@Override
	public List<ZipCodeDto> selectList(String searchVal) {
		return sqlSession.selectList("zipcode.addrSeachList", searchVal);
	}
	
	
	
}
