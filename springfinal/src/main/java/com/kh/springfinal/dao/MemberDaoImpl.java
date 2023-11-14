package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.configuration.EncryConfiguration;
import com.kh.springfinal.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository
public class MemberDaoImpl implements MemberDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	@Override
	public void join(MemberDto memberDto) {
		String memberPw = memberDto.getMemberPw();
		String encrypt = encoder.encode(memberPw);
		memberDto.setMemberPw(encrypt);
		sqlSession.insert("member.join", memberDto);
	}
	@Override
	public MemberDto loginId(String memberId) {
		MemberDto memberDto = sqlSession.selectOne("member.memberFind", memberId);
		return memberDto;
	}

	@Override
	public MemberDto selectOne(String memberId, String memberPw) {
		MemberDto memberDto = sqlSession.selectOne("member.loginId", memberId);
		String originPw = memberDto.getMemberPw();
		if(memberDto != null) {
			boolean result = encoder.matches(memberPw, originPw);
			if(result == true) {
				memberDto.setMemberPw(memberPw);
				return memberDto;
			}
		}
		return null;
	}
	
	@Override
	public List<MemberDto> memberIdListByEmail(String memberName, String memberEmail) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberName", memberName);
		params.put("memberEmail", memberEmail);
		List<MemberDto> idList = sqlSession.selectList("member.memberIdListByEmail", params);
		return idList;
	}
	@Override
	public MemberDto changePw(String memberId) {
		MemberDto memberDto = sqlSession.selectOne("member.loginId", memberId);
		String originPw = memberDto.getMemberPw();
		if(memberDto != null) {
				memberDto.setMemberPw(originPw);
				return memberDto;
			}
		return null;
	}
}
