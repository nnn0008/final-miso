package com.kh.springfinal.dao;

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

}
