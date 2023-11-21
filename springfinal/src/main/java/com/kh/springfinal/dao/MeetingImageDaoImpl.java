package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.MeetingImageDto;

@Repository
public class MeetingImageDaoImpl implements MeetingImageDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(int attachNo,int meetingNo) {
		
		Map<String,Object> params = new HashMap<>();	
		
		params.put("attachNo", attachNo);
		params.put("meetingNo", meetingNo);
		
		sqlSession.insert("meetingImage.add", params);
	}
	@Override
	public boolean delete(int meetingNo) {
		return sqlSession.update("meetingImage.remove", meetingNo) > 0;
	}
	@Override
	public MeetingImageDto selectOne(int meetingNo) {
		return sqlSession.selectOne("meetingImage.find", meetingNo);
	}
	@Override
	public List<MeetingImageDto> selectList() {
		return sqlSession.selectList("meetingImage.findAll");
	}
}
