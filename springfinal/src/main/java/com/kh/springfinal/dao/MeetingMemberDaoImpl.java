package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	@Override
	public boolean didAttend(int meetingNo, int clubMemberNo) {
		
		Map<String, Object> params = new HashMap<>();
		
		params.put("meetingNo", meetingNo);
		params.put("clubMemberNo", clubMemberNo);
		
		int result = sqlSession.selectOne("meetingMember.didAttend",params);
		
		return  result>0;
	}
	@Override
	public boolean deleteAttend(int meetingNo, int clubMemberNo) {
		
			Map<String, Object> params = new HashMap<>();
		
		params.put("meetingNo", meetingNo);
		params.put("clubMemberNo", clubMemberNo);
		
		int result = sqlSession.delete("meetingMember.deleteAttend",params);
		
		return result>0;
	}
	@Override
	public int attendCount(int meetingNo) {
		
		
		return sqlSession.selectOne("meetingMember.attendCount",meetingNo);
	}
}
