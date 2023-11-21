package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.kh.springfinal.dto.OneDto;
import com.kh.springfinal.vo.PaginationVO;

@Repository
public class OneDaoImpl implements OneDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("one.sequence");
	}

	@Override
	public void insert(OneDto oneDto) {
		 sqlSession.insert("one.insert",oneDto);
	}

	@Override
	public boolean delete(int oneNo) {
		return sqlSession.delete("one.delete",oneNo)>0;
	}

	@Override
	public List<OneDto>selectList() {
		return sqlSession.selectList("one.list");
	}

	@Override
	public boolean update(OneDto oneDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("oneNo",oneDto.getOneNo());
		params.put("oneDto",oneDto);
		return sqlSession.update("one.edit",params)>0;
	}

	

	@Override
	public OneDto selectOne(int oneNo) {
		return sqlSession.selectOne("one.find",oneNo);
	}


	@Override
	public List<OneDto> selectListByPage(PaginationVO vo) {
		
			List<OneDto>list=sqlSession.selectList("one.selectListByPage",vo);
			
		    return list;
	}

	@Override
	public int countList(PaginationVO vo) {
	    return sqlSession.selectOne("one.countListByPage", vo);
	}

	@Override
	public void insertImage(int oneNo, int attachNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("oneNo", oneNo);
		params.put("attachNo", attachNo);
		sqlSession.insert("one.insertImage",params);
		
	}

	@Override
	public boolean deleteImage(int oneNo) {
		return sqlSession.delete("one.deleteImage",oneNo)>0;
	}

	@Override
	public Integer findImage(int oneNo) {
		try {
		return sqlSession.selectOne("one.findImage",oneNo);
		}
		catch(Exception e) {
			return null;
		}
	}


	

	
	



	



}
