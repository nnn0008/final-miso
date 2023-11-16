package com.kh.springfinal.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.MemberProfileDto;

@Repository
public class MemberProfileDaoImpl implements MemberProfileDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void profileUpload(MemberProfileDto profileDto) {
		sqlSession.insert("memberProfile.profileUpload", profileDto);
	}

	@Override
	public AttachDto profileFindOne(String memberId) {
		AttachDto AttachDto = sqlSession.selectOne("memberProfile.profileFindOne",memberId);
		return AttachDto;
	}

	@Override
	public boolean profileDelete(String memberId, int attachNo) {
		
		int count=sqlSession.delete("memberProfile.profileDelete", Map.of("memberId", memberId, "attachNo", attachNo));
		boolean result = count>0;
		return result;
	}

}
