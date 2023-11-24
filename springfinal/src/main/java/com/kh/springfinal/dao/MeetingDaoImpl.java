package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.MeetingDto;
import com.kh.springfinal.vo.PaginationVO;

@Repository
public class MeetingDaoImpl implements MeetingDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("meeting.sequence");
	}
	@Override
	public void insert(MeetingDto meetingDto) {
		sqlSession.insert("meeting.add", meetingDto);
	}
	@Override
	public boolean delete(int meetingNo) {
		return sqlSession.delete("meeting.remove", meetingNo) > 0;
	}
	@Override
	public MeetingDto selectOne(int meetingNo) {
		return sqlSession.selectOne("meeting.find", meetingNo);
	}
	@Override
	public List<MeetingDto> selectList(int clubNo) {
		return sqlSession.selectList("meeting.selectByClubNo", clubNo);
	}
	@Override
	public boolean update(MeetingDto meetingDto) {
		return sqlSession.update("meeting.edit", meetingDto) > 0;
	}
	@Override
	public AttachDto findImage(int meetingNo) {
		
		return sqlSession.selectOne("meeting.findImage",meetingNo);
	}
	@Override
	public List<MeetingDto> meetingListByPage(PaginationVO vo) {
		
//		Map<String,Object> params = new HashMap<>();
//		
//		params.put("clubNo",clubNo);
//		params.put("vo",vo);
//		
		return sqlSession.selectList("meeting.meetingListByPage",vo);
	}
	@Override
	public int count(PaginationVO vo) {
		
		
		
		return sqlSession.selectOne("meeting.countListByPage", vo);
	}
	@Override
	public int count(int whereNo) {
		
		return sqlSession.selectOne("meeting.countListByPage", whereNo);
	}
}