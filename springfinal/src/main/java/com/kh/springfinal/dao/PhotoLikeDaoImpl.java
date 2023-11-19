package com.kh.springfinal.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.PhotoLikeDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository
public class PhotoLikeDaoImpl implements PhotoLikeDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(PhotoLikeDto photoLikeDto) {
		sqlSession.insert("photoLike.add", photoLikeDto);
	}
	
	@Override
	public boolean delete(int photoNo) {
		return sqlSession.delete("photoLike.remove", photoNo) > 0;
	}
	
	@Override
	public PhotoLikeDto selectOne(int photoNo) {
		return sqlSession.selectOne("photoLike.find", photoNo);
	}
	
	@Override
	public boolean check(int photoNo, int clubMemberNo) {
		Map params = Map.of("photoNo", photoNo, "clubMemberNo", clubMemberNo);
		PhotoLikeDto photoLikeDto = sqlSession.selectOne("photoLike.check", params);
		boolean result = photoLikeDto != null;
		//log.debug("result = {}" ,result);
		//log.debug("count = {}" ,count);
		return result; //true는 좋아요를 했음, false는 좋아요를 한 적이 없다
	}
	
	@Override
	public int count(int photoNo) {
		//log.debug("photoNo = {}", photoNo);
		return sqlSession.selectOne("photoLike.count", photoNo);
	}
	
	
}
