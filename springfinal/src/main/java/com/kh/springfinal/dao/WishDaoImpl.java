package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}
