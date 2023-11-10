package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository
public class MemberDaoImpl implements MemberDao{
	@Autowired
	private SqlSession sqlSession;
	@Override
	public void join(MemberDto memberDto) {
		sqlSession.insert("member.join", memberDto);
	}
	@Override
	public MemberDto loginId(String memberId) {
		MemberDto memberDto = sqlSession.selectOne("member.loginId", memberId);
		return memberDto;
	}
	
	@Override
	public List<MemberDto> memberIdListByEmail(String memberName, String memberEmail) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberName", memberName);
		params.put("memberEmail", memberEmail);
	
		List<MemberDto> idList = sqlSession.selectList("member.memberIdListByEmail", params);
		return idList;
		
	}
}
