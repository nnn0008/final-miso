package com.kh.springfinal.dao;

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
	public void insert(OneDto oneDto) {
		 sqlSession.insert("one.insert",oneDto);
	}

	@Override
	public void delete(int oneNo) {
		int result = sqlSession.delete("one.delete",oneNo);
		if(result == 0) return;//throw new NoTargetException();
	}

	@Override
	public List<OneDto> lsit() {
		return sqlSession.selectList("one.list");
	}

	@Override
	public void update(OneDto oneDto) {
		Map<String, Object> param = Map.of("oneNo", oneDto.getOneNo(), "oneDto",oneDto);
		int result = sqlSession.update("one.edit",param);
		if(result == 0) return;//throw new NoTargetException();
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
	public int countList(PaginationVO vo) {
	    return sqlSession.selectOne("one.countList", vo);
	}

//	@Override
//	public List<OneDto> selectListByPage(PaginationVO vo) {
//		if(vo.isSearch()) {
//			return selectListByPage(vo.getType(),vo.getKeyword(),vo.getPage());
//		}
//		else {
//			return selectListByPage(vo.getPage());
//		}
//	}

	



}
