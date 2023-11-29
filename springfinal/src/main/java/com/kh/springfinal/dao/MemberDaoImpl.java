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
import com.kh.springfinal.dto.MemberEditDto;

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
	public boolean changePw(String memberId, String memberPw) {
		MemberDto memberDto = sqlSession.selectOne("member.loginId", memberId);
		if(memberDto != null) {
			String encrypt = encoder.encode(memberPw);
			memberDto.setMemberPw(encrypt);
			int count = sqlSession.update("member.changePw", memberDto);
			boolean result =  count>0;
			return result;
		}
		return false;
	}
	@Override
	public List<MemberDto> selectListOld() {
		return sqlSession.selectList("member.memberListByOld");
	}
	@Override
	public List<MemberDto> selectListNew() {
		return sqlSession.selectList("member.memberListByNew");
	}
	@Override
	public boolean memberEdit(MemberEditDto memberDto) {
		int count = sqlSession.update("member.memberEdit", memberDto);
		boolean result = count>0;
		return result;
	}
	@Override
	public boolean memberEditSelf(MemberDto memberDto) {
			int count = sqlSession.update("member.memberEditSelf", memberDto);
			boolean result = count>0;
		return result;
	}
	@Override
	public boolean deleteMember(String memberId) {
		int count = sqlSession.delete("member.deleteMember", memberId);
		boolean result =  count>0;
		return result;
  }
  
  @Override
  public boolean updateLevel(String memberId) {
		return sqlSession.update("member.updateLevel",memberId)>0;
	}
	
	@Override
	public boolean updateDownLevel(String memberId) {
		return sqlSession.update("member.updateDownLevel",memberId)>0;
	}
	
	@Override
	public boolean schedulerMember(String memberId) {
		return sqlSession.update("member.schedulerMember",memberId)>0;
	}
	
	@Override
	public MemberDto memberFindId(String memberId) {
		return sqlSession.selectOne("member.memberFindId",memberId);
	}
}