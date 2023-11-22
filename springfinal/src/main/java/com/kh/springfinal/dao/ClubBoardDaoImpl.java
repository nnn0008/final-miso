package com.kh.springfinal.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.vo.ClubDetailBoardListVO;

@Repository
public class ClubBoardDaoImpl implements ClubBoardDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("clubBoard.sequence");
	}
	
	@Override
	public void insert(ClubBoardDto clubBoardDto) {
		sqlSession.insert("clubBoard.add", clubBoardDto);
	}
	
	@Override
	public ClubMemberDto selectOneClubMemberNo(String clubMemberId, int clubNo) {
		Map <String, Object> params = Map.of("clubNo", clubNo, "clubMemberId", clubMemberId);
		return sqlSession.selectOne("clubBoard.findClubMemberNo", params);
	}
	
	@Override
	public List<ClubBoardAllDto> selectListByPage(int page, int size, int clubNo) {
		int end = page * size;
		int begin = end - (size - 1);
		Map params = Map.of("begin", begin, "end", end, "clubNo", clubNo);
		return sqlSession.selectList("clubBoard.selectListByPage", params);
	}
	
	@Override
	public ClubBoardDto selectOnes(int clubBoardNo) {
		return sqlSession.selectOne("clubBoard.finds", clubBoardNo);
	}
	
	@Override
	public ClubBoardAllDto selectOne(int clubBoardNo) {
		return sqlSession.selectOne("clubBoard.find", clubBoardNo);
	}
	
	@Override
	public boolean delete(int clubBoardNo) {
		return sqlSession.delete("clubBoard.remove", clubBoardNo) > 0;
	}
	
	@Override
	public boolean update(ClubBoardDto clubBoardDto, int clubBoardNo) {
		Map params = Map.of("clubBoardNo", clubBoardNo, "clubBoardDto", clubBoardDto);
		return sqlSession.update("clubBoard.editUnit", params) > 0;
	}
	
	@Override
	public boolean updateReplyCount(int clubBoardNo) {
		return sqlSession.update("clubBoard.replyCount", clubBoardNo) > 0;
	}
	
	@Override
	public boolean updateLikeCount(int clubBoardNo) {
		return sqlSession.update("clubBoard.updateLikeCount", clubBoardNo) > 0;
	}

	@Override
	public List<ClubDetailBoardListVO> clubDetailBoardList(int clubNo) {
		return sqlSession.selectList("clubBoard.clubDetailBoardList",clubNo);
	}
}
