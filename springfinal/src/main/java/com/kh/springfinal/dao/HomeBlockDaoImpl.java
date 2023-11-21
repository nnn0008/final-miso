package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.HomeBlockDto;

@Repository
public class HomeBlockDaoImpl implements HomeBlockDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void addBlock(String memberId) {
		sqlSession.insert("homeBlock.addBlock", memberId);
	}

	@Override
	public List<HomeBlockDto> selectListBlock() {
		List<HomeBlockDto> blockList = sqlSession.selectList("homeBlock.selectListBlock");
		return blockList;
	}

	@Override
	public void deleteBlock(String memberId) {
		sqlSession.delete("homeBlock.deleteBlock", memberId);
	}
	
}
