package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubMemberDto;

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

}
