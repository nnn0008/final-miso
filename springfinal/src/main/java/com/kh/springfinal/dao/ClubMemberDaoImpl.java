package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.vo.ClubMemberVO;
import com.kh.springfinal.vo.MeetingAttendMemberVO;

@Repository
public class ClubMemberDaoImpl implements ClubMemberDao{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public ClubMemberDto selectOne(int clubMemberNo) {
		
		return sqlSession.selectOne("clubMember.detail",clubMemberNo);
	}

	@Override
	public void insert(ClubMemberDto clubMemberDto) {
		
		sqlSession.insert("clubMember.add",clubMemberDto);
		
	}

	@Override
	public int sequence() {
		
		sqlSession.selectOne("clubMember.sequence");
		return sqlSession.selectOne("clubMember.sequence");
	}

	@Override
	public boolean existMember(int clubNo, String memberId) {
		
		Map<String,Object> params = new HashMap<>();
		
		params.put("clubNo", clubNo);
		params.put("memberId", memberId);
		
		
		List<ClubMemberDto> list = sqlSession.selectList("clubMember.findJoinMember", params);
		
		return list.size()>0;
	}

	@Override
	public List<ClubMemberDto> memberList(int clubNo) {
		
		return sqlSession.selectList("clubMember.clubMemberList",clubNo);
	}

	@Override
	public List<ClubMemberVO> memberInfo(int clubNo) {
		
		return sqlSession.selectList("clubMember.memberInfo",clubNo);
	}

	@Override
	public int memberCount(int clubNo) {
		return sqlSession.selectOne("clubMember.count",clubNo);
	}

	@Override
	public boolean editPossible(int clubNo, String clubMemberId) {
		
		Map<String,Object> params = new HashMap<>();
		
		params.put("clubNo", clubNo);
		params.put("clubMemberId", clubMemberId);
		
		String memberRank =  sqlSession.selectOne("clubMember.memberRank",params);
		
		boolean editPossible = "운영진".equals(memberRank) 
				&& 
				memberRank != null;	//클럽멤버가 아니면 번호가 안 나옴

		return editPossible;
		
	}

	@Override
	public Integer findClubMemberNo(int clubNo, String memberId) {
		
		Map<String,Object> params = new HashMap<>();
		
		params.put("clubNo", clubNo);
		params.put("memberId", memberId);
		
		return sqlSession.selectOne("clubMember.findClubMemberNo",params)==null ? 0 :sqlSession.selectOne("clubMember.findClubMemberNo",params);
	}

	@Override
	public boolean isManeger(int clubMemberNo) { //editPossible이랑 사실상 같음
		
		String level = sqlSession.selectOne("clubMember.memberLevel",clubMemberNo);
		
		return level.equals("운영진") ? true : false;
	
	}

	@Override
	public List<MeetingAttendMemberVO> meetingAttendList(int meetingNo) {
		return sqlSession.selectList("clubMember.meetingAttendMember",meetingNo);
	}

	@Override
	public boolean upgradeRank(int clubMemberNo) {
		
		return sqlSession.update("clubMember.lankUpgrade",clubMemberNo)>0;
	}

//	@Override
//	public String attendMemberId(int clubMemberNo) {
//		return sqlSession.selectOne("clubMember.findMemberId",clubMemberNo);
//	}
	
	
	
	
	

}
