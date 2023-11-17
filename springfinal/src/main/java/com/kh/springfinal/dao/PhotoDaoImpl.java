package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.PhotoDto;

@Repository
public class PhotoDaoImpl implements PhotoDao { 
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("photo.sequence");
	}
	
	@Override
	public void insert(PhotoDto photoDto) {
		sqlSession.insert("photo.add", photoDto);
	}
	
	@Override
	public boolean delete(int photoNo) {
		return sqlSession.delete("photo.remove", photoNo) > 0;
	}
	
	@Override
	public PhotoDto selectOne(int photoNo) {
		return sqlSession.selectOne("photo.find", photoNo);
	}
	
	@Override
	public List<PhotoDto> selectList(int clubNo) {
		return sqlSession.selectList("photo.findAll", clubNo);
	}
}
