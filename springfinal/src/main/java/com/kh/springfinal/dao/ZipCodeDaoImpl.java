package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.OneDto;
import com.kh.springfinal.dto.ZipCodeDto;
import com.kh.springfinal.vo.PaginationVO;
import com.kh.springfinal.vo.ZipCodeSearchVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ZipCodeDaoImpl implements ZipCodeDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ZipCodeDto zipCodeDto) {
		sqlSession.insert("zipcode.add", zipCodeDto);
	}
	
	

	@Override
	public List<ZipCodeDto> list(String keyword) {
		
		return sqlSession.selectList("zipcode.searchList",keyword);
	}

	@Override
	public List<ZipCodeDto> selectList(String sido,String hdong,
			String sigungu,String eupmyun) {
		
		Map<String,Object> params = new HashMap<>();
		
		params.put("sido", sido);
		params.put("hdong", hdong);
		params.put("sigungu", sigungu);
		params.put("eupmyun", eupmyun);
		
		
		return sqlSession.selectList("zipcode.selectOne",params);
	}
	
	@Override
	public ZipCodeDto findZip(int zipCodeNo) {
		
		return sqlSession.selectOne("zipcode.selectByMember",zipCodeNo);
		
	}
	
	@Override
	public ZipCodeDto selectOneAddrNo(String StringmemberAddr) {
		 
	        // 주소 문자열을 단어로 나누기
	        String[] words = StringmemberAddr.split("\\s+");

	        // Address 객체에 할당
	        ZipCodeDto zipCodeDto = new ZipCodeDto();
	        if(words.length > 0 && words[0] != null) zipCodeDto.setSido(words[0]);
	        if(words.length > 1 && words[1] != null) zipCodeDto.setSigungu(words[1]);
	        if(words.length > 2 && words[2] != null) {
	        	zipCodeDto.setHdongName(words[2]);
	        	zipCodeDto.setEupmyun(words[2]);
	        	};

		
		
		return sqlSession.selectOne("zipcode.selectOne", zipCodeDto);
	}
	public List<ZipCodeDto> selectListByPage(PaginationVO vo) {
		
			List<ZipCodeDto>list=sqlSession.selectList("zipcode.selectListByPage",vo);
			
		    return list;
	}

	@Override
	public int countList(PaginationVO vo) {
	    return sqlSession.selectOne("zipcode.countListByPage", vo);
	}



	@Override
	public ZipCodeDto selectOne(int zipCodeNo) {
		return sqlSession.selectOne("zipcode.selectByZipcodeNo", zipCodeNo);
	}
	
	


	
	

	
	
}
