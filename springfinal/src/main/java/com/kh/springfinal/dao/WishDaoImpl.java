package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.WishlistDto;
import com.kh.springfinal.vo.WishlistVO;

@Repository
public class WishDaoImpl implements WishlistDao{
	
	@Autowired
	private SqlSession sqlSession;
	

	@Override
	public void insert(String memberId, int clubNo) {
		
		Map<String,Object> params = new HashMap<>();
		
		params.put("memberId", memberId);
		params.put("clubNo", clubNo);
		
		sqlSession.insert("wish.add",params);
		
		
	}


	@Override
	public boolean delete(String memberId, int clubNo) {
		Map<String,Object> params = new HashMap<>();
		
		params.put("memberId", memberId);
		params.put("clubNo", clubNo);
		
		return sqlSession.delete("wish.cancel",params)>0;
	}


	@Override
	public boolean doLike(String memberId, int clubNo) {
		Map<String,Object> params = new HashMap<>();
		
		params.put("memberId", memberId);
		params.put("clubNo", clubNo);
		
		int result = sqlSession.selectOne("wish.doLike",params);
		
		return result>0;
	}

	
	@Override
	public List<WishlistVO> selectListForHome(String memberId) {
		List<WishlistVO> list = sqlSession.selectList("wish.findAllByMemberId",memberId);
		return list;
	}
	@Override
	public List<WishlistVO> selectListForMypage(String memberId, int endRow) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memberId", memberId);
        paramMap.put("endRow", endRow);
        
        List<WishlistVO> list = sqlSession.selectList("wish.findAllByMypage", paramMap);
        return list;
    }
}
