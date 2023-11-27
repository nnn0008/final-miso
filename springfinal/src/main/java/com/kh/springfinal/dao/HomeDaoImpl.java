package com.kh.springfinal.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.MeetingMemberDto;
import com.kh.springfinal.vo.HomeForMeetingMemberVO;
import com.kh.springfinal.vo.HomeForMeetingVO;
import com.kh.springfinal.vo.PaginationVO;

@Repository
public class HomeDaoImpl implements HomeDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<HomeForMeetingVO> selectList(PaginationVO vo, String memberId) {
		vo.setMemberId(memberId);
		return sqlSession.selectList("forHome.meeting", vo);
	}
	
	@Override
	public List<HomeForMeetingMemberVO> selectList() {
		return sqlSession.selectList("forHome.meetingMember");
	}
	
	@Override
	public int meetingCount(PaginationVO vo, String memberId) {
		vo.setMemberId(memberId);
		return sqlSession.selectOne("forHome.meetingCount", vo);
	}
	
	@Override
	public MeetingMemberDto selectOne(int clubMemberNo, int meetingNo) {
		Map params = Map.of("clubMemberNo", clubMemberNo, "meetingNo", meetingNo);
		return sqlSession.selectOne("forHome.checkAttend", params);
	}
	
}
