package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.vo.ClubMemberVO;

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
		
		boolean editPossible = "운영진".equals(memberRank) && memberRank != null;

		return editPossible;
		
	}
	
	
	

}
