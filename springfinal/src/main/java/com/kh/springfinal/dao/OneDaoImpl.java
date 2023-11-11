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
	public List<OneDto> searchMember(String oneMember) {
		return sqlSession.selectList("one.findByOneMember",oneMember);
	}

	@Override
	public List<OneDto> searchTitle(String oneTitle) {
		return sqlSession.selectList("one.findByOneTitle",oneTitle);
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
	public List<OneDto> selectByOneMember(String oneMember) {
		return sqlSession.selectOne("one.findByOneMember",oneMember);
	}

	@Override
	public List<OneDto> selectByOneTitle(String oneTitle) {
		return sqlSession.selectOne("one.findByOneTitle",oneTitle);
	}

	



	



}