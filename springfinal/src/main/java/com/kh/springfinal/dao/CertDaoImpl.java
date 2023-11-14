package com.kh.springfinal.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.CertDto;

@Repository
public class CertDaoImpl implements CertDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(CertDto certDto) {
		sqlSession.insert("cert.insert", certDto);
		
	}

	@Override
	public boolean delete(String certEmail) {
		int count = sqlSession.delete("cert.delete", certEmail);
		boolean result =  count>0;
		return result;
	}

	@Override
	public CertDto selectOne(String certEmail) {
		CertDto certDto = sqlSession.selectOne(certEmail);
		return certDto;
	}

}