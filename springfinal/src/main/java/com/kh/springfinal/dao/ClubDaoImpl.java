package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.vo.ClubImageVO;
import com.kh.springfinal.vo.ClubListVO;

@Repository
public class ClubDaoImpl implements ClubDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ClubDto clubDto) {
		
		sqlSession.insert("club.add",clubDto);
		
	}

	@Override
	public int sequence() {
		
		return sqlSession.selectOne("club.sequence");
		
	}

	@Override
	public List<ClubDto> list() {
		return sqlSession.selectList("club.allList");
	}
	
	@Override
	public ClubDto selectOne(String memberId) {
		return sqlSession.selectOne("club.find", memberId);
	}

	@Override
	public ClubImageVO clubDetail(int clubNo) {
		
//		ClubDto clubDto = sqlSession.selectOne("club.detail",clubNo);
		
		return sqlSession.selectOne("club.clubDetail",clubNo);

	}

	@Override
	public boolean edit(ClubDto clubDto) {
		
		
		return sqlSession.update("club.edit",clubDto)>0;
	}

	@Override
	public void connect(int clubNo, int attachNo) {
		
		Map<String,Object> params = new HashMap<>();
		
		params.put("clubNo", clubNo);
		params.put("attachNo", attachNo);
		
		sqlSession.insert("club.connect",params);
		
		
	}

	@Override
	public AttachDto findImage(int clubNo) {
		
		return sqlSession.selectOne("club.findImage",clubNo);
	}

	@Override
	public List<ClubListVO> clubList(String memberId) {
		
		return sqlSession.selectList("club.clubList",memberId);
		
	}

	@Override
	public List<ClubListVO> majorClubList
	(String memberId, int majorCategoryNo) {
		
		Map<String,Object> params = new HashMap<>();
		
		params.put("memberId", memberId);
		params.put("majorCategoryNo", majorCategoryNo);
		
		return sqlSession.selectList("club.majorClubList",params);
	}

	@Override
	public List<ClubListVO> minorClubList(String memberId, int minorCategoryNo) {
		
	Map<String,Object> params = new HashMap<>();
		
		params.put("memberId", memberId);
		params.put("minorCategoryNo", minorCategoryNo);
		
		return sqlSession.selectList("club.minorClubList",params);
		
		
	}
	
	
	
	

	
	
	

}
