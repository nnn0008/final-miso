package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.MeetingImageDto;

@Repository
public class MeetingImageDaoImpl implements MeetingImageDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(MeetingImageDto meetingImageDto) {
		sqlSession.insert("meetingImage.add", meetingImageDto);
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
