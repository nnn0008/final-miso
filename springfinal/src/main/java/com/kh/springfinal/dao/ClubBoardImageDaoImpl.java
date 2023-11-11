package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ClubBoardImageDto;

@Repository
public class ClubBoardImageDaoImpl implements ClubBoardImageDao{
	@Autowired
	private SqlSession sqlSession;
	
//	@Autowired
//	private JdbcTemplate jdbcTemplate;
//	
//	@Override
//	public void insert(ClubBoardImageDto clubBoardImageDto) {
//		String sql = "insert into club_board_image(attach_no, club_board_no)"
//				+ "values(?, ?)";
//		Object[] data = {clubBoardImageDto.getAttachNo(), clubBoardImageDto.getClubBoardNo()};
//		jdbcTemplate.update(sql, data);
//	}
	
	@Override
	public void insert(ClubBoardImageDto clubBoardImageDto) {
		sqlSession.insert("clubBoardImage1.add", clubBoardImageDto);
	}
	
	@Override
	public boolean delete(int clubBoardNo) {
		return sqlSession.delete("clubBoradImage1.remove", clubBoardNo) > 0;
	}
	
	@Override
	public ClubBoardImageDto selectOne(int clubBoardNo) {
		return sqlSession.selectOne("clubBoardImage1.find", clubBoardNo);
	}
	
	@Override
	public List<ClubBoardImageDto> selectList() {
		return sqlSession.selectList("clubBoardImage.findAll");
	}
}
