package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.PhotoImageDto;
@Repository
public class PhotoImageDaoImpl implements PhotoImageDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(PhotoImageDto photoImageDto) {
		sqlSession.insert("photoImage.add", photoImageDto);
	}
	
	@Override
	public PhotoImageDto selectOne(int photoNo) {
		return sqlSession.selectOne("photoImage.find", photoNo);
	}
	
	@Override
	public List<PhotoImageDto> selectList(int clubBoardNo) {
		return sqlSession.selectList("photoImage.findAll", clubBoardNo);
	}
	
	@Override
	public boolean delete(int photoNo) {
		return sqlSession.delete("photoImage.remove", photoNo) >0;
	}
}
