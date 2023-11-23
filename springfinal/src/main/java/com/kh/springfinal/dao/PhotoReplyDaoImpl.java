package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.PhotoReplyDto;

@Repository
public class PhotoReplyDaoImpl implements PhotoReplyDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("photoReply.sequence");
	}
	
	@Override
	public void insert(PhotoReplyDto photoReplyDto) {
		sqlSession.insert("photoReply.add", photoReplyDto);
	}
	
	@Override
	public boolean delete(int photoReplyNo) {
		return sqlSession.delete("photoReply.remove", photoReplyNo) > 0;
	}
	
	@Override
	public boolean update(int photoReplyNo) {
		return sqlSession.update("photoReply.edit", photoReplyNo) > 0;
	}
	
	@Override
	public List<PhotoReplyDto> selectList(int photoNo) {
		return sqlSession.selectList("photoReply.list", photoNo);
	}
	
	@Override
	public PhotoReplyDto selectOne(int photoReplyNo) {
		return sqlSession.selectOne("photoReply.find", photoReplyNo);
	}
}

