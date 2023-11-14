package com.kh.springfinal.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardReplyDto;
import com.kh.springfinal.dto.ClubMemberDto;

@Repository
public class ClubBoardReplyDaoImpl implements ClubBoardReplyDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("clubBoardReply.sequence");
	}
	@Override
	public void insert(ClubBoardReplyDto clubBoardReplyDto) {
		sqlSession.insert("clubBoardReply.add", clubBoardReplyDto);
	}
	
	@Override
	public List<ClubBoardReplyDto> selectList(int clubBoardNo) {
		return sqlSession.selectList("clubBoardReply.findAll", clubBoardNo);
	}
	@Override
	public ClubBoardReplyDto selectOne(int clubBoardReplyNo) {
		return sqlSession.selectOne("clubBoardReply.find", clubBoardReplyNo);
	}
	
	@Override
	public boolean delete(int clubBoardReplyNo) {
		return sqlSession.delete("clubBoardReply.remove", clubBoardReplyNo) > 0;
	}
	@Override
	public boolean edit(int clubBoardReplyNo, String clubBoardReplyContent) {
		Map params = Map.of("clubBoardReplyNo", clubBoardReplyNo, "clubBoardReplyContent", clubBoardReplyContent);
		return sqlSession.update("clubBoardReply.edit", params) > 0;
	}
	
	@Override
	public ClubMemberDto selectOne(int clubNo, String clubMemberId) {
		Map params = Map.of("clubNo", clubNo, "clubMemberId", clubMemberId);
		return sqlSession.selectOne("clubBoardReply.findClubMemberNo", params);
	}
	
	@Override
	public List<ClubBoardReplyDto> selectListByReply(int clubBoardNo) {
		return sqlSession.selectList("clubBoardReply.findByReply", clubBoardNo);
	}
	
	
}
