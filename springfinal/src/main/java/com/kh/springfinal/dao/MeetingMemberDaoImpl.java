package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.MeetingMemberDto;

@Repository
public class MeetingMemberDaoImpl implements MeetingMemberDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(MeetingMemberDto meetingMemberDto) {
		sqlSession.insert("meetingMember.add", meetingMemberDto);
	}
	@Override
	public boolean delete(int meetingNo) {
		return sqlSession.delete("meetingMember.remove", meetingNo) > 0;
	}
	@Override
	public MeetingMemberDto selectOne(int meetingNo) {
		return sqlSession.selectOne("meetingMember.find", meetingNo);
	}
	@Override
	public List<MeetingMemberDto> selectList() {
		return sqlSession.selectList("meetingMember.findAll");
	}
}
