package com.kh.springfinal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ZipCodeDto;
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
	        zipCodeDto.setSido(words[0]);
	        zipCodeDto.setSigungu(words[1]);
	        zipCodeDto.setHdongName(words[2]);
	        zipCodeDto.setEupmyun(words[2]);
		
		
		return sqlSession.selectOne("zipcode.selectOneMemberCN", zipCodeDto);
	}


	
	

	
	
}
